#include <GUIConstantsEx.au3>

; 创建一个新的 GUI 窗口
$hGUI = GUICreate("简单的 AutoIt 示例", 300, 200)

; 创建一个按钮控件
$hButton = GUICtrlCreateButton("点击我", 100, 80, 100, 30)

; 显示 GUI 窗口
GUISetState()

; 主循环，用于处理 GUI 事件
While 1
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case $GUI_EVENT_CLOSE
            ; 如果用户关闭窗口，退出循环
            ExitLoop
        Case $hButton
            ; 如果用户点击按钮，弹出消息框
            MsgBox(0, "提示", "你点击了按钮！")
    EndSwitch
WEnd

; 销毁 GUI 窗口
GUICtrlSetData($hGUI, "")