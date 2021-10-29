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
	draw_set_colour(c_red);
	for (var i=0; i<w; ++i)
	{
		draw_text(sx+(i+1)*18, sy, i)
	}
	for (var j=0; j<h; ++j)
	{
		draw_text(sx,sy+(j+1)*18, j)
	}
	draw_set_colour(c_white);
    for (var i=0; i<w; ++i)
    {
        for (var j=0; j<h; j++)
        {
            var value = ds_grid_get(grid,i,j).room_id;
			if value == 0
			{
				draw_set_colour(c_purple);
			}
			else if value == 1
			{
				draw_set_colour(c_lime);
			}
			else if value == 2
			{
				draw_set_colour(c_white);
			}
			else
			{
				draw_set_colour(c_black);
			}
            draw_text(sx+((i+1)*18),sy+((j+1)*18),string(value));
        }
    }
 
    return 0;
}