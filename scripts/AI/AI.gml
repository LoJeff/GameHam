// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


function on_collision() {
	
	vsp = vsp + grv;

	/* Horizontal collision */
	if (place_meeting(x + hsp, y, OWall))
	{
		while (!place_meeting(x + sign(hsp), y, OWall))
		{
			x = x + sign(hsp);
		}
		hsp = -hsp;
	}

	x = x + hsp; //coordinate

	 /* vertical collision */
	if (place_meeting(x, y + vsp, OWall))
	{
		while (!place_meeting(x, y + sign(vsp), OWall))
		{
			y = y + sign(vsp);
		}
		vsp = 0;
	}

	y = y + vsp;
}

function can_stand_on(_grid_x, _grid_y)
{
	
	return (ds_grid_get(global.ds_grid_pathfinding, _grid_x, _grid_y) == -1 && ds_grid_get(global.ds_grid_pathfinding, _grid_x, _grid_y) == -2)
}

function on_collision_and_edge() {
	grid_x = floor(x/OGrid.cell_width);
	grid_y = floor(y/OGrid.cell_height);

	/* Horizontal collision */
	if (place_meeting(x + hspeed, y, OWall) || !can_stand_on(grid_x + sign(hspeed), grid_y))
	{
		while (!place_meeting(x + sign(hspeed), y, OWall) && can_stand_on(grid_x + sign(hspeed), grid_y))
		{
			x = x + sign(hsp);
		}
		hsp = -hsp;
	}

	x = x + hsp; //coordinate

	 /* vertical collision */
	
	vsp = vsp + grv;
	if (place_meeting(x, y + vsp, OWall))
	{
		while (!place_meeting(x, y + sign(vsp), OWall))
		{
			y = y + sign(vsp);
		}
		vsp = 0;
	}

	y = y + vsp;
}