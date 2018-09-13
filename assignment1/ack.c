#include <stdio.h>

int ack(int m, int n)
{
	if (m == 0)
	{
		return n+1;
	}

	if (m > 0)
	{
		if (n == 0)
		{
			return ack(m-1, 1);
		}
		else if (n > 0)
		{
			return ack(m-1, ack(m, n-1));
		}
	}

	return 0;
}

int main(void)
{
	printf("%d\n", ack(3, 20));
}