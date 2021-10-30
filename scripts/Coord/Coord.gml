// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
enum DIRECTION
{
	LEFT,
	RIGHT,
	UP,
	DOWN,
}

function Coord(_x, _y) constructor {
	x = _x;
	y = _y;
}

function random_coord(max_width, max_height) {
	coord = new Coord(floor(random(max_width)), floor(random(max_height)));
	return coord;
}

function coord_same(_coord1, _coord2) {
	return _coord1.x == _coord2.x && _coord1.y == _coord2.y;
}