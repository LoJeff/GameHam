/// ds_grid_draw(grid,x,y)
//
//  Draws the data of a given grid at a screen location.
//
//      grid        grid data structure, id
//      x,y         screen position, real
//
/// GMLscripts.com/license
function grid_draw(grid, sx, sy) {
 
    var w = ds_grid_width(grid);
    var h = ds_grid_height(grid);
 
	draw_set_alpha(1)
	draw_set_font(Font1);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_colour(c_purple);
	var width_space = 36;
	for (var i=0; i<w; ++i)
	{
		draw_text(sx+(i+1)*width_space, sy, i)
	}
	for (var j=0; j<h; ++j)
	{
		draw_text(sx,sy+(j+1)*width_space, j)
	}
	draw_set_colour(c_white);
    for (var i=0; i<w; ++i)
    {
        for (var j=0; j<h; j++)
        {
			cur_tile = ds_grid_get(grid,i,j)
            var value = cur_tile.tile_type;
			if value == TILE_TYPES.EMPTY
			{
				draw_set_colour(c_grey);
			}
			else if value == TILE_TYPES.START
			{
				draw_set_colour(c_lime);
			}
			else if value == TILE_TYPES.GENERIC
			{
				draw_set_colour(c_white);
			}
			else if value == TILE_TYPES.END
			{
				draw_set_colour(c_red);
			}
			else
			{
				draw_set_colour(c_black);
			}
			if value == TILE_TYPES.GENERIC || value == TILE_TYPES.START
			{
				value = string(cur_tile.template_id) + ":" + string(cur_tile.room_id);
			}
            draw_text(sx+((i+1)*width_space),sy+((j+1)*width_space),string(value));
        }
    }
 
    return 0;
}