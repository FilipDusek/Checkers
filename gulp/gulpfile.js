var gulp = require('gulp');
var uglify = require('gulp-uglify');
var concat = require('gulp-concat');
var sass = require('gulp-sass');
var es = require('event-stream');

var srcPath = '../app/static-src/';
var distPath = '../app/static/';

gulp.task('default', ['copy', 'scripts', 'sass']);

gulp.task('scripts', function () {
	return gulp.src([
		srcPath + 'js/vendor/jquery*.js',
		srcPath + 'js/vendor/**.js',
		srcPath + 'js/**.js',
	])
	.pipe(concat('all.min.js'))
	.pipe(uglify())
	.pipe(gulp.dest(distPath + 'js/'));
});

gulp.task('sass', function () {
  return gulp.src([
  	srcPath + 'sass/vendor/**.scss',
  	srcPath + 'sass/**.scss'
  	])
    .pipe(sass({outputStyle: 'compressed'})
    .on('error', sass.logError))
    .pipe(concat('all.min.css'))
    .pipe(gulp.dest(distPath + 'css/'));
});

gulp.task('copy', ['sass', 'scripts'], function(){
	return gulp.src([
		srcPath + "index.html",
		srcPath + '**',
		'!' + srcPath + 'static-src/{sass,sass/**}',
		'!' + srcPath + 'app/static-src/{js,js/**}'
		])
	.pipe(gulp.dest(distPath));
})

gulp.task('watch', function(){
	var jsfiles = srcPath + 'js/**.js';
	var scssfiles = srcPath + 'sass/**.scss';

	gulp.watch(jsfiles, ['scripts']);
	gulp.watch(scssfiles, ['sass']);
	gulp.watch([
		srcPath + "**",
		'!' + jsfiles, 
		'!' + scssfiles], ['copy']);
})