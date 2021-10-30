/// @description Insert description here
// You can write your code in this editor
event_inherited();

image_speed = 1;

if (hspeed == 0)
{
	sprite_index = s_boss;
}
else
{
 	sprite_index = s_boss_r;
}


if (x+1 > xstart + movment_range || x-1 < xstart - movment_range){
	hspeed = -hspeed;
}

if (y+1 > ystart + movment_range || y-1 < ystart - movment_range){
	vspeed = -vspeed;
}

if (sign(hspeed) < 0){
	image_xscale = -1;
} else {
	image_xscale = 1;
}

if (boss_health == 0){
	instance_destroy();
}