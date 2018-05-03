import os
from ..checkers import *
from ..main import app
from flask import jsonify, request, send_file

@app.route('/')
def index_route():
    return send_file("../static/index.html")

@app.route('/new')
def new():
	b = Board(True)
	return jsonify(boardtojson(b))


@app.route('/solve', methods=['POST'])
def solve():
	result = request.get_json()
	jsontoboard(result, False).bprint()
	all_white_moves = get_moves(jsontoboard(result, False))
	new_b = alphabetapicker(all_white_moves)
	new_b.bprint()
	return json.dumps(boardtojson(new_b))
