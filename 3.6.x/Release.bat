del *.rar
md TEMP
copy build\*.* TEMP\
cd temp
del options.ini
del *.log
del *.txt
del LSPprovider.jdbg
del *.map
del *.temp


md Logs
md Plugins
md Scripts
md settings
copy ..\build\settings\*.* settings\*.*
copy ..\build\plugins\*.dll plugins\*.dll

del settings\windows.ini
del settings\options.ini
del settings\editor_docking.dat
del settings\lexer.lcf
del settings\*.dat
del newxor.dll

"C:\Program Files\WinRAR\rar.exe" a -df -m5 -r -y ..\l2phx.3.6.xx.yyy.rar .\*.*
cd ..
rd TEMP