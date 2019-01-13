#Include RegisterFunc.ahk     ;自定义寄存器函数

#MaxHotkeysPerInterval 200
SetCapsLockState, AlwaysOff
CoordMode, Mouse, Screen

num := []                      ;缓存输入的数字
command := ""                  ;缓存输入的命令
mode := ""                     ;当前所处的模式，默认为普通模式
prevmode := ""                 ;保存前一个模式
cmdlen := 2                    ;默认命令长度

;寄存器相关变量
usereg := false               ;用户是否按下双引号使用寄存器
reg := ""                      ;当前使用的寄存器，默认为系统剪贴板
registers := {}                ;用户寄存器对象
InternalRegister := {}         ;内部寄存器对象
clipsaved =                    ;存储系统剪贴板

;mo（鼠标）模式相关变量
mfast := 40                    ;鼠标快速移动速度（像素）
mmiddle := 15                  ;鼠标中速移动速度（像素）
mslow := 2                     ;鼠标慢速移动速度（像素）
mousespeed := mfast            ;鼠标当前移动速度（像素）
mousereg := []                 ;存储鼠标预置位

;屏幕提示相关变量
showosd := 1                   ;是否显示，0：不显示  1：显示
osdx := 970                    ;x坐标（像素）
osdy := 0                      ;y坐标（像素）
osdfont := "Verdana"           ;字体
osdfontsize := 11              ;字体大小
osdcolor := "Red"              ;颜色，使用16进制RGB或预定义的颜色名称
osdtextwidth := "xxxxxxxxxxxxxxxxxxxxx" ;提示文字宽度，默认12个字符，增加x占位符的数量可增加宽度


;设置屏幕提示参数，暂不显示
Gui +LastFound +AlwaysOnTop -Caption +ToolWindow
Gui, Font, s%osdfontsize% bold, %osdfont%
Gui, Add, Text, vMyText c%osdcolor%, %osdtextwidth%
WinSet, TransColor, FFFFFF 170


;静态设置4个鼠标预置点，如果不需要可注释掉下面4行代码
;用mo模式的y命令可动态设置预置点，注意如果使用这4个预置点，y命令设置的预置点将从第5个点位开始
;mo模式的gn命令可将鼠标按照预置点依次循环移动，默认从第5个点位开始，如果不使用这4个预置点，需要修改gn命令的pst变量改变起始位置
mousereg[1] := [ A_ScreenWidth/4,A_ScreenHeight/4 ]
mousereg[2] := [ A_ScreenWidth/4*3,A_ScreenHeight/4 ]
mousereg[3] := [ A_ScreenWidth/4,A_ScreenHeight/4*3 ]
mousereg[4] := [ A_ScreenWidth/4*3,A_ScreenHeight/4*3 ]

OnExit, ExitSub
return
;----------------------自动运行段结束----------------------



; CapsLock键：命令模式开关，打开时键盘ScrollLock指示灯亮，反之指示灯灭
*CapsLock::
if GetKeyState("ScrollLock","T") = 1
{
    SetScrollLockState, off
    SwitchOsd("Cancel")
}
else
{
    SetScrollLockState, on
    UpdateOsd()
    SwitchOsd("Show")
}
ClearBuffer()
return


;捕获数字
$0::
$1::
$2::
$3::
$4::
$5::
$6::
$7::
$8::
$9::
if GetKeyState("ScrollLock","T") = 1
{
    StringRight, number, A_ThisHotKey, 1
    num.Insert(number)
    UpdateOsd()
}
else
{
    number := SubStr(A_ThisHotKey,2)
    send, %number%
}
return


;捕获大小写字母
$a::
$b::
$c::
$d::
$e::
$f::
$g::
$h::
$i::
$j::
$k::
$l::
$m::
$n::
$o::
$p::
$q::
$r::
$s::
$t::
$u::
$v::
$w::
$x::
$y::
$z::
$+a::
$+b::
$+c::
$+d::
$+e::
$+f::
$+g::
$+h::
$+i::
$+j::
$+k::
$+l::
$+m::
$+n::
$+o::
$+p::
$+q::
$+r::
$+s::
$+t::
$+u::
$+v::
$+w::
$+x::
$+y::
$+z::
if GetKeyState("ScrollLock","T") = 1
{
    StringRight, keyname, A_ThisHotKey, 1
    if InStr(A_ThisHotKey, "+")
    {
        StringUpper, keyname, keyname
        keyname := "@" . keyname
    }
    if usereg
    {
        reg := keyname
        usereg := false
        UpdateOsd()
    }
    else
    {
        command := command . keyname
        UpdateOsd()
        Handle(command)
    }
}
else
{
    keyname := SubStr(A_ThisHotKey,2)
    send, %keyname%
}
return


