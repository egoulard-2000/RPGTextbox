up_key = keyboard_check(vk_up);
down_key = keyboard_check(vk_down);
right_key = keyboard_check(vk_right);
left_key = keyboard_check(vk_left);

z_key = keyboard_check(ord("Z"));

//This simply switches the state of gameplay to talking if the player engages in dialogue
if(instance_exists(obj_dialogueBox) || instance_exists(obj_transition))
	state = pState.LOCKED;
//otherwise, transition back
else
	state = pState.NORMAL;

switch(state)
{
	case pState.NORMAL:
		scr_pState_NORMAL();
		break;
		
	case pState.LOCKED:
		scr_pState_LOCKED();
		break;
}