accept_key = keyboard_check_pressed(ord("X")); 

textBox_x = camera_get_view_x(view_camera[0]);
textBox_y = camera_get_view_y(view_camera[0]) + 370;

if(setup == false) 
{
	setup = true;
	draw_set_font(global.font_main);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	
	//loop through pages 
	for(var p = 0; p < pageNum; p++) 
	{
		//find how many characters are on each page and store that number in the "text_length" array
		text_length[p] = string_length(text[p]);
		
		text_x_offset[p] = 50;
		portrait_x_offset[p] = 50;
		
		////get the x position for the textbox
		//if(speaker_sprite[p] == noone)
		//	text_x_offset[p] = 400; //no character (textbox in center)
		
		//setting individual characters and finding where the lines of text should break
		for(var c = 0; c < text_length[p]; c++)
		{
			var _char_pos = c + 1;
			
			//store individual characters in the "char" array
			char[c, p] = string_char_at(text[p], _char_pos);
			
			//get current width of line being typed
			var _txt_up_to_char = string_copy(text[p], 1, _char_pos);
			var _current_txt_width = string_width(_txt_up_to_char) - string_width(char[c, p]);
			
			//get the last free space
			if(char[c, p] == " ") 
				last_free_space = _char_pos + 1;
				
			//get the line breaks
			if((_current_txt_width - line_break_offset[p]) > line_width)
			{
				//line break happens at last free space to prevent words being cutoff
				line_break_pos[line_break_num[p], p] = last_free_space;
				line_break_num[p]++;
				
				var _txt_up_to_last_space = string_copy(text[p], 1, last_free_space); //get all text before line-break
				var _last_free_space_string = string_char_at(text[p], last_free_space); //now capture that last free space
				line_break_offset[p] = string_width(_txt_up_to_last_space) - string_width(_last_free_space_string); //makes the string break and look nice
			}
		}
		
		//getting each character's coordinates
		for(var c = 0; c < text_length[p]; c++)
		{
			var _char_pos = c + 1;
			var _txt_x = textBox_x + text_x_offset[p] + txt_innerBorder;
			var _txt_y = textBox_y + txt_innerBorder;
			
			//get current width of line being typed
			var _txt_up_to_char = string_copy(text[p], 1, _char_pos);
			var _current_txt_width = string_width(_txt_up_to_char) - string_width(char[c, p]);
			var _txt_line = 0;
			
			//adjust for string breaks
			for(var line_break = 0; line_break < line_break_num[p]; line_break++) 
			{
				//if current looping character is after a line break
				if(_char_pos >= line_break_pos[line_break, p]) 
				{
					var _str_copy = string_copy(text[p], line_break_pos[line_break, p], _char_pos - line_break_pos[line_break, p]);
					_current_txt_width = string_width(_str_copy);
					_txt_line = line_break + 1; // record the line this character should be on
				}
			}
			
			//Add the x and y coordinates based on new line break info
			char_x[c, p] = _txt_x + _current_txt_width;
			char_y[c, p] = _txt_y + _txt_line * txt_innerSpace;
		}
	}
}

// ---------------- type out the text to be a parsing effect ------------------- \\
if(text_pause_timer <= 0)
{
	if(draw_char < text_length[page])
	{
		draw_char += text_spd;
		draw_char = clamp(draw_char, 0, text_length[page]); //clamp the text so that it cannot draw letters that aren't there
	
		//Ensure the typing of text pauses for periods a little longer (makes it look nice)
		var check_char = string_char_at(text[page], draw_char);
		switch(check_char)
		{
			case ".":
				text_pause_timer = text_pause_time;
				break;
				
			case "!":
				text_pause_timer = text_pause_time;
				break;
				
			case "?":
				text_pause_timer = text_pause_time;
				break;
				
			case ",":
				text_pause_timer = text_pause_time - 5; //i like these to still pause, but keep the sentence "moving" if you catch my drift
				break;
		}
		
		//I don't want the sound to play at all when a '.' period is met (silence)
		if(check_char != ".")
		{
			//play typing sound
			if(snd_count < snd_delay)
					snd_count++;
			else 
			{
				snd_count = 0;
				audio_play_sound(snd[page], 8, false);
			}
		}
	}
}
else
{
	text_pause_timer--;
}

//start the timer now (fixes small bug)
time_to_flip_timer++;

// -------------------- flip through pages ------------------ \\
if(accept_key && time_to_flip_timer >= time_to_flip_time)
{
	//if typing is done
	if(draw_char == text_length[page])
	{
		//next page
		if(page < pageNum - 1)
		{
			page++;
			draw_char = 0;
		}
		//destroy textbox when done talking
		else 
		{
			//link text for options
			if(optionNum > 0)
			{
				create_textbox(option_link_id[option_pos]);
			}
			instance_destroy();
		}
	}
	//not done typing out all text being parsed
	else
	{
		//If player hits 'X' key during parsing, then it'll skip the parsing crap
		draw_char = text_length[page];
	}
}


