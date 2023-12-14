@echo off

:: Create constants with the path where is the .ps1 script, to be called later on the script

set "caminhodownloads=%USERPROFILE%\Downloads\script temp.ps1"
set "caminhoareadetrabalho=%USERPROFILE%\Desktop\script temp.ps1"
set "caminhodocumentos=%USERPROFILE%\Documents\script temp.ps1"
set "caminhopastaatual=%~dp0script temp.ps1"

:: Verify if the file does exist, and open it with the if/else statement

if exist "%caminhodownloads%" (
    echo File found. Starting PowerShell.
    :: command to execute .ps1 byassing the execution policy and run as admin
  PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File \"%~dp0script temp.ps1\"' -Verb RunAs}"
) else if exist "%caminhoareadetrabalho%" (
   echo File found. Starting PowerShell.
     :: command to execute .ps1 byassing the execution policy and run as admin
  PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File \"%~dp0script temp.ps1\"' -Verb RunAs}"
) else if exist "%caminhodocumentos%" (
   echo File found. Starting PowerShell.
       :: command to execute .ps1 byassing the execution policy and run as admin
  PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File \"%~dp0script temp.ps1\"' -Verb RunAs}"
) else if exist "%caminhopastaatual%" (
   echo File found. Starting PowerShell.
   :: command to execute .ps1 byassing the execution policy and run as admin
  PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File \"%~dp0script temp.ps1\"' -Verb RunAs}"
) else (
    goto :ArquivoNaoEncontrado
)

:ArquivoNaoEncontrado

echo Script PowerShell script temp.ps1 not found, verify its path and try once again.

exit
