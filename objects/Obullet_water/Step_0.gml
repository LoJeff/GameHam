/// @description Insert description here
// You can write your code in this editor

if (instance_exists(OEnemy))
{
	ins = instance_nearest(x, y, OEnemy);
	if (point_distance(OPlayer.x, OPlayer.y, ins.x, ins.y) < 300 )
	{
		dir = point_direction(x , y, ins.x, ins.y);
		direction += sin(degtorad(dir - direction)) * 20; //other refers to gun
		image_angle = direction;
	}
}

if (point_distance(OPlayer.x, OPlayer.y, x, y) > 1000) instance_destroy();