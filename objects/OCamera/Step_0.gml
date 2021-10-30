 /// @description Update Camera
// You can write your code in this editor

// update destination

if (instance_exists(follow)) // if at least one instance exists
{
	xTo = follow.x
	yTo = follow.y;
}

//update obj position
x += (xTo - x) / 25;
y += (yTo - y) / 25;

var centered_x = x - view_w_half;
var centered_y = y - view_h_half;

if (y < 0)
{
	y = 0;
}
else if (y + camera_get_view_height(cam) > room_height)
{
	y = room_height - camera_get_view_height(cam);
}

// update camera view
camera_set_view_pos(cam, centered_x, centered_y); //only usable when white rectangle is activated