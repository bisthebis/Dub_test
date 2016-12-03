import derelict.sdl2.sdl;

class Texture {

    private:
        SDL_Texture* text;
        const uint width;
        const uint height;
    public:
        uint[] data;

        this(SDL_Renderer* renderer, uint w, uint h)
        in {
            assert (w > 0 && h > 0 && renderer != null);
        }
        out {
            assert (text != null);
        }
        body {
            width = w;
            height = h;
            text = SDL_CreateTexture(renderer,
                                    SDL_PIXELFORMAT_RGBA8888,
                                    SDL_TEXTUREACCESS_STATIC,
                                    w, h);
        }

        ~this()
        {
            SDL_DestroyTexture(text);
        }

        void update() {
            SDL_UpdateTexture(text, null, data.ptr, 4*width);
        }

        SDL_Texture* getTextureHandle()
        {
            return text;
        }

}