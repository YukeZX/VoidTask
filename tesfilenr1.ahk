; Requires AutoHotkey v2.0
Persistent

width := 300
height := 200
radius := 30

myGui := Gui("+AlwaysOnTop -Caption +ToolWindow")
myGui.BackColor := "Black"
myGui.Show("w" width " h" height)
myGui.Add("Button", "w80", "Record",).OnEvent("Click", StartRecording)
myGui.Add("Button", "w80", "Stop",).OnEvent("Click", StopRecording)
myGui.Add("Button", "w80", "Replay",).OnEvent("Click", ReplayRecording)
myGui.Show("w300", "Record/Replay")
hwnd := myGui.Hwnd

SetRoundedCorners(hwnd, width, height, radius)

return
StartRecording(*) {
    global recording := true
    global events := []
    SetTimer(RecordInput, 10)

}
StopRecording(*) {
    global recording := false
    SetTimer(RecordInput, 0)
    MsgBox "Recording stopped. " events.Length " events captured."
    
}
ReplayRecording(*) {
      if events.Length = 0 {
        MsgBox "No recorded actions."
        return
    }

    for event in events {
        if event.Type = "Mouse" {
            MouseMove event.X, event.Y, 0
            if event.Click
                Click
        } else if event.Type = "Key" {
            Send event.Key
        }
        Sleep 10
    }
}
RecordInput() {
    static prevMouseX := 0, prevMouseY := 0
    MouseGetPos &x, &y
    if (x != prevMouseX or y != prevMouseY) {
        events.Push({Type: "Mouse", X: x, Y: y, Click: false})
        prevMouseX := x
        prevMouseY := y
    }

    ; Check for mouse clicks (LButton)
    if GetKeyState("LButton", "P") {
        events.Push({Type: "Mouse", X: x, Y: y, Click: true})
    }

    ; Record keys (only basic chars here)
    keys := ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","1","2","3","4","5","6","7","8","9","0"]
    for k in keys {
        if GetKeyState(k, "P")
            events.Push({Type: "Key", Key: k})
    }
}
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