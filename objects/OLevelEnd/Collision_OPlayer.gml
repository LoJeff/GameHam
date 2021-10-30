/// @description Insert description here
// You can write your code in this editor

target = nextRoomID;


with (OPlayer)
{
	if (hascontrol)
	{
		hascontrol = false;
		SlideTransition(TRANS_MODE.GOTO, other.target);
	}
}


if(!hit)
{
	MapGenerate.locationX = next_x;
	MapGenerate.locationY = next_y;
	hit = true;
}