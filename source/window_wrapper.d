import derelict.sdl2.sdl;
import color_utils;
import texture;
import bitmap;
import sierpinski_carpet;
import std.stdio;

class Window {
    private:
    SDL_Window* window;
    SDL_Renderer* renderer;
    Bitmap bitmap;
    Texture text;

    static const uint WIDTH = 729;
    static const uint HEIGHT = 729;

    public:
    this()
    {
        writefln("Creating window");
        window = SDL_CreateWindow("My SDL Window", 
                                SDL_WINDOWPOS_UNDEFINED, 
                                SDL_WINDOWPOS_UNDEFINED, 
                                WIDTH, 
                                HEIGHT, 
                                SDL_WINDOW_SHOWN);
        renderer = SDL_CreateRenderer(window, 
                                    -1, 
                                    SDL_RENDERER_ACCELERATED);
        text = new Texture(renderer, WIDTH, HEIGHT);
        bitmap = Bitmap (WIDTH, HEIGHT); //Since Bitmap is a struct, no "new" invocation is required.

        //Creating texture...
        text.data = bitmap.pixels;
        for (uint y = 0; y < HEIGHT; ++y)
        {
            for (uint x = 0; x < WIDTH; x++)
            {
                const uint i = x + WIDTH * y;
                const ubyte alpha = 255;
                const ubyte red = cast(ubyte) (x/3);
                const ubyte green = cast(ubyte) (y/3);
                const ubyte blue = 255;
                bitmap.setColor(x, y, getColorCode(red, green, blue, alpha, SDL_PIXELFORMAT_RGBA8888));
            }
        }
        sierpinskiDo(bitmap, 729, 2);
        //sierpinskiStep(bitmap, 243);

        //Sending it to GPU
        text.update();

    }

    ~this()
    {
        text.destroy();
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