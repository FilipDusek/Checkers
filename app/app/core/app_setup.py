from ..main import app

from .board import Board
from .search import alphabetapicker

from flask import jsonify, request, send_file
import os 
from .utils.utils import *

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