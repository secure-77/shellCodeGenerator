# shellCodeGenerator
 
Generates x64 WinExec Shellcode which you can use for [Threadless Injections](https://github.com/CCob/ThreadlessInject), the code was stolen from [Adopting Position Independent Shellcodes](https://snovvcrash.rocks/2023/02/14/pic-generation-for-threadless-injection.html) and [PIC-Get-Privileges](https://github.com/paranoidninja/PIC-Get-Privileges)


## Examples
open cmd.exe as window
```bash
./shellGenerator.sh 'cmd.exe' 10 
```

run cmd command without window

```bash
./shellGenerator.sh 'cmd /c "whoami /all" > C:\Windows\Tasks\out.txt' 0 
```
