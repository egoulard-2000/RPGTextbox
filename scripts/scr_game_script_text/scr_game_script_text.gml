/// @param text_id
function scr_game_script_text(_text_id)
{
	//Make specific dialogue boxes for certain npc's whenever player interacts with them
	//Essentially, all of the game's dialogue scripts will be held here
	switch(_text_id) 
	{
		case "npc_1":
			scr_text("Hi, I'm npc 1");
			scr_text("Did you get aquainted with my fellow yellow lemellow squares?", "partner");
				//example of having an effect for some string of characters (makes 'yellow' look yellow with a tint of gold :)
				scr_text_color(37, 43, c_yellow, c_yellow, c_yellow, c_white); scr_text_color(12, 21, c_red, c_red, c_red, c_red); 
				
				//example of floating text
				scr_text_float(12, 21);
				
				//example of shaking text
				scr_text_shake(37, 43);
				
				//example of glitch text
				scr_text_glitch(4, 6);
				
				//example of presenting a question and following up with a set of options to choose
				scr_option("Yes", "npc_1 - yes");
				scr_option("Not yet!", "npc_1 - no");
				scr_option("testing the absolute length of this box", "npc_1 - ?");
			break;
			//Then have responses if we answer yes or no
			case "npc_1 - yes":
				scr_text("Good!... Now then, off to the wonderous world of my basement.", "partner happy");
				break;
				
			case "npc_1 - no":
				scr_text("Come back when you meet them all!");
				break;
				
			case "npc_1 - ?":
				scr_text("Bababoey Bababoey Bababoey BababoeyBababoeyBababoey Bababoey Bababoey Bababoey  Bababoey Bababoey", "partner");
				scr_text("Bababoey Bababoey Bababoey BababoeyBababoeyBababoey Bababoey Bababoey Bababoey", "partner");
				scr_text("Howard Stern's Penis", "partner");
				break;
		
		case "npc_2":
			scr_text("Hi, I'm npc 2. I like corndogs, hotdogs, chillidogs, nintendogs, bulldogs, waterdogs, sheepdogs, gundogs, another-word-with-the-last-four-letters-being-dogs");
			scr_text("Oh, one last thing!");
			scr_text("I'm a TOtal cat person :)))))))))))");
			break;
		case "npc_3":
			scr_text("Hi, I'm sans undertale", "partner");
			scr_text("Gaffaw! Just kidding lmao", "partner");
			scr_text("I'm actually npc 3");
			scr_text("jk its me ur partner in crime :D", "partner happy");
			break;
		
		case "npc_4":
			scr_text("Hi, I'm npc... wait who am I?");
			scr_text(". . . ..........................");
			scr_text("Are we just a figment of someone's imagination? Do I seem... real to you?");
			break;
			
		case "npc_5":
			scr_text("Allo Brah,... allo brah 8)");
			scr_text("Allo brah?");
				scr_option("Allooooo brah", "Aloooooo brah");
				scr_option("so i was at the aquarium", "so i was at the aquarium");
			break;
			
			case "so i was at the aquarium":
				scr_text("and i noticed there weren't any string arrays!!!! HAHAHAHAHAH");
				break;
			case "Aloooooo brah":
				scr_text("OOOhhhhhh. . .  Allo brah! :]");
				break;
				
		#region rm_testing
		
		case "npc_6":
			scr_text("Oh! I see you take a liking to my 1-to-1 replica of me", "partner");
				scr_option("Why is it colored differently then?", "npc_6: why?");
				scr_option("I mean... ok?", "npc_6: ok?");
			break;
					
			case "npc_6: why?":
				scr_text("That was my season 1-4 look!", "partner happy");
				break;
						
			case "npc_6: ok?":
				scr_text("...", "partner");
				scr_text("Ok. I'll admit... It's kinda dumb", "partner");
				scr_text("But the kids loved it!", "partner happy");
				break;
		
		case "table_1":
			scr_text("(Walter notices the table with a pitter-potted plant and a picture of his dear-old mum.)");
			scr_text("This table is my favorite table. It holds a lot of things dear to me!", "partner");
			break;
			
		case "table_2":
			scr_text("(For some reason, Walter owns the same identical table from upstairs...)");
			scr_text("This table is my second favorite table", "partner");
			scr_text("I love my first one sooooooooooo much that I just had to put it downstairs!", "partner happy");
				scr_text_float(20, 32); //sooooooooo
			break;
		
		#endregion
	}
}