/// @description Insert description here
// You can write your code in this editor
if (seq == 1)
{
	ran_dir = random_range(-5, 5);
	ran_dir_y = random_range(5, 5);
	hspeed = ran_dir;
	vspeed = ran_dir_y;
	seq = 2;
	alarm[0] = movment_timer;
}
else if (seq == 2)
{
	hspeed = 0;
	vspeed = 0;
	dir = point_direction(x,y,OPlayer.x,OPlayer.y);
	smoke(dir, 10, x,y);
	seq = 1;
	alarm[0] = movment_timer;
}
