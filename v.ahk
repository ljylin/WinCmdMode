;=== v模式命令(选择模式) ===

;a: 全选
v_a()
{
    Send, ^a
}


;bd: 调用mw模式和mx模式的设置粗体命令
v_bd()
{
    global prevmode
    global command
    if (prevmode = "mw_" or prevmode = "mx_")
        if Func(prevmode . command)
            Func(prevmode . command).()
    GoPrevMode()
}


;bo: 调用mx模式的设置边框命令
v_bo()
{
    global mode
    global prevmode
    global command
    if (prevmode = "mx_")
        if Func(prevmode . command)
        {
            mode := prevmode
            Func(prevmode . command).()
        }
    mode := "v_"
    GoPrevMode()
}


;d: 剪切
v_d()
{
    global reg
    if (reg != "")
        SaveClipboard()
    if GetKeyState("LButton")
        Click up
    Send, ^x
    if (reg != "")
    {
        ClipboardToReg()
        RestoreClipboard()
    }
    GoPrevMode()
}


;fc: 调用mw模式或mx模式的设置字体颜色命令
v_fc()
{
    global mode
    global prevmode
    global command
    if (prevmode = "mw_" or prevmode = "mx_")
        if Func(prevmode . command)
        {
            mode := prevmode
            Func(prevmode . command).()
        }
    mode := "v_"
    GoPrevMode()
}


;fd: 调用mx模式向下填充命令
v_fd()
{
    global prevmode
    global command
    if (prevmode = "mx_")
        if Func(prevmode . command)
            Func(prevmode . command).()
    GoPrevMode()
}


;fn: 调用mw模式或mx模式的设置字体命令
v_fn()
{
    global prevmode
    global command
    if (prevmode = "mw_" or prevmode = "mx_")
        if Func(prevmode . command)
            Func(prevmode . command).()
    GoPrevMode()
}


;fr: mx模式向右填充
v_fr()
{
    global prevmode
    global command
    if (prevmode = "mx_")
        if Func(prevmode . command)
            Func(prevmode . command).()
    GoPrevMode()
}


;fs: 调用mw模式或mx模式的设置字体大小命令
v_fs()
{
    global prevmode
    global command
    if (prevmode = "mw_" or prevmode = "mx_")
        if Func(prevmode . command)
            Func(prevmode . command).()
    GoPrevMode()
}


;gg: 选择至文件头
v_gg()
{
    Send, ^+{Home}
}


;G: 选择至文件尾
v_@g()
{
    Send, ^+{End}
}


;h: 向左选择字符
v_h()
{
    SetScrollLockState, off
    Send, +{Left}
    SetScrollLockState, on
}


;H: 选择至行首
v_@h()
{
    global prevmode
    if (prevmode = "mx_" AND Func("mx_@z@h"))
        Func("mx_@z@h").()
    else
        Send, +{Home}
}


;j: 向下选择字符
v_j()
{
    SetScrollLockState, off
    Send, +{Down}
    SetScrollLockState, on
}


;J: 如果前一个模式是mw模式，向下选择一个段落，如果前一个模式是mx模式，选择至列尾，否则选择至文件尾
v_@j()
{
    global prevmode
    if (prevmode = "mw_" AND Func("mw_@z@j"))
        Func("mw_@z@j").()
    else if (prevmode = "mx_" AND Func("mx_@z@j"))
        Func("mx_@z@j").()
    else
        Send, ^+{End}
}


;k: 向上选择字符
v_k()
{
    SetScrollLockState, off
    Send, +{Up}
    SetScrollLockState, on
}


;K: 如果前一个模式是mw模式，向上选择一个段落，如果前一个模式是mx模式，选择至列头，否则选择至文件头
v_@k()
{
    global prevmode
    if (prevmode = "mw_" AND Func("mw_@z@k"))
        Func("mw_@z@k").()
    else if (prevmode = "mx_" AND Func("mx_@z@k"))
        Func("mx_@z@k").()
    else
        Send, ^+{Home}
}


;l: 向右选择字符
v_l()
{
    SetScrollLockState, off
    Send, +{Right}
    SetScrollLockState, on
}


;L: 选择至行尾
v_@l()
{
    global prevmode
    if (prevmode = "mx_" AND Func("mx_@z@l"))
        Func("mx_@z@l").()
    else
        Send, +{End}
}


;mc: 调用np模式颜色标记命令或mw和mx模式的合并单元格命令
v_mc()
{
    global prevmode
    global command
    if (prevmode = "np_" or prevmode = "mw_" or prevmode = "mx_")
        if Func(prevmode . command)
            Func(prevmode . command).()
    GoPrevMode()
}


;ml: 调用np模式向下移动行命令
v_ml()
{
    global prevmode
    global command
    if (prevmode = "np_")
        if Func(prevmode . command)
            Func(prevmode . command).()
    GoPrevMode()
}


;mp: 调用mw模式粘贴格式命令
v_mp()
{
    global prevmode
    global command
    if (prevmode = "mw_")
        if Func(prevmode . command)
            Func(prevmode . command).()
    GoPrevMode()
}


;my: 调用mw模式复制格式命令
v_my()
{
    global prevmode
    global command
    if (prevmode = "mw_")
        if Func(prevmode . command)
            Func(prevmode . command).()
    GoPrevMode()
}


;ML: 调用np模式向上移动行命令
v_@m@l()
{
    global prevmode
    global command
    if (prevmode = "np_")
        if Func(prevmode . command)
            Func(prevmode . command).()
    GoPrevMode()
}


;p: 粘贴
v_p()
{
    p()
    GoPrevMode()
}


;sc: 调用mw模式的拆分单元格命令
v_sc()
{
    global prevmode
    global command
    if (prevmode = "mw_")
        if Func(prevmode . command)
            Func(prevmode . command).()
    GoPrevMode()
}


;w: 选择下一个单词
v_w()
{
    Send, ^+{Right}
}


;W: 选择上一个单词
v_@w()
{
    Send, ^+{Left}
}


;x: 向前删除
v_x()
{
    x()
    GoPrevMode()
}


;X: 向后删除
v_@x()
{
    @x()
    GoPrevMode()
}


;y: 复制
v_y()
{
    global reg
    if (reg != "")
        SaveClipboard()
    if GetKeyState("LButton")
        Click up
    Send, ^c
    if (reg != "")
    {
        ClipboardToReg()
        RestoreClipboard()
    }
    GoPrevMode()
}