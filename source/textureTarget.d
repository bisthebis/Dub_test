import derelict.sdl2.sdl;

class TextureTarget {

    private:
        SDL_Texture* text;
        const uint width;
        const uint height;

    this ()
    {
        width = w;
        height = h;
        text = SDL_CreateTexture(renderer,
                                SDL_PIXELFORMAT_RGBA8888,
                                SDL_TEXTUREACCESS_TARGET,
                                w, h);
    }
    ~this () {
        SDL_DestroyTexture(text);
    }
}