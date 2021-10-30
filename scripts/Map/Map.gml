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
				// show_debug_message("ADDED: " + string(new_coord))
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
		// show_debug_message("POOL EXIST: " + string(_coord) + " , " + string(ds_map_exists(tile_pool, json_stringify(_coord))))
		return ds_map_exists(tile_pool, json_stringify(_coord));
	}
	
	static tile_exists_in_map = function(_coord) {
		return ds_grid_get(map_grid, _coord.x, _coord.y).tile_type != TILE_TYPES.EMPTY;
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
		// show_debug_message("RAND: " + string(key_coord))
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
		return (ds_grid_get(map_grid, _coord.x, _coord.y).tile_type != TILE_TYPES.EMPTY);
	}
	
	static increment_weight = function() {
		weight *= 1.5;
	}

	static update_top_queue = function(_queue_id, _coord, _dist, _size) {
		if ds_priority_size(_queue_id) >= _size
		{
			ds_priority_delete_min(_queue_id)
		}
		ds_priority_add(_queue_id, _coord, _dist);
	}

	static add_adjacent_tiles_to_stack = function(_traversed_set, _stack, _coord, _dist) {
		var adj_coords = [
			new Coord(_coord.x - 1, _coord.y),
			new Coord(_coord.x, _coord.y + 1),
			new Coord(_coord.x + 1, _coord.y),
			new Coord(_coord.x, _coord.y - 1)
		]; //left up right down
	
		adj_tiles = [false, false, false, false]; //left up right down
		for (var i = 0; i < 4; ++i) {
			if map_tile_in_bounds_coord(adj_coords[i].x, adj_coords[i].y)
			{
				cur_tile = ds_grid_get(map_grid, adj_coords[i].x, adj_coords[i].y);
				if cur_tile.tile_type != TILE_TYPES.EMPTY
				{
					adj_tiles[i] = true;
					if !cur_tile.traversed && cur_tile.tile_type != TILE_TYPES.START
					{
						cur_tile.traversed = true
						ds_stack_push(_stack, [adj_coords[i], _dist+1]);
					}
				}
			}
		}
		return adj_tiles
	}
	
	static create_template_pool = function() {
		template_pool = ds_map_create();
		show_debug_message("ROOM: " + string(asset_get_index("Gen")))
		show_debug_message("ROOM: " + string(asset_get_index("Gen1")))
		show_debug_message("ROOM: " + string(asset_get_index("Gen2")))
		show_debug_message("ROOM: " + string(asset_get_index("Gen3")))
		show_debug_message("ROOM: " + string(asset_get_index("Gen4")))
		return template_pool;
	}

	static populate_tempate_ids = function() {
		top_ends = ds_list_create()
		top_ends_max_size = 1;
		stack = ds_stack_create();
		traversed_set = ds_map_create();
		
		template_pool = create_template_pool();

		ds_stack_push(stack, [start_coord, 0]);

		while !ds_stack_empty(stack)
		{
			cur_data = ds_stack_pop(stack);
			cur_coord = cur_data[0];
			cur_dist = cur_data[1];
			// show_debug_message("STACK_CUR: " + string(cur_coord.x) + ", " + string(cur_coord.y) + " CUR_DIST: " + string(cur_dist))
			
			adj_tiles = add_adjacent_tiles_to_stack(traversed_set, stack, cur_coord, cur_dist);
			
			ds_list_add(top_ends, [cur_coord, cur_dist+1]);
			if ds_list_size(top_ends) > top_ends_max_size
			{
				min_dist_idx = 0;
				
				for (var i = 1; i < ds_list_size(top_ends); ++i) {
					if ds_list_find_value(top_ends, i)[1] < ds_list_find_value(top_ends, min_dist_idx)[1]
					{
						min_dist_idx = i;
					}
				}
				ds_list_delete(top_ends, min_dist_idx);
			}
			
			cur_tile = ds_grid_get(map_grid, cur_coord.x, cur_coord.y);
		}
		
		// Get furthest room(s) from start
		end_coord = ds_list_find_value(top_ends, floor(random(top_ends_max_size)))[0];
		ds_list_destroy(top_ends);
		ds_map_destroy(template_pool);
		end_tile = ds_grid_get(map_grid, end_coord.x, end_coord.y);
		end_tile.tile_type = TILE_TYPES.END;
		// show_debug_message("END_COORD: " + string(end_coord.x) + ", " + string(end_coord.y));
	}
	
	// ---Constructor---
	max_width = _max_width
	max_height = _max_height
	num_rooms = _num_rooms
	
	randomize();
	
	map_grid = ds_grid_create(max_width, max_height);
	ds_grid_clear(map_grid, new Tile(TILE_TYPES.EMPTY));
	start_coord = random_coord(max_width, max_height);
	ds_grid_set(map_grid, start_coord.x, start_coord.y, new Tile(TILE_TYPES.START));
	
	tile_pool = ds_map_create();
	weight = 1;
	total_weight = 0;
	
	add_adjacent_tiles_to_pool(start_coord, weight);
	// show_debug_message("START: " + string(start_coord))
	
	for (i = 0; i < num_rooms; ++i) {
		if ds_map_size(tile_pool) == 0
		{
			num_rooms = i;
			break;
		}
		var rand_coord = get_random_tile_from_pool();
		// show_debug_message(typeof(rand_coord))
		remove_from_pool(rand_coord);
		ds_grid_set(map_grid, rand_coord.x, rand_coord.y, new Tile(TILE_TYPES.GENERIC));
		
		increment_weight();
		add_adjacent_tiles_to_pool(rand_coord, weight);
	}

	end_coord = undefined;
	tile_list = ds_list_create();
	populate_tempate_ids();

	ds_map_destroy(tile_pool);
	
	
	// show_debug_message("DONE")
	// show_debug_message(string(num_rooms))
}



