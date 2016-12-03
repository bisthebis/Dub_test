import derelict.sdl2.sdl;
import std.stdio;

uint getColorCode (ubyte r, ubyte g, ubyte b, ubyte a, uint type)
in {
    assert (type == SDL_PIXELFORMAT_RGBA8888 || type == SDL_PIXELFORMAT_ARGB8888);
}
body {
    switch (type)
    {
        case SDL_PIXELFORMAT_RGBA8888:
            return (r << 24) + (g << 16) + (b << 8) + a;
        case SDL_PIXELFORMAT_ARGB8888:
            return (a << 24) + (r << 16) + (g << 8) + b;
        default:
            writefln("ERROR : Bad PIXELFORMAT. This shouldn't be shown !");
            return 0; 
    }
}


unittest {
    assert (getColorCode(
        0, 
        128, 
        255, 
        255, 
        SDL_PIXELFORMAT_RGBA8888) 
        == 0x0080FFFF
        );
}