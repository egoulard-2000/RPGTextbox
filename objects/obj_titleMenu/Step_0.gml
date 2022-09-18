//Input
up_key = keyboard_check_pressed(vk_up);
down_key = keyboard_check_pressed(vk_down);
accept_key = keyboard_check_pressed(ord("X"));
back_key = keyboard_check_pressed(ord("Z"));

//store number of options in current menu
option_length = array_length(option[menu_level]);

//Move in menu and play a sound
cursor_position += down_key - up_key;
if(up_key || down_key)
	audio_play_sound(snd_selectionSound, 1, false);

//Wrap back to top
if(cursor_position >= option_length)
{
	cursor_position = 0;
}

//Wrap back down to bottom
if(cursor_position < 0) 
{
	cursor_position = option_length - 1;
}

if(accept_key) 
{
	audio_play_sound(snd_acceptSound, 1, false);
	var startMenuLevel = menu_level;
	
	switch(menu_level) 
	{
		//Normal Pause Menu
		case 0:
			switch(cursor_position) 
			{
				//Start Game
				case 0:
					room_goto_next();
					break;
	
				//Settings
				case 1:
					//go to settings
					menu_level = 1;
					break;
	
				//Quit Game
				case 2:
					game_end();
					break;
			}
			break;
		
		//Settings Sub-Menu
		case 1:
			switch(cursor_position) 
			{
				case 0: 
					//Controls
					break;
				
				case 1: 
					//Window Size
					menu_level = 2;
					break;
		
				case 2:
					//funny bruh sound!!!!!!!
					//this would be even better if it randomized a bunch of shit lmao
					audio_pause_sound(snd_acceptSound);
					audio_play_sound(snd_bruhSound, 1, false);
					break;
				
				case 3:
					//go back
					menu_level = 0;
					audio_pause_sound(snd_acceptSound);
					audio_play_sound(snd_backSound, 1, false);
					break;
			} 
			break;
		
		//Window Size Sub-Menu
		case 2:
			switch(cursor_position)
			{
				case 0:
					//Setting for windowed mode
					break;
				
				case 1:
					//Setting for fullscreen mode
					break;
				
				case 2:
					//go back
					menu_level = 1;
					audio_pause_sound(snd_acceptSound);
					audio_play_sound(snd_backSound, 1, false);
					break;
			}
			break;
	}
	
	//If we're in a sub menu and we go back, then return cursor to top selection of previous menu
	if(startMenuLevel != menu_level) 
	{
		cursor_position = 0;
	}
	
	//correct option length
	option_length = array_length(option[menu_level]);
}

//Whenever the back key is pressed
if(back_key && menu_level > 0)
{
	audio_play_sound(snd_backSound, 1, false);
	menu_level--; //go back to previous screen
	cursor_position = 0; //reset pos
	option_length = array_length(option[menu_level]); //correct the placement in 2d array
}