/// @description Pick Up
with (other) //means instance of the thing we are colliding with not OEnemy because that would apply to all enemies
{
	
	hp--;
	flash = 3; //make clear we hit the enemy
	hitfrom = other.direction;
}