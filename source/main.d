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
				leave = true;

			window.render();
		}

	}

	scope(exit) {
		writefln("Leaving SDL");
		SDL_Quit();
	}
}

