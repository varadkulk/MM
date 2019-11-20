#include <iostream>

using namespace std;
int power(int x)
{
	int i = 0;
	while (x != 1)
	{
		i++;
		x /= 2;
	}
	return i;
}

int main()
{
	int mainMemory = (64 * 1024), line = 32, cs = (8 * 1024);
	int n = power(mainMemory), b = power(line), csp = power(cs);
	int index = cs / line, m = csp - b;
	int tag = n - m - b;
	int mAddr, hit = 0, miss = 0, arrTag[index], set;
	for (int i = 0; i < index; i++)
		arrTag[i] = -1;
	for (int i = 0; i < (mainMemory / 2); i++)
	{
		int t = i >> line;
		set = t & m;
		tag = i >> (b + m);
		if (arrTag[set] == tag)
			hit++;
		else
		{
			arrTag[set] = tag;
			miss++;
		}
	}
	cout << "HIT: " << hit << "\nMISS: " << miss;
	return 0;
}
