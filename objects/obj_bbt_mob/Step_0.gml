/// @description Insert description here
// You can write your code in this editor
event_inherited()
if (turn == 59)
{
	
	b = instance_create_layer(x,y,"bullets",obj_bbt_bullet);
	b.speed = 5;
	if (fire_dir == 0)
	{
		b.direction = 0;
		fire_dir = 180;
	} else
	{
		b.direction = 180;
		fire_dir = 0;
	}
	
	
} else if (turn==60) {
	image_xscale = -image_xscale;
	turn = 1;
}

turn++;