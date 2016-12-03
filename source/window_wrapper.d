import derelict.sdl2.sdl;
import std.stdio;

class Window {
    private:
    SDL_Window* window;
    SDL_Renderer* renderer;
    int x = 50;
    int y = 50;

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
        SDL_Rect rect;
        rect.x = x;
        rect.y = y;
        rect.w = 100;
        rect.h = 100;
        SDL_SetRenderDrawColor(renderer, 0, 128, 255, 255);
		SDL_RenderClear(renderer);	
        SDL_SetRenderDrawColor(renderer, 255, 0, 0, 255);
        SDL_RenderFillRect(renderer, &rect);
		SDL_RenderPresent(renderer);
    }

    void move(int x, int y)
    {
        this.x += x;
        this.y += y;
    }

    SDL_Event getEvent() {
        SDL_Event value;
        SDL_PollEvent(&value);
        return value;
    }

}