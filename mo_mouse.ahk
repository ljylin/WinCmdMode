;=== mo模式命令(鼠标和文件管理模式) ===

;a: 切换鼠标移动速度（快、中、慢三种模式），数字+a：修改当前模式速度
mo_a()
{
    global mousespeed
    global mfast
    global mmiddle
    global mslow
    global num
    if (num.MaxIndex())    
    {
        if (mousespeed = mfast)
        {
            mfast := RepeatCount(num)
            mousespeed := mfast
        }
        else if (mousespeed = mmiddle)
        {
            mmiddle := RepeatCount(num)
            mousespeed := mmiddle
        }
        else
        {
            mslow := RepeatCount(num)
            mousespeed := mslow
        }
    }
    else
    {
        if (mousespeed = mfast)
            mousespeed := mmiddle
        else if (mousespeed = mmiddle)
            mousespeed := mslow
        else
            mousespeed := mfast
    }
    ClearBuffer()
    UpdateOsd()
    Exit
}


;bw: 打开浏览器
mo_bw()
{
    Run http://10.43.176.5
}


;cc: 打开计算器
mo_cc()
{
    Run, calc.exe
}


;cd: 打开windows命令窗口
mo_cd()
{
    Run cmd
}


;ct: 关闭IE选项卡
mo_ct()
{
    Send, ^{w}
}


;cw: 关闭窗口
mo_cw()
{
    if WinActive("ahk_class ConsoleWindowClass")
        Send, !{Space}c
    else
        Send, !{F4}
}


;dt: 显示桌面，数字+dt：切换到对应的虚拟桌面，需安装VirtuaWin并设置相应的快捷键
mo_dt()
{
    global num
    DesktopNum := RepeatCount(num)
    if (num.MaxIndex())
    {
        if (DesktopNum = 1)
            Send, #!1
        if (DesktopNum = 2)
            Send, #!2
        if (DesktopNum = 3)
            Send, #!3
        if (DesktopNum = 4)
            Send, #!4
    }
    else
    {
        Send, #d
    }
    ClearBuffer()
    UpdateOsd()
    Exit
}


;e: 向下滚动
mo_e()
{
    Send, {WheelDown 2}    
}


;E: 向上滚动
mo_@e()
{
    Send, {WheelUp 2}    
}


;ff: 搜索文件
mo_ff()
{
    Run %A_ProgramFiles%\Everything\Everything.exe
}


;gg: 鼠标移动到屏幕顶部中间，数字+gg：鼠标移动到数字对应的预置点
mo_gg()
{
    global mousereg
    global num
    PresetPoint := RepeatCount(num)
    if (num.MaxIndex())
    {
        if(PresetPoint <= mousereg.MaxIndex())
            MouseMove, mousereg[PresetPoint][1], mousereg[PresetPoint][2], 0
    }
    else
    {
        x := A_ScreenWidth / 2
        y := 40
        MouseMove, x, y, 0    
    }
    ClearBuffer()
    UpdateOsd()
    Exit
}


;gm: 鼠标移动到屏幕中间
mo_gm()
{
    x := A_ScreenWidth / 2
    y := A_ScreenHeight / 2
    MouseMove, x, y, 0
}


;gn: 鼠标从第5个预置点开始依次循环移动，修改pst变量可改变起始位置
mo_gn()
{
    global mousereg
    pst := 5
    PresetPoint := InternalReg_Read("PresetPoint")
    if ((PresetPoint = "") OR (++PresetPoint > mousereg.MaxIndex()))
        PresetPoint := pst
    if (PresetPoint <= mousereg.MaxIndex())
        MouseMove, mousereg[PresetPoint][1], mousereg[PresetPoint][2], 0
    InternalReg_Write("PresetPoint",PresetPoint)
}


;go：运行自定义脚本
mo_go()
{
    global num
    if (num.MaxIndex())
    {
        scriptnum := RepeatCount(num)
        scriptfunc := Func("#" . scriptnum)
        if scriptfunc
            scriptfunc.()
    }
    ClearBuffer()
    UpdateOsd()
    Exit
}


;G: 鼠标移动到屏幕底部中间
mo_@g()
{
    x := A_ScreenWidth / 2
    y := A_ScreenHeight - 60
    MouseMove, x, y, 0
}


;h: 向左移动鼠标
mo_h()
{
    global mousespeed
    MouseMove, -mousespeed, 0, 0, R
}


;H: 鼠标移动到当前行行首
mo_@h()
{
    MouseGetPos, xpos, ypos
    MouseMove, 40, ypos, 0
}