// ------------- draw the textbox ------------------- \\
textBox_image += textBox_imageSpeed;
textBox_sprite_width = sprite_get_width(textBox_sprite[page]);
textBox_sprite_height = sprite_get_height(textBox_sprite[page]);

//draw the speaker
if(speaker_sprite[page] != noone)
{
	sprite_index = speaker_sprite[page];
	
	//When the text stops parsing, then stop the character animation
	if(draw_char == text_length[page])
		image_index = 0;
		
	var _speaker_x = textBox_x + portrait_x_offset[page];
	
	//draw the speaker
	draw_sprite_ext(textBox_sprite[page], textBox_image, textBox_x + portrait_x_offset[page], textBox_y - 123, sprite_width/textBox_sprite_width, sprite_height/textBox_sprite_height, 0, c_white, 1);
	draw_sprite_ext(sprite_index, image_index, _speaker_x + 4, textBox_y - 119, .95, .95, 0, c_white, 1);
} 

//back of the textbox
var _x = textBox_x + text_x_offset[page];
var _y = textBox_y;
draw_sprite_ext(textBox_sprite[page], textBox_image, _x, _y, (textBox_width/textBox_sprite_width), (textBox_height/textBox_sprite_height), 0, c_white, 1);

#region // -------------------- Options ------------------------\\
//Run if we're on the last page of dialogue and page is filled with the text already
if(draw_char == text_length[page] && page == pageNum - 1) 
{
	//option selection
	option_pos += keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
	option_pos = clamp(option_pos, 0, optionNum - 1);
	
	var _op_space = 52;
	var _op_border = 16;
	for(var op = 0; op < optionNum; op++) 
	{
		//draw the option box
		var _option_width = string_width(option[op]) + _op_border * 2;
		//draw_sprite_ext(textBox_sprite, textBox_image, x + 16, y - _op_space*optionNum + _op_space*op, (_option_width/textBox_sprite_width), (_op_space-1/textBox_sprite_height), 0, c_white, 1);
		draw_sprite_ext(textBox_sprite[page], textBox_image, _x + 860 - _option_width, _y - _op_space*optionNum + _op_space*op, (_option_width/textBox_sprite_width), (_op_space-4)/textBox_sprite_height, 0, c_white, 1);
		
		//draw the cursor and make it animate
		if(option_pos == op)
		{
			pointer_image += pointer_imageSpeed;
			draw_sprite(pointer_sprite, pointer_image, _x + 820 - _option_width, _y - _op_space*optionNum + _op_space*op);
		}
		
		//draw the option text
		draw_text(_x + 860 + _op_border - _option_width, _y - _op_space*optionNum + _op_space*op + 13, option[op]);
	} 
}
#endregion

// ----------------------- draw the text ----------------------- \\
for(var c = 0; c < draw_char; c++) 
{
	#region special effects
	
	//floating text
	var _float_y = 0;
	var floating_distance = 4;
	var floating_speed = -6;
	if(float_text[c, page] == true)
	{
		float_direction[c, page] += floating_speed;
		_float_y = dsin(float_direction[c, page]) * floating_distance;
	}
	
	//'scaredy' (shaky) text
	var _shake_x = 0;
	var _shake_y = 0;
	if(shake_text[c, page] == true)
	{
		shake_timer[c, page] -= 2;
		if(shake_timer[c, page] <= 0)
		{
			shake_timer[c, page] = irandom_range(1, 2);
			shake_direction[c, page] = irandom(360);
		}
		if(shake_timer[c, page] <= 2) 
		{
			_shake_x = lengthdir_x(1, shake_direction[c, page]);
			_shake_y = lengthdir_y(1, shake_direction[c, page]);
		}
	}
	
	//'glitch' text
	var _glitch_x = 0;
	var _glitch_y = 0;
	if(glitch_text[c, page] == true)
	{
		glitch_timer[c, page] -= 5;
		if(glitch_timer[c, page] <= 0)
		{
			glitch_timer[c, page] = irandom_range(400, 500);
			glitch_direction[c, page] = irandom(360);
		}
		if(glitch_timer[c, page] <= 10) 
		{
			_glitch_x = lengthdir_x(3, glitch_direction[c, page]);
			_glitch_y = lengthdir_y(3, glitch_direction[c, page]);
		}
	}
	
	#endregion
	
	draw_text_color(char_x[c, page] + _shake_x + _glitch_x, char_y[c, page] + _float_y + _shake_y + _glitch_y, char[c, page], col_1[c, page], col_2[c, page], col_3[c, page], col_4[c, page], 1);
}
