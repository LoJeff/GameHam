/// @description Insert description here
// You can write your code in this editor

target = nextRoomID;

with (OPlayer)
{
	if (hascontrol)
	{
		hascontrol = false;
		switch(nextdirection)
		{
			case DIRECTION.LEFT:
			{
				MapGenerate.locationX--;
				break;
			}
			case DIRECTION.RIGHT:
			{
				MapGenerate.locationX++;
				break;
			}
			case DIRECTION.UP:
			{
				MapGenerate.locationY--;
				break;
			}
			case DIRECTION.DOWN:
			{
				MapGenerate.locationY++;
				break;
			}
		}
		
		SlideTransition(TRANS_MODE.GOTO, other.target);
	}
}
