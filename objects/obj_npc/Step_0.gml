//begin new conversation with the npc by meeting these requirements
if(!instance_exists(obj_dialogueBox))
{
	if(keyboard_check_pressed(ord("X")) && distance_to_object(obj_player) <= 5)
	{
		//create a new interaction of dialogue with this npc
		create_textbox(text_id);
	}
}