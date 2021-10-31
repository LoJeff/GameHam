/// @description Insert description here
// You can write your code in this editor
vspeed = vspeed + grv;
/* Horizontal collision */
if (place_meeting(x + hspeed, y, OWall))
{
	while (!place_meeting(x + sign(hspeed), y, OWall))
	{
		x = x + sign(hspeed);
	}
	hspeed = 0;
}

x = x + hspeed; //coordinate

 /* vertical collision */
if (place_meeting(x, y + vspeed, OWall))
{
	while (!place_meeting(x, y + sign(vspeed), OWall))
	{
		y = y + sign(vspeed);
	}
	vspeed = 0;
}

y = y + vspeed;