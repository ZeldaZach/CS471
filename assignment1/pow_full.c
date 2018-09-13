#include <stdio.h>
#include <stdlib.h>

// O(pow) because this for loop iterates pow times
int powI(int pow, int base) {
  int acc, p;
  for (acc=1,p=0; p < pow; p++) {
    acc = acc * base;
  }
  return acc;
}

// O(pow) because the function is recursively called pow times
int powF(int pow, int base)
{
	if (pow <= 0)
	{
		return 1;
	}

	return base * powF(pow - 1, base);
}

int main(int argc, char **argv) {
  if (argc < 3) {
    printf("%s usage: [BASE] [POWER]\n", argv[0]);
    return 1;
  }
  int base = atoi(argv[1]);
  int pow = atoi(argv[2]);
  // int r = powI(pow,base);
  int r = powF(pow,base);
  printf("%d\n", r);
  return 0;
}

/*
In a language where you can do functional and iterative, it seems better to do iterative because
 you have to alloc new stack space for the recursive calls of the function, which takes more time
 than just using a simple for loop.
 Cite: https://stackoverflow.com/questions/15688019/recursion-versus-iteration
*/