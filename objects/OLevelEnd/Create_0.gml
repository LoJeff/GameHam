/// @description Insert description here
// You can write your code in this editor

nextRoomID = MapGenerate.map.get_room_id(MapGenerate.locationX, MapGenerate.locationY, nextdirection);
show_debug_message("room ID is: " + string(nextRoomID));
show_debug_message("x location is: " + string(MapGenerate.locationX));
show_debug_message("y location is: " + string(MapGenerate.locationY ));
show_debug_message("next direction is: " + string(nextdirection));
if (nextRoomID == undefined)
{
	instance_destroy();
}                         

next_x = MapGenerate.locationX;
next_y = MapGenerate.locationY;
hit = false;

switch(nextdirection)
{
	case DIRECTION.LEFT:
	{
		next_x--;
		break;
	}
	case DIRECTION.RIGHT:
	{
		next_x++;
		break;
	}
	case DIRECTION.UP:
	{
		next_y--;
		break;
	}
	case DIRECTION.DOWN:
	{
		next_y++;
		break;
	}
}
		