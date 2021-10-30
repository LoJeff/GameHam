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

// update camera view
camera_set_view_pos(cam, x - view_w_half, y - view_h_half); //only usable when white rectangle is activated