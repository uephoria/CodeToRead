; 记录每个窗口是否处于“最大化后最小化”的状态
; 使用窗口ID作为键，存储其是否应该恢复为最大化

#Down::
    WinGet, WinID, ID, A
    WinGet, WinState, MinMax, ahk_id %WinID%
    
    ; 如果窗口是最大化状态
    if (WinState = 1) {
        ; 记录这个窗口将来需要恢复成最大化
        RestoreMaxed%WinID% := true
        ; 直接最小化（不恢复）
        WinMinimize, ahk_id %WinID%
    }
    ; 如果窗口是正常状态，直接最小化
    else {
        WinMinimize, ahk_id %WinID%
    }
return

#Up::
    WinGet, WinID, ID, A
    ; 检查这个窗口是否有“恢复成最大化”的标记
    if (RestoreMaxed%WinID% = true) {
        ; 恢复为最大化
        WinMaximize, ahk_id %WinID%
        ; 清除标记
        RestoreMaxed%WinID% := false
    } else {
        ; 正常窗口则正常恢复
        WinRestore, ahk_id %WinID%
    }
return