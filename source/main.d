import std.stdio;
import derelict.sdl2.sdl;
import window_wrapper;

void main()
{
	DerelictSDL2.load();

	if(SDL_Init(SDL_INIT_VIDEO) != 0)
		writefln("Error loading SDL :'(");
	else
	{
		Window window = new Window;
		scope(exit) {
			window.destroy();	
		}

		bool leave = false;
		while (!leave)
		{
			auto event = window.getEvent();
			if (event.type == SDL_QUIT)
			{
				leave = true;
			}
			else if (event.type == SDL_KEYDOWN)
			{
				switch (event.key.keysym.sym)
				{
					case SDLK_UP:
						window.move(0, -2);
						break;
					case SDLK_DOWN:
						window.move(0, 2);
						break;
					case SDLK_RIGHT:
						window.move(2, 0);
						break;
					case SDLK_LEFT:
						window.move(-2, 0);
						break;
					default:
						break;
				}
			}


			window.render();
		}

	}

	scope(exit) {
		writefln("Leaving SDL");
		SDL_Quit();
	}
}

