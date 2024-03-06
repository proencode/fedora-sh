7z2301-x64.exe
set /p str="PuTTYatDate kdbx-reg ----> "
7zr.exe x -p"%str%" kdbx-reg-240305-1058.7z.001
echo "-------------------------------"
set /p str="--- VirtualBox USER PSWD ----> "
7zr.exe x -p"%str%" USERvb7.03*.7z* -oC:\Users\%username%\
VC_redist.x64-14.38.33135.0.exe
Git-2.44.0-64-bit.exe
putty-64bit-0.80-installer.msi
VirtualBox-7.0.14-161095-Win.exe
WinSCP-6.3.1-Setup.exe
KeePassXC-2.7.6-Win64-230905.msi
BraveBrowserSetup-BRV010.exe
set /p str="--- ubuntu2204 PSWD ----> "
start 7zr.exe x -p"%str%" ubuntu2204svr*.7z*
start gimp-2.10.36-setup.exe
start ChromeSetup.exe