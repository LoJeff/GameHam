draw_self();

draw_health_ = lerp(draw_health_, obj_enemy_b1.boss_health, .25);

draw_set_color(c_red);
draw_rectangle(x+8, y+8, x+246*draw_health_/obj_enemy_b1.max_health, y+22, false);
draw_set_color(c_white);
