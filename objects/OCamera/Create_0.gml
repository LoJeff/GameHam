/// @description Setup camera
// You can write your code in this editor

cam = view_camera[0];
follow = OPlayer; // oldest instance of the obj
view_w_half = camera_get_view_width(cam) * 0.5;
view_h_half = camera_get_view_height(cam) *0.5;
xTo = xstart; // x we are moving to
yTo = ystart; // y we are moving to
