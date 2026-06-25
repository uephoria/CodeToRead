#Requires AutoHotkey v2.0
Persistent

; 存储需要最大化的窗口
RestoreMaxed := Map()

#Down:: {
    if WinID := WinGetID("A") {
        WinState := WinGetMinMax(WinID)
        RestoreMaxed[WinID] := (WinState = 1)  ; 直接存储布尔值
        WinMinimize(WinID)
    }
}

#Up:: {
    if WinID := WinGetID("A") {
        if RestoreMaxed.Get(WinID, false) {  ; Get 第二个参数是默认值
            WinMaximize(WinID)
            RestoreMaxed.Delete(WinID)  ; 用完后删除键，彻底清理
        } else {
            WinRestore(WinID)
        }
    }
}