import derelict.sdl2.sdl;
import color_utils;

class Bitmap
{
    const uint width;
    const uint height;

    uint[] pixels;

    this (uint w, uint h) 
    in {
        assert (w > 0);
        assert (h > 0);
    }
    out {
        assert (pixels.length == width*height);
    }
    body
    {
        width = w;
        height = h;
        pixels.length = w*h;
        //Initialize to white
        for (uint i = 0; i < w*h; ++i)
            pixels[i] = 0xFFFFFFFF;
    }

    const uint getColor(uint x, uint y)
    in {
        assert (x < width);
        assert (y < height);
        assert ((x + width * y) < pixels.length);
        //No need to ensure x >= 0 or y >= 0 because unsigned type.
    }
    body {
        return pixels[x + width * y];
    }

    void setColor(uint x, uint y, uint color)
    in {
        assert (x < width);
        assert (y < height);
        assert ((x + width * y) < pixels.length);
        //No need to ensure x >= 0 or y >= 0 because unsigned type.
    }
    body {
        pixels[x + width * y] = color;
    }
}

unittest
{
    BitmapTexture text = new BitmapTexture(10, 10);
    assert (text.getColor(5, 5) == 0xFFFFFFFF);
    auto color = getColorCode(0, 255, 128, 255, SDL_PIXELFORMAT_RGBA8888);
    text.setColor(5, 5, color); 
    assert (text.getColor(5, 5) == color);
}