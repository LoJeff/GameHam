// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
enum TILE_TYPES
{
	EMPTY,
	START,
	END,
	GENERIC,
}

enum ROOM_PORTALS
{
	NONE,
	UP,
	DOWN,
	BOTH,
}

function Tile(_tile_type) constructor {
	tile_type = _tile_type;
	template_id = -1;
	room_id = -1;
	traversed = false;
}