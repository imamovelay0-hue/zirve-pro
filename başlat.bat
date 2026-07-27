@echo off
chcp 65001 >nul
title Zirve Server
echo.
echo   ▲ ZIRVE serveri baslayir...
echo   Browserde ac: http://localhost:8123
echo   Dayandirmaq ucun bu pencereni bagla.
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "$root='%~dp0'; $listener=New-Object System.Net.HttpListener; $listener.Prefixes.Add('http://localhost:8123/'); $listener.Start(); $mime=@{'.html'='text/html; charset=utf-8';'.css'='text/css; charset=utf-8';'.js'='application/javascript; charset=utf-8';'.png'='image/png';'.jpg'='image/jpeg';'.svg'='image/svg+xml';'.ico'='image/x-icon'}; Start-Process 'http://localhost:8123'; while($listener.IsListening){try{$ctx=$listener.GetContext();$rel=$ctx.Request.Url.LocalPath.TrimStart('/');if([string]::IsNullOrEmpty($rel)){$rel='index.html'};$path=Join-Path $root $rel;if(Test-Path $path -PathType Leaf){$bytes=[System.IO.File]::ReadAllBytes($path);$ext=[System.IO.Path]::GetExtension($path).ToLower();if($mime.ContainsKey($ext)){$ctx.Response.ContentType=$mime[$ext]};$ctx.Response.OutputStream.Write($bytes,0,$bytes.Length)}else{$ctx.Response.StatusCode=404};$ctx.Response.Close()}catch{}}"
