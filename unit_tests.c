
#include <stdarg.h>
#include <setjmp.h>
#include <stddef.h>
#include <cmocka.h>

static void null_test_success(void **state) {
  assert_non_null(state);
}

int main(void) {
  const struct CMUnitTest tests[] = {
    cmocka_unit_test(null_test_success),
  };

  return cmocka_run_group_tests(tests, NULL, NULL);
}

