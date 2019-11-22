#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

InputBox, UserInput, System, Please enter system to plot to., , 240, 180
if ErrorLevel
    MsgBox, CANCEL was pressed.
else	
	Clipboard := %UserInput%	
	IfWinExist, Elite - Dangerous (CLIENT)
	{
	
	WinActivate
	setkeydelay, 30, 30
	sleep, 1000
    	send, 1
	sleep, 1000
	send, s
	sleep, 40
	send, %UserInput%
	MsgBox, Commands Finished
	}