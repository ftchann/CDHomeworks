#include <inttypes.h>
#include <stdio.h>


int64_t foo(int64_t a1, int64_t a2, int64_t a3, int64_t a4,
                        int64_t a5, int64_t a6, int64_t a7, int64_t a8);

int64_t ll_calls_foo() {
  return foo(1, 2, 3, 4, 5, 6, 7, 8);
}
