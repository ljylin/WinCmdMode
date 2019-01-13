;=== 普通模式命令 ===

;A: 在行尾添加字符
@a()
{
    Send, {End}
    ExitCmdMode()
}


;ch: 更改前一个字符
ch()
{
    Send, +{Left}{Del}
    ExitCmdMode()
}


;cH: 更改至行首
c@h()
{
    Send, +{Home}{Del}
    ExitCmdMode()
}


;cj: 更改下一行
cj()
{
    Send, {Down}{Home}+{End}{Del}
    ExitCmdMode()
}


;cJ: 更改至文件尾
c@j()
{
    Send, +^{End}{Del}
    ExitCmdMode()
}


;ck: 更改上一行
ck()
{
    Send, {Up}{Home}+{End}{Del}
    ExitCmdMode()
}


;cK: 更改至文件头
c@k()
{
    Send, +^{Home}{Del}
    ExitCmdMode()
}


;cl: 更改下一字符
cl()
{
    Send, +{Right}{Del}
    ExitCmdMode()
}


;cL: 更改至行尾
c@l()
{
    Send, +{End}{Del}
    ExitCmdMode()
}


;cw: 更改至单词末尾
cw()
{
    Send, ^+{Right}{Del}
    ExitCmdMode()
}


;cW: 更改至单词头
c@w()
{
    Send, ^+{Left}{Del}
    ExitCmdMode()
}


;dd: 删除行
dd()
{
    global mode
    if (mode = "mw_")
        Send, {Home}+{End}{Del}
    else
        Send, {End}{Enter}{Up}{Home}+{Down 2}{Del}{Home}
}


;DD: 剪切当前行, 数字+DD: 向下剪切多行
@d@d()
{
    global num
    global reg
    times := RunTimes()
    if (RepeatCount(num) > 1)
    {
        if (times = 1)
            Send, {Home}
        else
            Send, +{Down}
        if (times = -1)
        {
            if (reg != "")
                SaveClipboard()
            Send, +{End}^x
            if (reg != "")
            {
                ClipboardToReg()
                RestoreClipboard()
            }
        }
    }
    else
    {
        if (reg != "")
            SaveClipboard()
        Send, {Home}+{End}^x
        if (reg != "")
        {
            ClipboardToReg()
            RestoreClipboard()
        }
    }
}


;dH: 删除至行首
d@h()
{
    Send, +{Home}{Del}
}


;dj: 删除下一行
dj()
{
    Send, {Down}
    dd()
    Send, {Up}
}


;dJ: 删除至文件尾
d@j()
{
    Send, ^+{End}{Del}
}


;dk: 删除上一行
dk()
{
    Send, {Up}
    dd()
}


;dK: 删除至文件头
d@k()
{
    Send, ^+{Home}{Del}
}


;dL: 删除至行尾
d@l()
{
    Send, +{End}{Del}
}


;dw: 向后删除单词
dw()
{
    Send, ^+{Right}{Del}
}


;dW: 向前删除单词
d@w()
{
    Send, ^+{Left}{Del}
}


;gg: 至文件头
gg()
{
    Send, ^{Home}
}


;G: 至文件尾  数字+G: 至某一行
@g()
{
    global num
    times := RunTimes()
    if (num.MaxIndex())
    {
        if (times = 1 or RepeatCount(num) = 1)
            Send, ^{Home}
        else
            j()
    }
    else
    {
        Send, ^{End}
    }
}


;h: 左
h()
{
    SetScrollLockState, off
    Send, {Left}
    SetScrollLockState, on
}


;H: 到行首
@h()
{
    SetScrollLockState, off
    Send, {Home}
    SetScrollLockState, on
}


;i: 插入字符
i()
{
    ExitCmdMode()
}


;j: 下
j()
{
    SetScrollLockState, off
    Send, {Down}
    SetScrollLockState, on
}


;J: 至文件尾
@j()
{
    Send, ^{End}
}


;k: 上
k()
{
    SetScrollLockState, off
    Send, {Up}
    SetScrollLockState, on
}


;K: 至文件头
@k()
{
    Send, ^{Home}
}


;l: 右
l()
{
    SetScrollLockState, off
    Send, {Right}
    SetScrollLockState, on
}


;L: 到行尾
@l()
{
    Send, {End}
}


;mo: 鼠标模式
mo()
{
    SetMode()
}


;mw: 可视化编辑器模式（比如：word）
mw()
{
    SetMode()
}


;mx: 电子表格程序模式（比如：excel）
mx()
{
    SetMode()
}


;np: 代码编辑器模式（比如：notepad++）
np()
{
    SetMode()
}


;o: 在下一行插入空行
o()
{
    Send, {End}{Enter}
}


;O: 在上一行插入空行
@o()
{
    Send, {Home}{Enter}{Up}
}


