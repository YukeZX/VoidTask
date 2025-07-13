; Requires AutoHotkey v2.0
Persistent

width := 300
height := 200
radius := 30

myGui := Gui("+AlwaysOnTop -Caption +ToolWindow")
myGui.BackColor := "Black"
myGui.Show("w" width " h" height)

hwnd := myGui.Hwnd

SetRoundedCorners(hwnd, width, height, radius)

return

SetRoundedCorners(hwnd, width, height, radius) {
    ; Create a rounded rectangle region
    rgn := DllCall("gdi32.dll\CreateRoundRectRgn"
        , "int", 0, "int", 0
        , "int", width, "int", height
        , "int", radius, "int", radius
        , "ptr")

    ; Apply region to window (1 means redraw)
    DllCall("user32.dll\SetWindowRgn"
        , "ptr", hwnd
        , "ptr", rgn
        , "int", 1)

    ; Do NOT delete the region handle here; Windows owns it now.
}