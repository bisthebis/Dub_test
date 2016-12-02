import derelict.sdl2.sdl;
import std.stdio;

class Window {
    private:
    SDL_Window* window;
    SDL_Renderer* renderer;

    public:
    this()
    {
        writefln("Creating window");
        window = SDL_CreateWindow("My SDL Window" , SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, 640, 480, SDL_WINDOW_SHOWN);
        renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);
    }

    ~this()
    {
        SDL_DestroyRenderer(renderer);
        SDL_DestroyWindow(window);
        writefln("Destroying window");
    }

    void render()
    {
        SDL_SetRenderDrawColor(renderer, 0, 128, 255, 255);
		SDL_RenderClear(renderer);	
		SDL_RenderPresent(renderer);
    }

    SDL_Event getEvent() {
        SDL_Event value;
        SDL_PollEvent(&value);
        return value;
    }

}