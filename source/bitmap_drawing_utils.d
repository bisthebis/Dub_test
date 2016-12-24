import bitmap;
import std.conv;
import std.stdio;
import std.algorithm;

void drawRect(ref Bitmap bitmap, uint x, uint y, uint w, uint h, uint color, bool fill = false)
in {
    assert ((x + w) < bitmap.width);
    assert ((y + h) < bitmap.height);
}
body {
    //Draw border
    for (uint i = x; i < x + w; ++i)
    {
        bitmap.setColor(i, y, color);
        bitmap.setColor(i, y + h, color);
    }
    for (uint j = y + 1; j < y + h - 1; j++)
    {
        bitmap.setColor(x, j, color);
        bitmap.setColor(x + w, j, color);
    }

    if (!fill)  {return;}    

    for (uint j = y + 1; j < y + h; ++j)
    {
        for (uint i = x + 1; i < x + w ; ++i)
        {
            bitmap.setColor(i, j, color);
        }
    }

    
}
//WIP
void drawLine(ref Bitmap bitmap, uint xa, uint ya, uint xb, uint yb, uint color)
{
    const double slope = (yb - ya) / (xb - xa);
    if (xa < xb)
    {
        swap(xa, xb);
        swap(ya, yb);
    }
    for (uint i = xa; i <= xb; ++i)
    {   
        auto y = slope * (double(i) - double(xa)) + double(ya);
        assert (y > 0);
        writefln("%f", y);
        bitmap.setColor(i, to!uint(y), color);
    }
}