;=== mw模式命令(word2003) ===

;bd: 粗体
mw_bd()
{
    Send, ^B
}


;bm: 插入书签
mw_bm()
{
    bmcount := InternalReg_Read("bmcount")
    if (bmcount = "")
        bmcount := 1
    else
        bmcount += 1
    InternalReg_Write("bmcount",bmcount)
    Send, ^+{F5}
    Send, +b
    Send, %bmcount%
    Send, !a
}


;cc: 表格选择列
mw_cc()
{
    Send, !acc
}


;ce: 居中
mw_ce()
{
    Send, ^e
}


;cr: 表格选择行
mw_cr()
{
    Send, !acr
}


;ct: 选中整张表格
mw_ct()
{
    SetNumLockState, off
    Send, !{NumpadClear}
    SetNumLockState, on
}


;dc: 删除列
mw_dc()
{
    send, !adc
}


;dm: 删除所有书签
mw_dm()
{
    bmcount := InternalReg_Read("bmcount","mw_bm")
    if (bmcount <> "")
    {
        Send, ^+{F5}
        Loop, %bmcount%
        {
            Send, +b
            Send, %bmcount%
            Send, !d
            bmcount -= 1
        }
        InternalReg_Write("bmcount","","mw_bm")
        InternalReg_Write("curbm","","mw_nm")
        Sleep, 100
        mo_cw()
    }
}


;dr: 删除行
mw_dr()
{
    send, !adr
}


;dt: 删除表格
mw_dt()
{
    send, !adt
}


;fc: 字体颜色为自动，数字+fc: 设置字体颜色为相应的颜色（1:红色）
mw_fc()
{
    global num
    if (num.MaxIndex())
    {
        if (RepeatCount(num) = 1)
            send, !of!c{Down 3}{Enter}{Tab 15}{Enter}
    }
    else
        send, !of!c{Enter}{Tab 15}{Enter}
    ClearBuffer()
    UpdateOsd()
    Exit
}


;fn: 选择字体
mw_fn()
{
    Send, ^+f{Esc}{Down}
}


;fs: 选择字号
mw_fs()
{
    Send, ^+p{Esc}{Down}
}


;J: 下移一段
mw_@j()
{
    Send, ^{Down}
}


;K: 上移一段
mw_@k()
{
    Send, ^{Up}
}


;mc: 合并单元格
mw_mc()
{
    send, !am
}


;mp: 粘贴格式
mw_mp()
{
    Send, ^+v
}


;my: 复制格式
mw_my()
{
    Send, ^+c
}


;nm: 下一个书签
mw_nm()
{
    bmcount := InternalReg_Read("bmcount","mw_bm")
    if (bmcount <> "")
    {
        curbm := InternalReg_Read("curbm")
        if (curbm = "" OR curbm = bmcount)
            curbm := 1
        else
            curbm += 1
        InternalReg_Write("curbm",curbm)
        Send, ^+{F5}
        Send, +b
        Send, %curbm%
        Send, !g
        Sleep, 100
        mo_cw()
    }
}


;nw: 下一窗口
mw_nw()
{
    Send, {F6}
}


;PR: 打开打印设置对话框
mw_@p@r()
{
    send, !fp
}


;PS: 打开页面设置对话框
mw_@p@s()
{
    send, !fu
}


;sc: 拆分单元格
mw_sc()
{
    send, !ap
}


;sw: 分割窗口
mw_sw()
{
    static split := 1
    if split = 1
    {
        Send, !^s
        split := 0
    }
    else
    {
        Send, !+C
        split := 1
    }
}


;tb: 插入表格，数字+tb指定列数，行数默认10行，并表格居中，单元格对齐居中
mw_tb()
{
    global num
    col := RepeatCount(num)
    send, !ait!c
    send, %col%
    send, !r10
    send, {Enter}
    mw_ct()
    mw_ce()
    send, {AppsKey}g{Right}{Down}{Enter}{Up}{Down}
    ClearBuffer()
    UpdateOsd()
    Exit
}


;tc: 插入列在右边，并单元格对齐居中
mw_tc()
{
    send, !air
    mw_cc()
    send, {AppsKey}g{Right}{Down}{Enter}{Right}{Left}
}


;TC: 插入列在左边，并单元格对齐居中
mw_@t@c()
{
    send, !ail
    mw_cc()
    send, {AppsKey}g{Right}{Down}{Enter}{Right}{Left}
}


;tr: 插入行在下方
mw_tr()
{
    send, !aib
    send, {Left}
}


;TR: 插入行在上方
mw_@t@r()
{
    send, !aia
    send, {Left}
}


;zi: 放大
mw_zi()
{
    Send, ^{WheelUp}
}


;ZJ: 选择下一段
mw_@z@j()
{
    Send, ^+{Down}
}


;ZK: 选择上一段
mw_@z@k()
{
    Send, ^+{Up}
}


;zo: 缩小
mw_zo()
{
    Send, ^{WheelDown}
}