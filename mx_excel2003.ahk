;=== mx模式命令(excel2003) ===

;af: 自动筛选开关
mx_af()
{
    Send, !dff
}


;bd: 加粗
mx_bd()
{
    Send, ^b
}


;bm: 插入书签
mx_bm()
{
    if ( NOT IsObject(InternalReg_Read("bm")))
        InternalReg_Write("bm",[])
    SaveClipboard()
    send, !inl^c
    sleep, 300
    InternalReg_Read("bm").Insert(clipboard)
    RestoreClipboard()
    mo_cw()
}


;bo: 设置边框，0+bo: 清除边框
mx_bo()
{
    global num
    mx_cf()
    sleep, 200
    MouseMove, 560, 359, 0
    mo_r()
    sleep, 200
    if (num.MaxIndex())
    {
        if (num[1] = 0)
            send, !n{Enter}
        else
            mo_cw()
    }
    else
        send, !o!i{Enter}
    ClearBuffer()
    UpdateOsd()
    Exit
}


;cc: 选中列
mx_cc()
{
    mx_@k()
    mx_@k()
    Send, ^+{Down 2}
}


;ce: 水平居中（需设置excel快捷键）
mx_ce()
{
    send, !c
}


;cf: 显示单元格格式对话框
mx_cf()
{
    Send, ^1
}


;cr: 选中行
mx_cr()
{
    send, +{Space}
}


;dc: 删除列
mx_dc()
{
    send, !ed!c
    sleep, 200
    send, {Enter}
}


;dm: 删除所有书签
mx_dm()
{
    bmcount := InternalReg_Read("bm","mx_bm").MaxIndex()
    if (bmcount <> "")
    {
        Loop, %bmcount%
            InternalReg_Read("bm","mx_bm").Remove(1)
        InternalReg_Write("curbm","","mx_nm")
    }
}


;dr: 删除行
mx_dr()
{
    send, !ed!r
    sleep, 200
    send, {Enter}
}


;ds: 删除Sheet
mx_ds()
{
    send, !el
}


;fc: 字体颜色为自动，数字+fc: 设置字体颜色为相应的颜色（1:红色）
mx_fc()
{
    global num
    mx_cf()
    sleep, 200
    MouseMove, 490, 358, 0
    mo_r()
    sleep, 200
    if (num.MaxIndex())
    {
        if (RepeatCount(num) = 1)
            send, !c{Down 3}{Enter}{Tab 2}{Enter}
        else
            mo_cw()
    }
    else
        send, !c{Enter}{Tab 2}{Enter}
    ClearBuffer()
    UpdateOsd()
    Exit
}


;fd: 向下填充
mx_fd()
{
    Send, ^d
}


;fn: 设置字体
mx_fn()
{
    Send, ^+f{Esc}{Down}
}


;fr: 向右填充
mx_fr()
{
    Send, ^r
}


;fs: 选择字号
mx_fs()
{
    Send, ^+p{Esc}{Down}
}


;fu: 显示插入函数对话框
mx_fu()
{
    Send, +{F3}
}


;H: 移动到当前数据区域的左边缘
mx_@h()
{
    SetScrollLockState, off
    send, ^{Left}
    SetScrollLockState, on
}


;I: 编辑活动单元格并将插入点放在单元格内容的结尾
mx_@i()
{
    Send, {F2}
}


;J: 移动到当前数据区域的下边缘
mx_@j()
{
    SetScrollLockState, off
    send, ^{Down}
    SetScrollLockState, on
}


;K: 移动到当前数据区域的上边缘
mx_@k()
{
    SetScrollLockState, off
    send, ^{Up}
    SetScrollLockState, on
}


;L: 移动到当前数据区域的右边缘
mx_@l()
{
    SetScrollLockState, off
    send, ^{Right}
    SetScrollLockState, on
}


;mc: 合并/拆分单元格开关
mx_mc()
{
    mx_cf()
    MouseMove, 440, 360, 0
    mo_r()
    MouseMove, 389, 545, 0
    mo_r()
    send, {Enter}
}


;nm: 下一个书签
mx_nm()
{
    if (InternalReg_Read("bm","mx_bm").MaxIndex() <> "")
    {
        curbm := InternalReg_Read("curbm")
        if (curbm = "" OR curbm = InternalReg_Read("bm","mx_bm").MaxIndex())
            curbm := 1
        else
            curbm += 1
        InternalReg_Write("curbm",curbm)
        SaveClipboard()
        clipboard := InternalReg_Read("bm","mx_bm")[curbm]
        send, !eg^v
        sleep, 300
        send, {Enter}
        RestoreClipboard()
    }
}


;ns: 切换下一个Sheet，数字+ns：新建相应数量的Sheet
mx_ns()
{
    global num
    if (num.MaxIndex())
        Loop % RepeatCount(num)
            send, +{F11}
    else    
        send, ^{PgDn}
    ClearBuffer()
    UpdateOsd()
    Exit
}


;NS: 切换上一个Sheet
mx_@n@s()
{
    send, ^{PgUp}
}


;PR: 打开打印设置对话框
mx_@p@r()
{
    send, !fp
}


;PS: 打开页面设置对话框
mx_@p@s()
{
    send, !fu
}


;so: 打开排序对话框
mx_so()
{
    Send, !ds
}


;su: 插入SUM函数求和
mx_su()
{
    Send, !=
}


;tc: 插入列
mx_tc()
{
    Send, !ic
}


;tr: 插入行
mx_tr()
{
    Send, !ir
}


;ZH: 选择至行首
mx_@z@h()
{
    Send, ^+{Left}
}


;zi: 放大
mx_zi()
{
    Send, ^{WheelUp}
}


;ZJ: 选择至列尾
mx_@z@j()
{
    Send, ^+{Down}
}


;ZK: 选择至列头
mx_@z@k()
{
    Send, ^+{Up}
}


;ZL: 选择至行尾
mx_@z@l()
{
    Send, ^+{Right}
}


;zo: 缩小
mx_zo()
{
    Send, ^{WheelDown}
}