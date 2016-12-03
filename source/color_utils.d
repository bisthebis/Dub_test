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

SDL_Color getColorFromCode(uint code, uint format)
in {
    assert (format == SDL_PIXELFORMAT_RGBA8888 || format == SDL_PIXELFORMAT_ARGB8888);
}
body {
    SDL_Color color;
    if (format == SDL_PIXELFORMAT_RGBA8888)
        {
            color.a =(255 & code);
            color.b = ((255 << 8) & code) >> 8;
            color.g = ((255 << 16) & code) >> 16;
            color.r = ((255 << 24) & code) >> 24;
        }
    else 
        {
            color.b = (255 & code);
            color.g = ((255 << 8) & code) >> 8;
            color.r = ((255 << 16) & code) >> 16;
            color.a = ((255 << 24) & code) >> 24;
        }
    return color;

}

unittest {
    auto color = getColorFromCode(0x80FF00FF, SDL_PIXELFORMAT_RGBA8888);
    assert (color.r == 128);
    assert (color.g == 255);
    assert (color.b == 0);
    assert (color.a == 255);
}