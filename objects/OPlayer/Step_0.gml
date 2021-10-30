//60 times every seconds
/* Movement */
key_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
key_jump = keyboard_check_pressed(vk_space); //just one frame

var move = key_right - key_left; //temporary for one loop

hsp = move * walksp;
vsp = vsp + grv;

if (place_meeting(x, y + 1, OWall)) && (key_jump)
{
	vsp = -10;
}



/* Horizontal collision */
if (place_meeting(x + hsp, y, OWall))
{
	while (!place_meeting(x + sign(hsp), y, OWall))
	{
		x = x + sign(hsp);
	}
	hsp = 0;
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


/* Animation */

if (!place_meeting(x, y + 1, OWall))
{
	sprite_index = PlayerA;	
	image_speed = 0;
	if (sign(vsp) > 0 ) image_index = 1; else image_index = 0;
}
else
{
	image_speed = 1;
	if (hsp == 0)
	{
		sprite_index = Player;
	}
	else
	{
		sprite_index = PlayerR;
	}
}

if (hsp != 0) image_xscale = sign(hsp);