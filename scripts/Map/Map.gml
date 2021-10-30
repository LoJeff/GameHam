 // Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Map(_max_width, _max_height, _num_rooms) constructor {
	// ---Map Generate Functions---
	static add_adjacent_tiles_to_pool = function(_coord, _weight) {		
		add_tile_to_pool(_coord, 0, 1, _weight);
		add_tile_to_pool(_coord, 0, -1, _weight);
		add_tile_to_pool(_coord, 1, 0, _weight);
		add_tile_to_pool(_coord, -1, 0, _weight);
	}
	
	static add_tile_to_pool = function(_coord, _shift_x, _shift_y, _weight) {
		var new_coord = new Coord(_coord.x + _shift_x, _coord.y + _shift_y)
		if map_tile_in_bounds_coord(new_coord.x, new_coord.y) && !map_tile_exists_coord(new_coord) && !tile_exists_in_pool(new_coord)
		{
			if !adjacent_tile_in_pool_or_map_excluding_base(new_coord, _coord)
			{
				show_debug_message("ADDED: " + string(new_coord))
				ds_map_add(tile_pool, json_stringify(new_coord), _weight);
				total_weight += _weight;
			}
		}
	}
	
	static adjacent_tile_in_pool_or_map_excluding_base = function(_coord, _base_coord) {
		var tmp_coords = [
			new Coord(_coord.x + 1, _coord.y),
			new Coord(_coord.x - 1, _coord.y),
			new Coord(_coord.x, _coord.y + 1),
			new Coord(_coord.x, _coord.y - 1)
		];
		
		for (var i = 0; i < 4; ++i) {
			if !coord_same(tmp_coords[i], _base_coord) && map_tile_in_bounds_coord(tmp_coords[i].x, tmp_coords[i].y)
			{
				if tile_exists_in_map(tmp_coords[i]) || tile_exists_in_pool(tmp_coords[i])
				{
					return true;
				}
			}
		}
		
		return false;
	}
	
	static tile_exists_in_pool = function(_coord) {
		show_debug_message("POOL EXIST: " + string(_coord) + " , " + string(ds_map_exists(tile_pool, json_stringify(_coord))))
		return ds_map_exists(tile_pool, json_stringify(_coord));
	}
	
	static tile_exists_in_map = function(_coord) {
		return ds_grid_get(map_grid, _coord.x, _coord.y).room_id > 0;
	}
	
	static get_random_tile_from_pool = function() {
		var rand_weight_idx = floor(random(total_weight));
		var key_coord = ds_map_find_first(tile_pool);
		while (true) {
			rand_weight_idx -= tile_pool[? key_coord];
			if (rand_weight_idx <= 0)
			{
				break;
			}
			else
			{
				key_coord = ds_map_find_next(tile_pool, key_coord);
			}
		}
		show_debug_message("RAND: " + string(key_coord))
		return json_parse(key_coord);
	}
	
	static remove_from_pool = function(_coord) {
		if ds_map_exists(tile_pool, json_stringify(_coord))
		{
			total_weight -= tile_pool[? json_stringify(_coord)];
			ds_map_delete(tile_pool, json_stringify(_coord));
		}
	}
	
	static map_tile_in_bounds_coord = function(_x, _y) {
		if _x < max_width && _x >= 0 && _y < max_height && _y >= 0
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	
	static map_tile_exists_coord = function(_coord) {
		return (ds_grid_get(map_grid, _coord.x, _coord.y).room_id > 0);
	}
	
	static increment_weight = function() {
		weight *= 1.5;
	}
	
	// ---Constructor---
	max_width = _max_width
	max_height = _max_height
	num_rooms = _num_rooms
	
	randomize();
	
	map_grid = ds_grid_create(max_width, max_height);
	ds_grid_clear(map_grid, new Tile(0));
	start_coord = random_coord(max_width, max_height);
	ds_grid_set(map_grid, start_coord.x, start_coord.y, new Tile(1));
	
	tile_pool = ds_map_create();
	weight = 1;
	total_weight = 0;
	
	add_adjacent_tiles_to_pool(start_coord, weight);
	show_debug_message("START: " + string(start_coord))
	
	for (i = 0; i < num_rooms; ++i) {
		if ds_map_size(tile_pool) == 0
		{
			num_rooms = i;
			break;
		}
		var rand_coord = get_random_tile_from_pool();
		show_debug_message(typeof(rand_coord))
		remove_from_pool(rand_coord);
		ds_grid_set(map_grid, rand_coord.x, rand_coord.y, new Tile(2));
		
		increment_weight();
		add_adjacent_tiles_to_pool(rand_coord, weight);
	}
	
	ds_map_destroy(tile_pool);
	show_debug_message("DONE")
	show_debug_message(string(num_rooms))
}