;j: 向下移动鼠标
mo_j()
{
    global mousespeed
    MouseMove, 0, mousespeed, 0, R
}


;J: 鼠标移动到当前列列尾
mo_@j()
{
    MouseGetPos, xpos, ypos
    MouseMove, xpos, A_ScreenHeight - 80, 0
}


;k: 向上移动鼠标
mo_k()
{
    global mousespeed
    MouseMove, 0, -mousespeed, 0, R
}


;K: 鼠标移动到当前列列首
mo_@k()
{
    MouseGetPos, xpos, ypos
    MouseMove, xpos, 140, 0
}


;l: 向右移动鼠标
mo_l()
{
    global mousespeed
    MouseMove, mousespeed, 0, 0, R
}


;L: 鼠标移动到当前行行尾
mo_@l()
{
    MouseGetPos, xpos, ypos
    MouseMove, A_ScreenWidth-40, ypos, 0
}


;ma: 最大化
mo_ma()
{
    Send, !{Space}x
}


;mc: 打开我的电脑
mo_mc()
{
    Run ::{20d04fe0-3aea-1069-a2d8-08002b30309d}
}


;md: 打开我的文档
mo_md()
{
    Run ::{450d8fba-ad25-11d0-98a8-0800361b1103}
}


;me: 编辑此脚本
mo_me()
{
    Run D:\notepad++\notepad++.exe %A_ScriptFullPath%
}


;mf: 打开我的文件夹
mo_mf()
{
    Run, D:\My Documents\林健（勿删）
}


;mn: 最小化
mo_mn()
{
    Send, !{Space}n
}


;Md: 新建文件夹，数字+Md: 新建多个文件夹
mo_@md()
{
    global num
    count := RepeatCount(num)
    times := RunTimes()
    if (times = -1)
        times := count
    FileCreateDir, %times%
}


;ME：重新加载本脚本
mo_@m@e()
{
    Reload
}


;ne: 打开网上邻居
mo_ne()
{
    Run ::{208d2c60-3aea-1069-a2d7-08002b30309d}
}


;ns: 浏览器移动到下一标签
mo_ns()
{
    Send, ^{Tab}
}


;nt: 打开网络连接
mo_nt()
{
    Run ::{7007acc7-3202-11d1-aad2-00805fc1270e}
}


;NP: 打开notepad++
mo_@n@p()
{
    Run D:\notepad++\notepad++.exe
}


;NS: 浏览器移动到上一标签
mo_@n@s()
{
    Send, ^+{Tab}
}


;o: 打开OA
mo_o()
{
    Run %A_ProgramFiles%\Internet Explorer\IEXPLORE.EXE http://68.150.46.2/login.aspx?loginname=linjian&password=proof
}


;O: 打开OA
mo_@o()
{
    Run %A_ProgramFiles%\Internet Explorer\IEXPLORE.EXE http://68.150.46.2/login.aspx?loginname=liu_yan&password=000000
}


;r: 点击鼠标左键
mo_r()
{
    global mousespeed
    global mfast
    Send, {LButton}
    mousespeed := mfast
}


;R: 鼠标左键按住/释放切换
mo_@r()
{
    global mousespeed
    global mfast
    if GetKeyState("LButton")
        Click up
    else
    {
        Send, {LButton}
        Sleep, 500
        Click down
    }
    mousespeed := mfast
}


;sd: 设置当前工作目录
mo_sd()
{
    SetWorkingDir %clipboard%
}


;t: 点击鼠标右键
mo_t()
{
    global mousespeed
    global mfast
    Send, {RButton}
    mousespeed := mfast
}


;w: 在当前行向后移动鼠标
mo_w()
{
    MouseMove, 180, 0, 0, R
}


;W: 在当前行向前移动鼠标
mo_@w()
{
    MouseMove, -180, 0, 0, R
}


;y: 保存鼠标当前位置为预置点，默认为追加写入，数字+y：替换数字所对应的预置点，0+y：清除所有预置点
mo_y()
{
    global mousereg
    global num
    PresetPoint := RepeatCount(num)
    MouseGetPos, xpos, ypos
    if (num.MaxIndex())
    {
        if (num[1] = 0)
        {
            rep := mousereg.MaxIndex()
            Loop % rep
                mousereg.Remove(1)
        }
        else
        {
            if (PresetPoint <= mousereg.MaxIndex())
                mousereg[PresetPoint] := Array(xpos,ypos)
        }
    }
    else
        mousereg.Insert(Array(xpos,ypos))
    ClearBuffer()
    UpdateOsd()
    Exit
}