;p: 粘贴
p()
{
    global reg
    global mode
    if (reg != "")
    {
        SaveClipboard()
        RegToClipboard()
    }
    times := RunTimes()
    if (times != -1)
        Send, ^v{Enter}
    else
        Send, ^v
    if (reg != "")
    {
        if (mode = "mw_")
            sleep, 100
        RestoreClipboard()
    }
}


;rr: 恢复
rr()
{
    Send, ^y
}


;tt: Tab键
tt()
{
    global mode
    if (mode = "mx_")
        send, {Tab}
    else
    {
        @h()
        send, {Tab}
    }
}


;TT: Shift + Tab键
@t@t()
{
    global mode
    if (mode = "mx_")
        send, +{Tab}
    else
    {
        @h()
        send, +{Tab}
    }
}


;u: 撤消
u()
{
    Send, ^z
}


;v: 选择模式
v()
{
    SetMode()
}


;w: 跳至下一个单词
w()
{
    Send, ^{Right}
}


;W: 跳至上一个单词
@w()
{
    Send, ^{Left}
}


;x: 向前删除
x()
{
    Send, {Backspace}
}


;X: 向后删除
@x()
{
    Send, {Del}
}


;YY: 复制当前行, 数字+YY: 向下复制多行
@y@y()
{
    global reg
    global num
    times := RunTimes()
    if (RepeatCount(num) > 1)
    {
        if (times = 1)
            Send, {Home}
        else
            Send, +{Down}
        if (times = -1)
        {
            if (reg != "")
                SaveClipboard()
            Send, +{End}^c
            if (reg != "")
            {
                ClipboardToReg()
                RestoreClipboard()
            }
        }
    }
    else
    {
        if (reg != "")
            SaveClipboard()
        Send, {Home}+{End}^c
        if (reg != "")
        {
            ClipboardToReg()
            RestoreClipboard()
        }
    }
}


;zb: 将光标所在行向下滚动若干行
zb()
{
    Send, {WheelUp 4}
}


;zt: 将光标所在行向上滚动若干行
zt()
{
    Send, {WheelDown 4}
}


;ZZ: 保存
@z@z()
{
    Send, ^s
}


;/: 查找，绑定当前模式的ff命令
$/::
if GetKeyState("ScrollLock","T") = 1
{
    Gosub, *CapsLock
    if (Func(mode . "ff"))
        Func(mode . "ff").()
    else
        Send, ^f
}
else
    send, {/}
return


;^: 至行首
$+6::
if GetKeyState("ScrollLock","T") = 1
    Send, {Home}
else
    send, +{6}
return


;$: 至行尾
$$::
if GetKeyState("ScrollLock","T") = 1
    Send, {End}
else
    send, +{4}
return


;ctrl+r: 恢复
$^r::
if GetKeyState("ScrollLock","T") = 1
    Send, ^y
else
    send, ^r
return


;ctrl+f: 向下翻页
$^f::
if GetKeyState("ScrollLock","T") = 1
    Send, {PgDn}
else
    send, ^f
return


;ctrl+b: 向上翻页
$^b::
if GetKeyState("ScrollLock","T") = 1
    Send, {PgUp}
else
    send, ^b
return


;.: 在当前模式和鼠标模式之间切换
$.::
if GetKeyState("ScrollLock","T") = 1
{
    if (mode != "mo_")
    {
        if (mode != "v_")
            InternalRegister["tempvar"] := SubStr(mode, 1, -1)
        command := "mo"
        mo()
    }
    else
    {
        if (InternalRegister["tempvar"] != "")
        {
            command := InternalRegister["tempvar"]
            InternalRegister["tempvar"].()
        }
        else
        {
            GoNormal()
        }
    }
}
else
    send, {.}
return


;上箭头：绑定当前模式的zk命令
$Up::
if GetKeyState("ScrollLock","T") = 1
{
    if (Func(mode . "zk"))
        Func(mode . "zk").()
    else
        Send, {Up}
}
else
    Send, {Up}
return


;下箭头：绑定当前模式的zj命令
$Down::
if GetKeyState("ScrollLock","T") = 1
{
    if (Func(mode . "zj"))
        Func(mode . "zj").()
    else
        Send, {Down}
}
else
    Send, {Down}
return


;左箭头：绑定当前模式的zh命令
$Left::
if GetKeyState("ScrollLock","T") = 1
{
    if (Func(mode . "zh"))
        Func(mode . "zh").()
    else
        Send, {Left}
}
else
    Send, {Left}
return


;右箭头：绑定当前模式的zl命令
$Right::
if GetKeyState("ScrollLock","T") = 1
{
    if (Func(mode . "zl"))
        Func(mode . "zl").()
    else
        Send, {Right}
}
else
    Send, {Right}
return
