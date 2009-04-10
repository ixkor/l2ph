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
del settings\windows.ini
del settings\options.ini
del settings\editor.lxl


"C:\Program Files\WinRAR\rar.exe" a -df -m5 -r -y ..\l2phx.3.5.1.xx.rar .\*.*
cd ..
rd TEMP