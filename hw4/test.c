
#include<stdio.h>
int main()
{
  int x = 100 >> 3;
  int y = 100 << 3;
  printf("%d %d\n", x, y);
  printf("%d %d\n", -x-y, x-y);
}
