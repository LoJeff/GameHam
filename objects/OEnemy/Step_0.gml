 //60 times every seconds
/* Movement */

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


/* Animation */

if (!place_meeting(x, y + 1, OWall))
{
	sprite_index = sEnemyA;	
	image_speed = 0;
	if (sign(vsp) > 0 ) image_index = 1; else image_index = 0;
}
else
{
	image_speed = 1;
	if (hsp == 0)
	{
		sprite_index = sEnemy;
	}
	else
	{
 		sprite_index = sEnemyR;
	}
}

if (hsp != 0) image_xscale = sign(hsp) * size;
image_yscale = size;
