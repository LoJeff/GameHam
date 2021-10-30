/// @description Insert description here
// You can write your code in this editor

if (hp <= 0)
{
	with(instance_create_layer(x, y, layer, ODead)) //same layer 
	{
		direction = other.hitfrom;
		hsp = lengthdir_x(3, direction);
		vsp = lengthdir_y(3, direction) - 2; // little jump
		if (sign(hsp) != 0) image_xscale = sign(hsp);
	}
	
	instance_destroy();
}