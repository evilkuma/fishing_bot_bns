
isRun := 0

; constants
x := 1197
y := 656
color1 := 0xf1f5fa
color2 := 0xd6ebf7

; button down event
F11::

	isRun := 1

	while(isRun) {

		RunMacro()

	}

return

F12::

	isRun := 0

return

; macross


RunMacro() {

	global isRun, x, y, color1, color2

	if isRun {

		PixelGetColor, color, x, y
		;MouseGetPos, x, y
		;MsgBox, %color%
		;MsgBox, %x% - %y%

		if(color = color2) {
		
			Send, { f down }
			Sleep, 300
			Send, { f }

			Sleep, 300

		}

		Send, { 7 down }
		Sleep, 300
		Send, { 7 }

		Sleep, 1500

	}

}
