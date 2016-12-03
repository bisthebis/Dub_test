import derelict.sdl2.sdl;
import color_utils;
import std.stdio;

class Window {
    private:
    SDL_Window* window;
    SDL_Renderer* renderer;
    SDL_Texture* texture;
    int x = 50;
    int y = 50;
    uint[640*480] pixels;

    public:
    this()
    {
        writefln("Creating window");
        window = SDL_CreateWindow("My SDL Window", 
                                SDL_WINDOWPOS_UNDEFINED, 
                                SDL_WINDOWPOS_UNDEFINED, 
                                640, 
                                480, 
                                SDL_WINDOW_SHOWN);
        renderer = SDL_CreateRenderer(window, 
                                    -1, 
                                    SDL_RENDERER_ACCELERATED);
        texture = SDL_CreateTexture(renderer, 
                                    SDL_PIXELFORMAT_RGBA8888, 
                                    SDL_TEXTUREACCESS_STATIC, 
                                    640, 
                                    480);


        //Creating texture...
        for (uint y = 0; y < 480; ++y)
        {
            for (uint x = 0; x < 640; x++)
            {
                const uint i = x + 640 * y;
                const ubyte alpha = 255;
                const ubyte red = cast(ubyte) (x/3);
                const ubyte green = cast(ubyte) (y/2);
                const ubyte blue = 128;
                const uint color = (red << 24) + (green << 16) + (blue << 8) + alpha;
                pixels[i] = getColorCode(red, green, blue, alpha, SDL_PIXELFORMAT_RGBA8888);
            }
        }

        //Sending it to GPU
        SDL_UpdateTexture(texture, null, pixels.ptr, 640*4);

    }

    ~this()
    {
        SDL_DestroyTexture(texture);
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
        SDL_RenderCopy(renderer, texture, null, null);
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