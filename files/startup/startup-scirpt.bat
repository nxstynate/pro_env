@echo off
title Startup Script
echo Starting applications...

:: Give Windows time to initialize services
timeout /t 5 /nobreak >nul

:: Launch GlazeWM last to ensure all windows are properly initialized
echo Launching GlazeWM...
start "" "C:\Program Files\glzr.io\GlazeWM\glazewm.exe"

:: Wait for applications to open before launching GlazeWM
echo Waiting for applications to start...
timeout /t 5 /nobreak >nul

:: Launch Applications
echo Launching WezTerm as Administrator...
powershell -Command "Start-Process 'C:\Program Files\WezTerm\wezterm-gui.exe' -Verb RunAs"

REM echo Launching Windows Terminal...
REM start "" "wt.exe"

REM Start-Process "wt.exe" -Verb RunAs
REM echo Launching Win-Vind...
REM start "" "C:\Users\Paul\scoop\shims\win-vind.exe"

REM echo Launching Blender...
REM start "" "C:\Program Files\Blender Foundation\Blender 4.2\blender.exe"

echo Launching Google Chrome windows...
start "" "C:\Program Files\Google\Chrome\Application\chrome.exe" "https://mail.google.com/mail/u/5/#inbox"
timeout /t 1 /nobreak >nul
start "" "C:\Program Files\Google\Chrome\Application\chrome.exe" "https://mail.google.com/mail/u/4/#inbox"
timeout /t 1 /nobreak >nul
start "" "C:\Program Files\Google\Chrome\Application\chrome.exe" "https://mail.google.com"
timeout /t 1 /nobreak >nul
start "" "C:\Program Files\Google\Chrome\Application\chrome.exe" --new-window "https://www.google.com"
echo Launching Google Voice...
start "" "C:\Program Files\Google\Chrome\Application\chrome.exe" --new-window "https://voice.google.com" --window-size=1280,800 --window-position=100,100
echo Launching Google Calendar...
start "" "C:\Program Files\Google\Chrome\Application\chrome.exe" --new-window --start-fullscreen "https://calendar.google.com"
echo Launching Google GMail...
start "" "C:\Program Files\Google\Chrome\Application\chrome.exe" --new-window "https://miro.com/app/dashboard/"
start "" "C:\Program Files\Google\Chrome\Application\chrome.exe" "https://trello.com/b/vHEaopgO/template"


echo Launching Slack...
start "" "C:\Users\Paul\AppData\Local\slack\slack.exe"

echo Launching Discord...
start "" "C:\Users\Paul\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Discord Inc\Discord.lnk"

REM echo Launching WhatsApp...
REM start "" "C:\Program Files\WindowsApps\5319275A.WhatsAppDesktop_2.2514.4.0_x64__cv1g1gvanyjgm\WhatsApp.exe"

echo Launching Signal...
start "" "C:\Users\Paul\AppData\Local\programs\signal-desktop\Signal.exe"

echo All applications started successfully!
exit

