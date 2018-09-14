;设置无状态栏图标
#NoTrayIcon
;屏蔽 shift + space
+Space::Send, {Space}
;;

#f::Run,D:\Program Files\Everything-1.4.1.895.x64\Everything.exe

; caps 单击: 无
; caps 双击: capslock
; caps 三击: 无
;=====================================================================o
;                       CapsLock Initializer                         ;|
;---------------------------------------------------------------------o
SetCapsLockState, AlwaysOff                                          ;|
;---------------------------------------------------------------------o
                                                                     ;|
;---------------------------------------------------------------------o
; 设置按下 esc 直接切换为英文
~Esc::ConvESC()
ConvESC() {
  if (GetIME() = 1) {
    Send, {RCtrl Down}{RShift Down}{RShift Up}{RCtrl Up}
  }
}
GetIME(WinTitle="") {
	ifEqual WinTitle,,  SetEnv,WinTitle,A
	WinGet,hWnd,ID,%WinTitle%
	DefaultIMEWnd := DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hWnd, Uint)
	DetectSave := A_DetectHiddenWindows
	DetectHiddenWindows,ON
	SendMessage 0x283, 0x005,0,,ahk_id %DefaultIMEWnd%
	DetectHiddenWindows,%DetectSave%
	Return ErrorLevel
}

$CapsLock::
if ctrl_presses > 0 ; SetTimer 已经启动，所以我们记录按键。
{
ctrl_presses += 1
return
}
; 否则，这是新一系列按键的首次按键。将计数设为 1 并启动定时器
ctrl_presses = 1
SetTimer, Keyctrl, 250 ; 在 500 毫秒内等待更多的按键。
return
Keyctrl:
SetTimer, Keyctrl, off
if ctrl_presses = 1 ; 该键已按过一次。
{
Gosub singleClick
}
else if ctrl_presses = 2 ; 该键已按过两次。
{
Gosub doubleClick
}
; 不论上面哪个动作被触发，将计数复位以备下一系列的按键：

ctrl_presses = 0
return

; 单击 -> Esc
singleClick:
ConvESC()
Send, {ESC}
return
; 双击 -> 切换大小写
doubleClick: 
{
GetKeyState, CapsLockState, CapsLock, T                              ;|
if CapsLockState = D                                                 ;|
    SetCapsLockState, AlwaysOff                                      ;|
else                                                                 ;|
    SetCapsLockState, AlwaysOn                                       ;|
KeyWait, ``                                                          ;|
return
}

; 不论上面哪个动作被触发，将计数复位以备下一系列的按键：
;SPACE_presses = 0
;return
;singleClick2:
;send {SPACE}
;return
;
;doubleClick2:
;send {enter}
;return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;=====================================================================o
;                       CapsLock Switcher:                           ;|
;---------------------------------o-----------------------------------o
;                    CapsLock + ` | {CapsLock}                       ;|
;---------------------------------o-----------------------------------o
CapsLock & `::                                                       ;|
GetKeyState, CapsLockState, CapsLock, T                              ;|
if CapsLockState = D                                                 ;|
    SetCapsLockState, AlwaysOff                                      ;|
else                                                                 ;|
    SetCapsLockState, AlwaysOn                                       ;|
KeyWait, ``                                                          ;|
return                                                               ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                    CapsLock Direction Navigator                    ;|
;-----------------------------------o---------------------------------o
;                      CapsLock + h |  Left                          ;|
;                      CapsLock + j |  Down                          ;|
;                      CapsLock + k |  Up                            ;|
;                      CapsLock + l |  Right                         ;|
;                      Ctrl, Alt Compatible                          ;|
;-----------------------------------o---------------------------------o
CapsLock & h::                                                       ;|
if GetKeyState("control") = 0                                        ;|
{                                                                    ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, {Left}                                                 ;|
    else                                                             ;|
        Send, +{Left}                                                ;|
    return                                                           ;|
}                                                                    ;|
else {                                                               ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, ^{Left}                                                ;|
    else                                                             ;|
        Send, +^{Left}                                               ;|
    return                                                           ;|
}                                                                    ;|
return                                                               ;|
;-----------------------------------o                                ;|
CapsLock & j::                                                       ;|
if GetKeyState("control") = 0                                        ;|
{                                                                    ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, {Down}                                                 ;|
    else                                                             ;|
        Send, +{Down}                                                ;|
    return                                                           ;|
}                                                                    ;|
else {                                                               ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, ^{Down}                                                ;|
    else                                                             ;|
        Send, +^{Down}                                               ;|
    return                                                           ;|
}                                                                    ;|
return                                                               ;|
;-----------------------------------o                                ;|
CapsLock & k::                                                       ;|
if GetKeyState("control") = 0                                        ;|
{                                                                    ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, {Up}                                                   ;|
    else                                                             ;|
        Send, +{Up}                                                  ;|
    return                                                           ;|
}                                                                    ;|
else {                                                               ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, ^{Up}                                                  ;|
    else                                                             ;|
        Send, +^{Up}                                                 ;|
    return                                                           ;|
}                                                                    ;|
return                                                               ;|
;-----------------------------------o                                ;|
CapsLock & l::                                                       ;|
if GetKeyState("control") = 0                                        ;|
{                                                                    ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, {Right}                                                ;|
    else                                                             ;|
        Send, +{Right}                                               ;|
    return                                                           ;|
}                                                                    ;|
else {                                                               ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, ^{Right}                                               ;|
    else                                                             ;|
        Send, +^{Right}                                              ;|
    return                                                           ;|
}                                                                    ;|
return                                                               ;|
;---------------------------------------------------------------------o

