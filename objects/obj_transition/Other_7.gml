//This plays when the animation for the transition ends
room_goto(target_rm);
//save player coordinates for when they spawn in room
obj_player.x = target_x;
obj_player.y = target_y;

image_speed = -1; //now play the animation backwards