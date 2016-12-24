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
			const auto event = window.getEvent();
			if (event.type == SDL_QUIT)
			{
				leave = true;
			}
			else if (event.type == SDL_KEYDOWN)
			{
				switch (event.key.keysym.sym)
				{
					case SDLK_UP:
						break;
					case SDLK_DOWN:
						break;
					case SDLK_RIGHT:
						break;
					case SDLK_LEFT:
						break;
				    case SDLK_e:
						window.showSierpinski();
						break;
					case SDLK_ESCAPE:
						leave = true;
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