;=====================================================================o
;                     CapsLock Mouse Controller                      ;|
;-----------------------------------o---------------------------------o
;                   CapsLock + Up   |  Mouse Up                      ;|
;                   CapsLock + Down |  Mouse Down                    ;|
;                   CapsLock + Left |  Mouse Left                    ;|
;                  CapsLock + Right |  Mouse Right                   ;|
;    CapsLock + Enter(Push Release) |  Mouse Left Push(Release)      ;|
;-----------------------------------o---------------------------------o
CapsLock & Up::    MouseMove, 0, -10, 0, R                           ;|
CapsLock & Down::  MouseMove, 0, 10, 0, R                            ;|
CapsLock & Left::  MouseMove, -10, 0, 0, R                           ;|
CapsLock & Right:: MouseMove, 10, 0, 0, R                            ;|
;-----------------------------------o                                ;|
CapsLock & Enter::                                                   ;|
SendEvent {Blind}{LButton down}                                      ;|
KeyWait Enter                                                        ;|
SendEvent {Blind}{LButton up}                                        ;|
return                                                               ;|
;---------------------------------------------------------------------o

;=====================================================================o
;                            CapsLock Editor                         ;|
;-----------------------------------o---------------------------------o
;                     CapsLock + z  |  Ctrl + z (Cancel)             ;|
;                     CapsLock + x  |  Ctrl + x (Cut)                ;|
;                     CapsLock + c  |  Ctrl + c (Copy)               ;|
;                     CapsLock + v  |  Ctrl + v (Paste)              ;|
;                     CapsLock + y  |  Ctrl + y (Yeild)              ;|
;                     CapsLock + w  |  Ctrl + Right(Move as [vim: w]);|
;                     CapsLock + b  |  Ctrl + Left (Move as [vim: b]);|
;-----------------------------------o---------------------------------o
CapsLock & z:: Send, ^z                                              ;|
CapsLock & x:: Send, ^x                                              ;|
CapsLock & c:: Send, ^c                                              ;|
CapsLock & v:: Send, ^v                                              ;|
CapsLock & y:: Send, ^y                                              ;|
CapsLock & w:: Send, ^{Right}                                        ;|
CapsLock & b:: Send, ^{Left}                                         ;|
;---------------------------------------------------------------------o


;=================================================================================o
;                      CapsLock Window Controller                                ;|
;-----------------------------------o---------------------------------------------o
;                     CapsLock + s  |  win + Tab                                 ;|
;                     CapsLock + d  |  ctrl + win + right                        ;|
;                     CapsLock + a  |  ctrl + win + left                         ;|
;                     CapsLock + f  |  run everything                            ;|
;                     CapsLock + e  |  open google search                        ;|
;                     CapsLock + r  |  open Powershell                           ;|
;                     CapsLock + t  |  open notepad++                            ;|
;                     CapsLock + q  |  Ctrl + W   (Close Tag)                    ;|
;   (Disabled)  Alt + CapsLock + s  |  AltTab     (Switch Windows)               ;|
;               Alt + CapsLock + q  |  Ctrl + Tab (Close Windows)                ;|
;                     CapsLock + g  |  AppsKey    (Menu Key)                     ;|
;                   CapsLock + tab  |  
;-----------------------------------o---------------------------------------------o
CapsLock & s::Send, #{Tab}                                                       ;|----
;-----------------------------------o                                            ;|
CapsLock & q::                                                                   ;|
if GetKeyState("alt") = 0                                                        ;|
{                                                                                ;|
    Send, ^w                                                                     ;|
}                                                                                ;|
else {                                                                           ;|
    Send, !{F4}                                                                  ;|
    return                                                                       ;|
}                                                                                ;|
return                                                                           ;|
;-----------------------------------o                                            ;|
;CapsLock & g:: Send, {AppsKey}   								                 ;|------
;-----------------------------------o  							                 ;|	
CapsLock & d:: Send, ^#{right}                                                   ;|
CapsLock & a:: Send, ^#{left}                                                    ;|
;CapsLock & f:: Run D:\Program Files\Everything-1.4.1.895.x64\Everything.exe      ;|
CapsLock & e:: Run http://google.com/ncr                                         ;|
CapsLock & r:: Run Powershell                                                    ;|
CapsLock & t:: Run D:\Program Files\Notepad++\notepand++.exe                      ;|
CapsLock & tab:: Send, #{Tab} 
;---------------------------------------------------------------------------------o