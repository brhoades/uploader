#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir S:\bin  ; Ensures a consistent starting directory.

PrintScreen::
	Run capture_screenshot.cmd 0
	return

^PrintScreen::
	Run capture_screenshot.cmd 4
	return