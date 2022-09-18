//depth (show textbox over anything else)
depth = -999;

//textbox params
textBox_width = 860;
textBox_height = 160;

txt_innerBorder = 20; //the distance between the border to the first option
txt_innerSpace = 45; //the distance between options
line_width = textBox_width - txt_innerBorder * 2;

//These are here to delay the instance of first flip thorugh new dialogue (and options)
time_to_flip_timer = 0;
time_to_flip_time = 2;

// ----------------------------- sprites ------------------------ \\
textBox_sprite[0] = spr_dialogueBox;
textBox_image = 0;
textBox_imageSpeed = 30/30;

pointer_sprite = spr_pointer;
pointer_image = 0;
pointer_imageSpeed = 5/30;

//The Text
page = 0;
pageNum = 0;

// --------------- The text to draw ------------------ \\
text[0] = "";
text_length[0] = string_length(text[0]); //returns how many characters are in text array

// [number of characters, pageNumber]
char[0, 0] = "";
char_x[0, 0] = 0;
char_y[0, 0] = 0;

draw_char = 0; //how many characters are being drawn (parsing effect)
text_spd = 1;

// ------------------ Option Text to draw ---------------------- \\
option[0] = "";
option_link_id[0] = -1; //this will track which branch we decide to pick for a particular npc
option_pos = 0; //track position cursor is on
optionNum = 0; //track the durrent depth in this branch of dialogue 

setup = false;

// -------------------- sound ---------------------\\
snd_delay = 4;
snd_count = snd_delay;

// -------------------- effects -------------------- \\
scr_set_defaults_for_text();
last_free_space = 0;
text_pause_timer = 0;
text_pause_time = 18;
