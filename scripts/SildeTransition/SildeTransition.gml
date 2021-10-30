/// @desc SlideTransition(cmode, targetroom)
/// @arg Mode set transition mode between next restart and goto.
/// @arg Target sets target room when using goto mode

function SlideTransition(cmode, target = room)
{
	with (OTransition)
	{
		mode = cmode; //optional arguments
		if (argument_count > 1) target = argument[1];
	}

	return
}