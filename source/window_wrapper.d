import derelict.sdl2.sdl;
import color_utils;
import texture;
import std.stdio;

class Window {
    private:
    SDL_Window* window;
    SDL_Renderer* renderer;
    SDL_Texture* texture;
    uint[] pixels;
    Texture text;

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
        text = new Texture(renderer, 640, 480);

        //Creating texture...
        pixels = new uint[640*480];
        text.data = pixels;
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
        text.update();
        SDL_UpdateTexture(texture, null, pixels.ptr, 640*4);

    }

    ~this()
    {
        text.destroy();
        SDL_DestroyTexture(texture);
        SDL_DestroyRenderer(renderer);
        SDL_DestroyWindow(window);
        writefln("Destroying window");
    }

    void render()
    {
        SDL_SetRenderDrawColor(renderer, 0, 128, 255, 255);
		SDL_RenderClear(renderer);	
        SDL_RenderCopy(renderer, text.getTextureHandle(), null, null);
		SDL_RenderPresent(renderer);
    }

    deprecated("Does nothing") {
        void move(int x, int y)
        {
        }
    }
    SDL_Event getEvent() {
        SDL_Event value;
        SDL_PollEvent(&value);
        return value;
    }

}