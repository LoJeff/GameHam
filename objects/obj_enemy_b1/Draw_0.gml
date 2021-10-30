 /// @description Insert description here
// You can write your code in this editor
draw_self();


// draw over the top
if (flash > 0)
{
	flash --;
	shader_set(shWhite);
	draw_self(); // usually this is what it always does
	shader_reset();
}