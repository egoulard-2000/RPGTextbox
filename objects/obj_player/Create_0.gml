x_speed = 0;
y_speed = 0;

move_speed = 3;
run_speed = 6;

sprite[RIGHT] = spr_player_right;
sprite[UP] = spr_player_up;
sprite[LEFT] = spr_player_left;
sprite[DOWN] = spr_player_down;

//facing down upon intializing
face = DOWN;
image_speed = 1;

state = pState.NORMAL;

enum pState 
{
	NORMAL,
	LOCKED
}