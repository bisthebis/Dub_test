import std.stdio;
import derelict.sdl2.sdl;


void main()
{
	writefln("Hello world !");
	writefln("Square of 0 is %d", square(0));

	DerelictSDL2.load();

	if(SDL_Init(SDL_INIT_VIDEO) != 0)
		writefln("Error loading SDL :'(");

	/* Création de la fenêtre */
	SDL_Window* pWindow = null;
	pWindow = SDL_CreateWindow("Ma première application SDL2",SDL_WINDOWPOS_UNDEFINED,
								  SDL_WINDOWPOS_UNDEFINED,
								  640,
								  480,
								  SDL_WINDOW_SHOWN);

	if( pWindow )
	{

		SDL_Renderer* renderer = SDL_CreateRenderer(pWindow, -1, SDL_RENDERER_ACCELERATED);
		SDL_SetRenderDrawColor(renderer, 0, 128, 255, 255);
		SDL_RenderClear(renderer);	
		
		SDL_RenderPresent(renderer);

		SDL_Delay(5000); /* Attendre trois secondes, que l'utilisateur voie la fenêtre */

		SDL_DestroyRenderer(renderer);
		SDL_DestroyWindow(pWindow);
	}
	else
	{
		writefln("Erreur de création de la fenêtre: %s\n",SDL_GetError());
		SDL_Quit();
		return;
	}
	    
	
    	SDL_Quit();
}

int square(int x)
out (result)
{
	assert (result >= 0, "Square must be positive");
	
}
body
{
	return x*x;
}
