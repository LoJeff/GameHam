/// @description Insert description here
// You can write your code in this editor

draw_set_color(c_white);

switch(nextdirection)
	{
		case DIRECTION.LEFT:
		{
			draw_text(600,50,string(nextRoomID));
			break;
		}
		case DIRECTION.RIGHT:
		{
			draw_text(600,100,string(nextRoomID));
			break;
		}
		case DIRECTION.UP:
		{
			draw_text(600,150,string(nextRoomID));
			break;
		}
		case DIRECTION.DOWN:
		{
			draw_text(600,200,string(nextRoomID));
			break;
		}
	}