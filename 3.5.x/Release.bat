:del *.rar
md TEMP
copy build\l2ph.exe TEMP\
copy build\pcrelib.dll TEMP\
copy build\inject.dll TEMP\
copy build\LSPprovider.dll TEMP\

cd temp
md Logs
md Plugins
md Scripts
md settings
cd settings
md ru
md en
cd ..

copy ..\build\settings\ru\*.ini settings\ru\*.ini
copy ..\build\settings\en\*.ini settings\en\*.ini
copy ..\build\settings\*.ini settings\*.ini
copy ..\build\plugins\x_als.dll plugins\x_als.dll

del settings\windows.ini
del settings\options.ini

"C:\Program Files\WinRAR\rar.exe" a -df -m5 -r -y ..\l2phx.3.5.xx.yyy.rar .\*.*
cd ..
rd TEMP