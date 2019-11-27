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
	int mainMemory = (64 * 1024), line = 32, cs = ((8 * 1024)/2);
	int n = power(mainMemory), b = power(line), csp = power(cs);
	int index = cs / line, m = csp - b;
	int tag = n - m - b;
	int mAddr, hit = 0, miss = 0, arrTag[index][3], set;
	for (int i = 0; i < index; i++)
	{
		arrTag[i][0] = -1;
		arrTag[i][1] = -1;
		arrTag[i][2] = 0;
	}
	for (int i = 0; i < (mainMemory / 2); i++)
	{
		int t = i >> line;
		set = t & m;
		tag = i >> (b + m);
		if (arrTag[set][0] == tag || arrTag[set][1] == tag)
			hit++;
		else
		{
			arrTag[set][arrTag[set][2]] = tag;
			arrTag[set][2] = ~arrTag[set][2];
			miss++;
		}
	}
	cout << "HIT: " << hit << "\nMISS: " << miss;
	return 0;
}
