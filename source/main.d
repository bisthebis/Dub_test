import std.stdio;

void main()
{
	writefln("Hello world !");
	writefln("Square of 0 is %d", square(0));

}

int square(int x)
out (result)
{
	assert (result >= 0, "Square must be positive");
	
}
body
{
	return x*x;
}
