/// @description Insert description here
// You can write your code in this editor

if (instance_exists(OEnemy))
{
	ins = instance_nearest(x, y, OEnemy);
	dir = point_direction(x,y,ins.x,ins.y);
	//if(changeUpdateDelay > 0)
	//{
		direction += sin(degtorad(dir - direction)) * 20; //other refers to gun
		image_angle = direction;
		changeUpdateDelay = 0;
	//}
	changeUpdateDelay++;
}