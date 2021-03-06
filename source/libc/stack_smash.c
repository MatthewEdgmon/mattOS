#include <stdint.h>

#if UINT32_MAX == UINTPTR_MAX
#define STACK_CHK_GUARD 0xE2DEE396
#else
#define STACK_CHK_GUARD 0x595E9FBD94FDA766
#endif

uintptr_t __stack_chk_guard = STACK_CHK_GUARD;

__attribute__((__noreturn__))
void __stack_chk_fail(void) {
    abort();
    while(1);
}