@echo off

::rem ChangeColor %o1% %o2%
::Minta hak akses administrator
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

::Mengubah ukuran window CMD
mode con:cols=41 lines=10

::Global variabel
set folderku=xxx-xxx
set fileku=log.txt
set paath=C:\XXX\XXX\%folderku%

::Jika belum ada file atau folder
if not exist "%paath%\" mkdir %paath%\
if exist %paath%\%fileku% GOTO :view 
if not exist %paath%\%fileku% GOTO :write 

::Menampilkan data jika sebelumnya sudah tersimpan
:view
Msg * %ComputerName% 
echo ============= Data Komputer =============
Title Data Komputer
type %paath%\%fileku%
echo =========================================
@pause
exit

::Menulis data jika sebelumnya belum ada
:write
echo ============= Masukkan Info =============
Title Form Input Data
set /p nama= Nama Pengguna? 
set /p kode= KODE? 
set /p divisi= Divisi? 
set /p bagian= Bagian? 
echo =========================================

::Mengambil data macAddress [ganti Wi-Fi|Local|dll untuk mac yang lain]
for /f "tokens=3 delims=," %%a in ('"getmac /v /fo csv | findstr Wi-Fi"') do set MAC=%%~a

::Set TAB dan Space
set "TAB=   "
set "space= "

::Menulis data ke file text
echo Nama Komputer%TAB%%TAB%: %ComputerName% > %paath%\%fileku%
echo Tanggal dibuat%TAB%%space%%space%: %date% >> %paath%\%fileku%
echo macAddress%TAB%%TAB%%TAB%: %mac% >> %paath%\%fileku%
echo Nama%TAB%%TAB%%TAB%%TAB%%TAB%: %nama% >> %paath%\%fileku%
echo KODE%TAB%%TAB%%TAB%%TAB%%space%%space%%space%: #%kode% >> %paath%\%fileku%
echo Divisi%TAB%%TAB%%TAB%%TAB%%space%: %divisi% >> %paath%\%fileku%
echo Bagian%TAB%%TAB%%TAB%%TAB%%space%: %bagian% >> %paath%\%fileku%

::Memberikan attribute Readonly dan hidden pada folder dan file
attrib +r +h "%paath%"
attrib +r +h "%paath%\%fileku%"
@pause

exit

::Nama Komputer
::Nama User
::KODE
::DIVISI
::BAGIAN