;捕获双引号键，作为使用寄存器的标志
$"::                          ;"
if GetKeyState("ScrollLock","T") = 1
    usereg := true
else
    send, {"}                 ;"
return


;通用命令处理函数，会调用相应的命令函数
Handle(cmd)
{
    global cmdlen
    global num
    global mode
    global command
    CmdFunc := Func(cmd)
    if (mode != "" and cmd . "_" != mode)
        cmd := mode . cmd
    if Func(cmd)
        CmdFunc := Func(cmd)
    if CmdFunc
    {
        Loop % RepeatCount(num)
            CmdFunc.()
        ClearBuffer()
    }
    else
    {
        StringReplace, OutputVar, command, @, , UseErrorLevel
        if ((StrLen(command)-ErrorLevel) = cmdlen)
            ClearBuffer()
    }
    UpdateOsd()
}


;更新屏幕提示函数
UpdateOsd()
{
    global command
    global mode
    global reg
    global num
    StringReplace, regtext, reg, @, , All
    StringReplace, cmd, command, @, , All
    modename := SubStr(mode, 1, -1)
    StringReplace, modename, modename, @, , All
    if (modename != "")
        modename := "-" . modename . "-: "
    else
        modename := "-Normal-: "
    if (regtext = "")
        regtext := "| CLP |"
    else
        regtext := "| " . regtext . " |"
    numtext := RepeatCount(num)
    numtext := " " . numtext . " |  "
    GuiControl,, MyText, %regtext%%numtext%%modename%%cmd%
}


;屏幕提示显示切换函数
SwitchOsd(switch)
{
    global showosd
    global osdx
    global osdy
    if showosd
        Gui, %switch%, x%osdx% y%osdy% NoActivate
}


;清除缓存函数
ClearBuffer()
{
    global num
    global command
    global usereg
    global reg
    global clipsaved
    num := []
    command := ""
    usereg := false
    reg := ""
    clipsaved =
}


;计算命令重复次数函数
RepeatCount(num)
{
    count := 0
    For index, value in num
        count += (10**(num.MaxIndex()-index))*value
    if count=0
        count := 1
    return count
}


;命令重复执行时，调用此函数可返回正在执行的次数，最后一次返回 -1
;如果命令重复次数为1（既是第一次也是最后一次）返回 -1
RunTimes()
{
    global num
    repcount := RepeatCount(num)
    times := 1
    if (A_Index != 0)
        times = %A_Index%
    if (times = repcount)
        return -1
    else
        return times
}


;将文本写入reg变量指定的寄存器，如果寄存器名字首字符为@，将追加写入
Reg_Write(value)
{
    global registers
    global reg
    regfunc := Func("_" . reg)
    if (value = "")
    {
        registers[reg] := ""
    }
    else
    {
        if regfunc
            value := regfunc.(value)
        if InStr(reg,"@") = 1
            registers[reg] := registers[reg] . value
        else
            registers[reg] := value
    }
}


;返回reg变量指定的寄存器里的文本
Reg_Read()
{
    global registers
    global reg
    regfunc := Func(reg . "_")
    if regfunc
        return regfunc.(registers[reg])
    else
        return registers[reg]
}


;保存并清空系统剪贴板
SaveClipboard()
{
    global clipsaved
    clipsaved := ClipboardAll
    clipboard =
}


;恢复系统剪贴板
RestoreClipboard()
{
    global clipsaved
    Clipboard := clipsaved
    clipsaved =
}


;将系统剪贴板内容写入reg变量指定的寄存器
ClipboardToReg()
{
    global reg
    if (reg != "")
    {
        clipwait, 2
        Reg_Write(clipboard)
    }
}


;将reg变量指定的寄存器内容写入系统剪贴板
RegToClipboard()
{
    global reg
    if (reg != "")
    {
        Clipboard := Reg_Read()
        clipwait, 2
    }
}


;将指定的变量名和值写入内部寄存器对象，默认不同命令函数存入的同名变量相互独立，不互相干扰
;cmdfunc为可选参数，传入别的命令函数名称可向该命令函数的变量写入值
InternalReg_Write(varname,value,cmdfunc:=0)
{
    global command
    global mode
    global InternalRegister
    if (cmdfunc = 0)
        parentfunc := mode . command . "_"
    else
        parentfunc := cmdfunc . "_"
    varname := parentfunc . varname
    InternalRegister[varname] := value
}


;将指定的变量从内部寄存器对象中读出,默认读出命令函数自己存入的变量
;cmdfunc为可选参数，传入别的命令函数名称可读出该命令函数存入的变量
InternalReg_Read(varname,cmdfunc:=0)
{
    global command
    global mode
    global InternalRegister
    if (cmdfunc = 0)
        parentfunc := mode . command . "_"
    else
        parentfunc := cmdfunc . "_"
    varname := parentfunc . varname
    return InternalRegister[varname]
}


;设置自定义模式函数
SetMode()
{
    global command
    global mode
    global prevmode
    global reg
    regbak := reg
    modename := command . "_"    
    parentfunc := mode . command
    if (!Func(parentfunc) or mode = "")
    {
    	prevmode := mode
        if (mode = modename)
            mode := ""
        else
            mode := modename
    }
    ClearBuffer()
    reg := regbak
    UpdateOsd()
    Exit
}


;返回普通模式函数
GoNormal()
{
    global mode
    global prevmode
    if (RunTimes() = -1)
    {
    	prevmode := mode
        mode := ""
        ClearBuffer()
        UpdateOsd()
        Exit
    }
}


;返回前一个模式函数
GoPrevMode()
{
    global mode
    global prevmode
    if (RunTimes() = -1)
    {
    	pmode := prevmode
    	prevmode := mode
        mode := pmode
        ClearBuffer()
        UpdateOsd()
        Exit
    }
}


;退出命令模式函数
ExitCmdMode()
{
    if (RunTimes() = -1)
    {
        Gosub, *CapsLock
        Exit
    }
}


;非正常退出时做一些清理工作
ExitSub:
SetScrollLockState, off
SwitchOsd("Cancel")
ClearBuffer()
ExitApp
return


;==============================以下是命令函数定义区==============================
;  (建议此注释与命令函数保持同步更新，以便于规划和查找命令)
;  (部分命令与具体软件相关，应该和该软件的快捷键设置保持一致)

;  普通模式：A,ch,cH,cj,cJ,ck,cK,cl,cL,cw,cW,dd,DD,dH,dj,dJ,dk,dK,dL,dw,dW,gg,G,h,H,i,j,J,k,K,l,L,mo(模式),
;            mw(模式),mx(模式),np(模式),o,O,p,rr,tt,TT,u,v(模式),w,W,x,X,YY,zb,zt,ZZ,/,^,$,ctrl+r,ctrl+f,ctrl+b,.
;  v模式：   a,bd,bo,d,fc,fd,fn,fr,fs,gg,G,h,H,j,J,k,K,l,L,mc,ml,mp,my,ML,p,sc,w,W,x,X,y
;  mo模式：  a,bw,cc,cd,ct,cw,dt,e,E,ff,gg,gm,gn,go,G,h,H,j,J,k,K,l,L,ma,mc,md,me,mf,mn,Md,ME,ne,ns,nt,NP,NS,o,O,r,R,sd,t,w,W,y
;  mw模式:   bd,bm,cc,ce,cr,ct,dc,dm,dr,dt,fc,fn,fs,J,K,mc,mp,my,nm,nw,PR,PS,sc,sw,tb,tc,TC,tr,TR,zi,ZJ,ZK,zo
;  mx模式:   af,bd,bm,bo,cc,ce,cf,cr,dc,dm,dr,ds,fc,fd,fn,fr,fs,fu,H,I,J,K,L,mc,nm,ns,NS,PR,PS,so,su,tc,tr,ZH,zi,ZJ,ZK,ZL,zo
;  np模式：  bm,ct,dc,dm,ed,ED,fd,FD,ff,gd,mc,ml,ML,nb,nf,nm,nn,NM,NN,ns,NS,q,ru,RU,sc,zh,zj,zk,zl
;================================================================================

#Include normal.ahk            ;普通模式命令
#Include v.ahk                 ;v模式命令（选择模式）
#Include mo_mouse.ahk          ;mo模式命令（鼠标模式）
#Include mw_word2003.ahk       ;mw模式命令（word2003适用）
#Include mx_excel2003.ahk      ;mx模式命令（excel2003适用）
#Include np_notepad++.ahk      ;np模式命令（notepad++适用）
#Include GoScript.ahk          ;自定义脚本，供mo（鼠标）模式的go命令调用
