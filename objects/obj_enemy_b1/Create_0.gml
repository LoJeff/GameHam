/// @description Insert description here
// You can write your code in this editor
walksp = 2;
jumpsp = 2;

boss_health = 50;
max_health = 50;
anger = 0;
movment_range = 1000;
movment_timer = room_speed;
alarm[0] = movment_timer;
seq = 1;
flash = 0;
instance_create_layer(100, 100, "Bullets", o_healthbar_boss);