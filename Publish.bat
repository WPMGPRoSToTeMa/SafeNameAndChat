@echo off
setlocal EnableDelayedExpansion

set zip="C:\Program Files\7-zip\7z" a

mkdir Publish\addons\SafeNameAndChat\
copy invoker\linux\*.so Publish\addons\SafeNameAndChat\
copy invoker\win32\*.dll Publish\addons\SafeNameAndChat\
copy *.cfg Publish\addons\SafeNameAndChat\

for /F "eol=/ tokens=3,4*" %%i in (Main.h) do (
	if "%%i" == "PLUGIN_VERSION[]" (
		set pluginVersion=%%k
		set pluginVersion=!pluginVersion:"=!
		set pluginVersion=!pluginVersion:;=!
		set pluginVersion=!pluginVersion: =_!
	)
)

cd Publish
!zip! ..\Invoker\SafeNameAndChat_!pluginVersion!.zip addons
cd ..