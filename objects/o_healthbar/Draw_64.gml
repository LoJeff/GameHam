draw_self();

draw_health_ = lerp(draw_health_, OPlayer.player_hp, .25);

draw_set_color(c_red);
draw_rectangle(x+4, y+4, x+123*draw_health_/OPlayer.max_health, y+11, false);
draw_set_color(c_white);
