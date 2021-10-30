 // Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Map(_max_width, _max_height, _num_rooms) constructor {
	// ---Helper Functions---
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
				var cur_tile = ds_grid_get(map_grid, adj_coords[i].x, adj_coords[i].y);
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
		// Tags: p0, pu, pd, pb
		template_pool = array_create(4);
		var pb = tag_get_asset_ids("pb", asset_room);
		var pd = tag_get_asset_ids("pd", asset_room);
		var pu = tag_get_asset_ids("pu", asset_room);
		var p0 = tag_get_asset_ids("p0", asset_room);
		
		template_pool[ROOM_PORTALS.NONE] = array_create(array_length(p0) + array_length(pu) + array_length(pd) + array_length(pb))
		template_pool[ROOM_PORTALS.UP] = array_create(array_length(pu) + array_length(pb))
		template_pool[ROOM_PORTALS.DOWN] = array_create(array_length(pd) + array_length(pb))
		template_pool[ROOM_PORTALS.BOTH] = array_create(array_length(pb))
		
		for (var i = 0; i < array_length(pb); ++i) {
			template_pool[ROOM_PORTALS.NONE][i] = pb[i];
			template_pool[ROOM_PORTALS.UP][i] = pb[i];
			template_pool[ROOM_PORTALS.DOWN][i] = pb[i];
			template_pool[ROOM_PORTALS.BOTH][i] = pb[i];
		}
		
		for (var i = 0; i < array_length(pu); ++i) {
			template_pool[ROOM_PORTALS.NONE][array_length(pb) + i] = pu[i];
			template_pool[ROOM_PORTALS.UP][array_length(pb) + i] = pu[i];
		}
		
		for (var i = 0; i < array_length(pd); ++i) {
			template_pool[ROOM_PORTALS.NONE][array_length(pu) + array_length(pb) + i] = pd[i];
			template_pool[ROOM_PORTALS.DOWN][array_length(pb) + i] = pd[i];
		}
		
		for (var i = 0; i < array_length(p0); ++i) {
			template_pool[ROOM_PORTALS.NONE][array_length(pd) + array_length(pu) + array_length(pb) + i] = p0[i];
		}
		
		return template_pool;
	}
	
	static get_room_portal_enum = function(_adj_tiles) {
		if _adj_tiles[1] && _adj_tiles[2]
		{
			return ROOM_PORTALS.BOTH;
		}
		else if _adj_tiles[1]
		{
			return ROOM_PORTALS.UP;
		}
		else if _adj_tiles[3]
		{
			return ROOM_PORTALS.DOWN;
		}
		else
		{
			return ROOM_PORTALS.NONE;
		}
	}
	
	static choose_random_template_id = function(_template_pool, _room_portals) {
		random_template_idx = floor(random(array_length(_template_pool[_room_portals])));
		return _template_pool[_room_portals][random_template_idx];
	}

	static populate_template_ids = function() {
		top_ends = ds_list_create()
		top_ends_max_size = 1;
		stack = ds_stack_create();
		traversed_set = ds_map_create();
		
		template_pool = create_template_pool();

		ds_stack_push(stack, [start_coord, 0]);

		while !ds_stack_empty(stack)
		{
			var cur_data = ds_stack_pop(stack);
			var cur_coord = cur_data[0];
			var cur_dist = cur_data[1];
			var cur_tile = ds_grid_get(map_grid, cur_coord.x, cur_coord.y);
			// show_debug_message("STACK_CUR: " + string(cur_coord.x) + ", " + string(cur_coord.y) + " CUR_DIST: " + string(cur_dist))
			
			show_debug_message("CUR_COORD_BEFORE: " + string(cur_coord.x) + ", " + string(cur_coord.y) + "TILE_TYPE: " + string(cur_tile.tile_type))
			var adj_tiles = add_adjacent_tiles_to_stack(traversed_set, stack, cur_coord, cur_dist);
			
			ds_list_add(top_ends, [cur_coord, cur_dist+1]);
			if ds_list_size(top_ends) > top_ends_max_size
			{
				var min_dist_idx = 0;
				
				for (var i = 1; i < ds_list_size(top_ends); ++i) {
					if ds_list_find_value(top_ends, i)[1] < ds_list_find_value(top_ends, min_dist_idx)[1]
					{
						min_dist_idx = i;
					}
				}
				ds_list_delete(top_ends, min_dist_idx);
			}
			
			room_portals = get_room_portal_enum(adj_tiles);
			if cur_tile.tile_type == TILE_TYPES.GENERIC
			{
				cur_tile.template_id = choose_random_template_id(template_pool, room_portals);
			}
			
			if cur_tile.template_id > 0
			{
				cur_tile.room_id = room_duplicate(cur_tile.template_id);
			}
			// show_debug_message("CUR_COORD_AFTER: " + string(cur_coord.x) + ", " + string(cur_coord.y) + "TILE_TYPE: " + string(cur_tile.tile_type))
		}
		
		// Get furthest room(s) from start
		end_coord = ds_list_find_value(top_ends, floor(random(top_ends_max_size)))[0];
		end_tile = ds_grid_get(map_grid, end_coord.x, end_coord.y);
		end_tile.tile_type = TILE_TYPES.END;
		
		// Clean up
		ds_list_destroy(top_ends);
		// show_debug_message("END_COORD: " + string(end_coord.x) + ", " + string(end_coord.y));
	}
	
	// ---External API Functions---
	
	static clean = function() {
		ds_grid_destroy(map_grid);
	}
	
	static get_room_id = function(_x, _y, _dir) {
		switch(_dir)
		{
			case DIRECTION.LEFT:
				_x -= 1;
				break;
			case DIRECTION.RIGHT:
				_x += 1;
				break;
			case DIRECTION.UP:
				_y -= 1;
				break;
			case DIRECTION.DOWN:
				_y += 1;
				break;
		}
		tile = ds_grid_get(map_grid, _x, _y);
		if tile.tile_type == TILE_TYPES.EMPTY
		{
			return undefined;
		} else {
			return tile.room_id;
		}
	}
	
	// ---Constructor---
	max_width = _max_width
	max_height = _max_height
	num_rooms = _num_rooms
	
	randomize();
	
	map_grid = ds_grid_create(max_width, max_height);
	ds_grid_clear(map_grid, new Tile(TILE_TYPES.EMPTY));
	start_coord = random_coord(max_width, max_height);
	end_coord = undefined;
	
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
		remove_from_pool(rand_coord);
		ds_grid_set(map_grid, rand_coord.x, rand_coord.y, new Tile(TILE_TYPES.GENERIC));
		
		increment_weight();
		add_adjacent_tiles_to_pool(rand_coord, weight);
		// cur_tile = ds_grid_get(map_grid, rand_coord.x, rand_coord.y)
		// show_debug_message("RAND_COORD: " + string(rand_coord.x) + ", " + string(rand_coord.y) + "TILE_TYPE: " + string(cur_tile.tile_type))
	}

	populate_template_ids();

	ds_map_destroy(tile_pool);
	
	
	// show_debug_message("DONE")
	// show_debug_message(string(num_rooms))
}



