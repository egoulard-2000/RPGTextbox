//For when the player can move in game
function scr_pState_NORMAL()
{
	#region // -------------------------- run speed ------------------------- \\
	if(z_key)
	{
		//get xspeed and yspeed
		x_speed = (right_key - left_key) * run_speed;
		y_speed = (down_key - up_key) * run_speed;
		image_speed = 2; //make player look faster
	}
	//otherwise, walk at normal speed
	else 
	{
		//get xspeed and yspeed
		x_speed = (right_key - left_key) * move_speed;
		y_speed = (down_key - up_key) * move_speed;
		image_speed = 1; //reset back to normal animation
	}
	#endregion

	#region // -------------------- set sprite for both up/down and left/right ------------------- \\
	mask_index = sprite[DOWN];

	if(y_speed == 0)
	{
		if(x_speed > 0)
			face = RIGHT
		if(x_speed < 0)
			face = LEFT;
	}
	#region FIX for x diagonal sprite 
	if(x_speed > 0 && face == LEFT)
	{
		face = RIGHT;
	}
	if(x_speed < 0 && face == RIGHT)
	{
		face = LEFT;
	}
	#endregion

	if(x_speed == 0)
	{
		if(y_speed > 0)
			face = DOWN;
		if(y_speed < 0)
			face = UP;
	}
	#region FIX for y diagonal sprite
	if(y_speed > 0 && face == UP)
	{
		face = DOWN;
	}
	if(y_speed < 0 && face == DOWN)
	{
		face = UP;
	}
	#endregion

	sprite_index = sprite[face];
	#endregion
	
	// ------------------------------ collisions -------------------------------- \\
	if(place_meeting(x + x_speed, y, obj_wall) || place_meeting(x + x_speed, y, obj_npc))
	{
		x_speed = 0;
	}
	if(place_meeting(x, y + y_speed, obj_wall) || place_meeting(x, y + y_speed, obj_npc))
	{
		y_speed = 0;
	}

	//move the player
	x += x_speed;
	y += y_speed;

	// ------------------------ animate ---------------------------------- \\
	if(x_speed == 0 && y_speed == 0)
		image_index = 0;
		
	// -------------------------- depth ------------------------------ \\
	depth = -bbox_bottom;
}