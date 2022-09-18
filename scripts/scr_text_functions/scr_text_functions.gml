function scr_set_defaults_for_text() 
{
	//store the position where text should then skip to next line while being printed
	line_break_pos[0, pageNum] = 999;
	line_break_num[pageNum] = 0;
	line_break_offset[pageNum] = 0; //width in pixels where line break should be for each type of word length

	#region variables for every letter/character (add new effects to text here)
	for(var c = 0; c < 3000; c++)
	{
		col_1[c, pageNum] = c_white;
		col_2[c, pageNum] = c_white;
		col_3[c, pageNum] = c_white;
		col_4[c, pageNum] = c_white;
		
		float_text[c, pageNum] = 0;
		float_direction[c, pageNum] = c*25; //rotational direction around the text to create 'wavy effect'
		
		shake_text[c, pageNum] = 0;
		shake_direction[c, pageNum] = irandom(360);
		shake_timer[c, pageNum] = irandom(4);
		
		glitch_text[c, pageNum] = 0;
		glitch_direction[c, pageNum] = irandom(360);
		glitch_timer[c, pageNum] = irandom_range(4, 8);
	}
	#endregion
	
	textBox_sprite[pageNum] = spr_dialogueBox;
	speaker_sprite[pageNum] = noone;
	//speaker_side[pageNum] = 1;
	
	snd[pageNum] = snd_textParseSound_4;
}

#region Text VFX

/// @param first_char
/// @param last_char
/// @param col1
/// @param col2
/// @param col3
/// @param col4
function scr_text_color(_start, _end, _col1, _col2, _col3, _col4)
{
	for(var c = _start; c <= _end; c++)
	{
		col_1[c, pageNum - 1] = _col1;
		col_2[c, pageNum - 1] = _col2;
		col_3[c, pageNum - 1] = _col3;
		col_4[c, pageNum - 1] = _col4;
	}
	
}

/// @param first_char
/// @param last_char
function scr_text_float(_start, _end) 
{
	for(var c = _start; c <= _end; c++)
	{
		float_text[c, pageNum - 1] = true;
	}
}

/// @param first_char
/// @param last_char
function scr_text_shake(_start, _end)
{
	for(var c = _start; c <= _end; c++)
	{
		shake_text[c, pageNum - 1] = true;
	}
}

/// @param first_char
/// @param last_char
function scr_text_glitch(_start, _end)
{
	for(var c = _start; c <= _end; c++)
	{
		glitch_text[c, pageNum - 1] = true;
	}
}

#endregion

/// @param text
/// @param character
function scr_text(_text)
{
	scr_set_defaults_for_text();
	text[pageNum] = _text;
	
	//get character info 
	if(argument_count > 1) 
	{
		//(getting any argument after text will always specify a character portrait sprite)
		switch(argument[1])
		{
			#region partner portrait
			case "partner":
				speaker_sprite[pageNum] = spr_partner_speak_normal;
				textBox_sprite[pageNum] = spr_partnerBox; //can also put in some custom textbox (optional)
				snd[pageNum] = snd_bruhSound; //can also specify a specific voice for a character
				break;
				
			//add more cases here for different emotions and different characters
			//ex:
			case "partner happy":
				speaker_sprite[pageNum] = spr_partner_speak_happy;
				textBox_sprite[pageNum] = spr_partnerBox;
				snd[pageNum] = snd_bruhSound;
				break;
			
			#endregion
		}
	}
	
	pageNum++;
}

/// @param text_id
function create_textbox(_text_id) 
{
	//This will create a new dialogue cue for this specific NPC
	with(instance_create_depth(0, 0, -9999, obj_dialogueBox))
	{
		//Add in creation code
		scr_game_script_text(_text_id);
	}
}

/// @param option
/// @param link_id
function scr_option(_option, _link_id) 
{
	option[optionNum] = _option;
	option_link_id[optionNum] = _link_id;
	optionNum++;	
}