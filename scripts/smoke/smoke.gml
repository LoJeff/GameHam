// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function smoke(dir, spd, char_x, char_y){
	s = instance_create_layer(char_x,char_y,"smoke",obj_smoke);
	s.direction = dir;
	s.speed = spd;
}