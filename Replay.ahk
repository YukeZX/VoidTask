; Record/Replay 

global recording := false
global events := []

myGui := Gui()
myGui.Add("Button", "w80", "Record",).OnEvent("Click", StartRecording)
myGui.Add("Button", "w80", "Stop",).OnEvent("Click", StopRecording)
myGui.Add("Button", "w80", "Replay",).OnEvent("Click", ReplayRecording)
myGui.Show("w300", "Record/Replay")

StartRecording(*) {
    global recording := true
    global events := []
    SetTimer(RecordInput, 10)

}
StartRecording(*) {
    global recording := true
    global events := []
    SetTimer(RecordInput, 10)
    
}
StartRecording(*) {
    global recording := true
    global events := []
    SetTimer(RecordInput, 10)
    
}