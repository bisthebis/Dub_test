import bitmap;
import color_utils;

bool isPowerOfThree(uint x)
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

void sierpinskiPrepare(ref Bitmap bitmap, uint size)
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

