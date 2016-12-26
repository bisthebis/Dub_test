import derelict.sdl2.sdl;
import color_utils;
import textureBitmap;
import bitmap;
import sierpinski_carpet;
import std.stdio;

class Window {
    private:
    SDL_Window* window;
    SDL_Renderer* renderer;
    Bitmap bitmap;
    TextureBitmap text;

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
        text = new TextureBitmap(renderer, WIDTH, HEIGHT);
        bitmap = Bitmap (WIDTH, HEIGHT); //Since Bitmap is a struct, no "new" invocation is required.

        //Creating texture...
        text.data = bitmap.pixels;
        text.update();

    }

    void showSierpinski()
    {
        bitmap.sierpinskiDo(729, 6); //free function taking reference to Bitmap
        text.update();
    }
    
    ref Bitmap getBitmap() {
        return bitmap;
    }
    ref TextureBitmap getTexture() {
        return text;
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