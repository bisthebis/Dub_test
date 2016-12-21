import bitmap;
import color_utils;

void sierpinskiDo(ref Bitmap bitmap, uint size, uint steps)
in {
    assert (steps > 0);
}
body {
    sierpinskiPrepare(bitmap, size);
    sierpinskiStep(bitmap, 0, 0, size);
    if (steps > 1)
    {
        for (int j = 0; j < 3; ++j)
        {
            for (int i = 0; i < 3; ++i)
            {
                sierpinskiStep(bitmap, 0 + i*size / 3, 0 + j*size / 3, size/3);
            }
        }
    }
}

private bool isPowerOfThree(uint x)
{
    if (x == 0 || x == 3)
        return true;

    if (x % 3 == 0)
        return isPowerOfThree(x/3);
    
    return false;
}
unittest
{
    assert(isPowerOfThree(729));
    assert(!isPowerOfThree(728));
}

private void sierpinskiPrepare(ref Bitmap bitmap, uint size)
in {
   assert (bitmap.width >= size);
   assert (bitmap.height >= size);

   assert (isPowerOfThree(size));
}
body {
    for (uint y = 0; y < size; ++y)
    {
        for (uint x = 0; x < size; ++x)
        {
            bitmap.setColor(x, y, getColorCode(255, 255, 255, 255));
        }
    }
}

private void sierpinskiStep(ref Bitmap bitmap, uint xOrigin, uint yOrigin, uint size)
in {
    assert (size % 3 == 0);
}
out
{

}
body {
    for (uint y = 0; y < size; ++y)
    {
        for (uint x = 0; x < size; ++x)
        {
            const uint i = xOrigin + x;
            const uint j = yOrigin + y;
            const bool isInside = (x > (size / 3) && x < (size - size / 3)) &&
                                  (y > (size / 3) && y < (size - size / 3));
            if (isInside)
                bitmap.setColor(i, j, getColorCode(0,0,0,0));
            
            //else, let it stay as it is : white
        }
    }
}
