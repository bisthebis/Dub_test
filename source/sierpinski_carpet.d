import bitmap;
import color_utils;
import std.math;

void sierpinskiDo(ref Bitmap bitmap, uint size, uint steps)
in {
    assert (steps > 0);
    assert (pow(3, steps) <= size);
}
body {
    sierpinskiPrepare(bitmap, size);
    uint currentStep = 1;
    uint sizeRatio = 1;

    do {
        for (uint j = 0; j < sizeRatio; ++j)
        {
            for (uint i = 0; i < sizeRatio; ++i)
            {
                sierpinskiStep(bitmap, i * (size / sizeRatio), j * (size / sizeRatio), size / sizeRatio);
            }
        }

        currentStep++;
        sizeRatio *= 3;
    } while (currentStep <= steps);
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
