del *.rar
md TEMP
copy build\l2ph.exe TEMP\
copy build\l2ph.jdbg TEMP\
copy build\inject.dll TEMP\
copy build\LSPprovider.dll TEMP\

cd temp
md Logs
md Plugins
md Scripts
md settings
copy ..\build\settings\*.* settings\*.*
copy ..\build\plugins\x_als.dll plugins\x_als.dll

del settings\windows.ini
del settings\options.ini
del settings\*.dat

"C:\Program Files\WinRAR\rar.exe" a -df -m5 -r -y ..\l2phx.3.5.xx.yyy.rar .\*.*
cd ..
rd TEMP