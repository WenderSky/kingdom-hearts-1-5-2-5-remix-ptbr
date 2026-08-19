@echo off
title Desinstalar traducao - KINGDOM HEARTS HD 1.5+2.5 ReMIX
echo.
echo   Isto so' funciona se voce instalou com -ManterBackup.
echo   Sem backup, use "Verificar integridade dos arquivos" na Steam.
echo.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0instalar.ps1" -Desinstalar %*
echo.
pause
