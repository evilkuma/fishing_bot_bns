
GAME_TITLE = Blade & Soul
WinGet, GAME_ID, ID, %GAME_TITLE%

if !GAME_ID {

	MsgBox, game is not launch

	ExitApp, 1

}

WinGetPos, WINDOW_X, WINDOW_Y, WINDOW_W, WINDOW_H, %GAME_TITLE%
IMAGE_SRC = example.PNG
IMAGE_X = 0
IMAGE_Y = 0

isRun := 0
PCOLOR := false

F10::

	ccolor := GetGamePixel(IMAGE_X+7, IMAGE_Y+22)
	MsgBox, %PCOLOR% : %ccolor% - %IMAGE_X% : %IMAGE_Y%

return

; button down event
F11::

	ImageSearch , IMAGE_X, IMAGE_Y, WINDOW_X, WINDOW_Y, WINDOW_W, WINDOW_H, %IMAGE_SRC%

	if (!IMAGE_X || !IMAGE_Y) {

		MsgBox, not found image. try again, please.

		return

	}

	PCOLOR := substr( "" . GetGamePixel(IMAGE_X+7, IMAGE_Y+22), 3, 6)

	isRun := 1

	MsgBox, script is run!

	while (isRun) {

	 	RunMacro(IMAGE_X, IMAGE_Y, PCOLOR)

	}

return

F12::

	isRun := 0

	MsgBox, script is stop!
	
return

SendToGame(key) {

	global GAME_TITLE

	ControlSendRaw, , %key%, %GAME_TITLE%

}

GetGamePixel(x, y) {

	global GAME_ID

	pc_hDC := DllCall("GetDC", "UInt", GAME_ID)
	pc_fmtI := A_FormatInteger
	SetFormat, IntegerFast, Hex
	pc_c := DllCall("GetPixel", "UInt", pc_hDC, "Int", x, "Int", y, "UInt")
	pc_c := pc_c >> 16 & 0xff | pc_c & 0xff00 | (pc_c & 0xff) << 16
	pc_c .= ""
	SetFormat, IntegerFast, %pc_fmtI%
	DllCall("ReleaseDC", "UInt", GAME_ID, "UInt", pc_hDC)

	return pc_c

}

RunMacro(IMAGE_X, IMAGE_Y, PCOLOR) {

 	global isRun

 	if isRun {

 		ccolor := substr( "" . GetGamePixel(IMAGE_X+7, IMAGE_Y+22), 3, 6)

		res := ccolor != PCOLOR

 		if ( res ) {
		
			SendToGame("F")

			Sleep, 500

 		}

		SendToGame("7")

		Sleep, 1500

 	}

}
