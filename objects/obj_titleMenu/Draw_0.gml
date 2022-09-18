//dynamically get width and height of menu
var new_width = 0;
for (var i = 0; i < option_length; i++) 
{
	var option_width = string_width(option[menu_level, i]);
	new_width = max(new_width, option_width);
}
width = new_width + op_innerBorder * 2;
height = op_innerBorder * 2 + string_height(option[0, 0]) + (option_length - 1) * op_innerSpace;

//center the menu
x = room_width/2 - width/2;
y = room_height/2 - height/2;

//draw menu background
draw_sprite_ext(sprite_index, image_index, x, y, width / sprite_width, height / sprite_height, 0, c_white, .75);

//draw options
draw_set_font(global.font_main);
draw_set_valign(fa_top);
draw_set_halign(fa_left);

//writes out all the options in this menu
for (var i = 0; i < option_length; i++)
{
	var _c = c_white;
	//if the cursor hits a certain word
	if(cursor_position == i) 
	{
		//color the option with this color and animate the cursor image
		_c = c_yellow;
		c_image += c_imageSpeed;
		draw_sprite(c_sprite, c_image, x + op_innerBorder - 60, y + op_innerBorder + op_innerSpace*i - 15);
	}
	draw_text_color(x + op_innerBorder, y + op_innerBorder + op_innerSpace*i, option[menu_level, i], _c, _c, _c, _c, 1);
}
