/// @description Insert description here
// You can write your code in this editor
with (other) //means instance of the thing we are colliding with not OEnemy because that would apply to all enemies
{
	player_hp -= 10 ;
	flash = 2; //make clear we hit the enemy
}
instance_destroy();