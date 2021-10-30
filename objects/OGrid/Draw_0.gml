/// @description Insert description here
// You can write your code in this editor
if ds_exists(global.ds_grid_pathfinding, ds_type_grid)
{
	for (var i = 0; i < hcells; ++i)
	{
		for (var j = 0; j < vcells; ++j)
		{
			var value = ds_grid_get(global.ds_grid_pathfinding, i, j);
			draw_text_transformed(i*cell_width + 8, j*cell_height +8, string(value), 1, 1, 0);
		}
	}
}