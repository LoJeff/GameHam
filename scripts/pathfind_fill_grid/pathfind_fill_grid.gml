// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function pathfind_fill_grid(_x, _y, _x_dest, _y_dest, _max_dist){
	var path_found = false;
	var n;
	var a;
	
	ds_grid_pathfinding = ds_grid_create(ds_grid_with(global.ds_grid_pathfinding), ds_grid_height(global.ds_grid_pathfinding));
	ds_grid_copy(ds_gridpathfinding, global.ds_grid_pathfinding);
	
	var point_list = ds_list_create();
	ds_list_add(point_list, _x);
	ds_list_add(point_list, _y);
	ds_grid_set(ds_gridpathfinding, _x, _y, 0);
	for (var i = 1; i < _max_dist; ++i)
	{
		var size_list = ds_list_size(point_list);
		for (var j = 0; j < size_list; j += 2)
		{
			_x = ds_list_find_value(point_list, j);
			_y = ds_list_find_value(point_list, j+1);
			
			n=1;
			// check one step right
			if (ds_grid_get(ds_gridpathfinding, _x+1, _y) == -1 && ds_grid_get(ds_gridpathfinding, _x+1, _y+1) == -2)
			{
				ds_grid_set(ds_gridpathfinding, _x+1, _y, i);
				ds_list_add(point_list, _x+1);
				ds_list_add(point_list, _y);
			}
		}
	}
}