;=== np模式命令(notepad++) ===

;bm: 插入书签
np_bm()
{
    Send, ^{F2}
}


;ct: 关闭标签
np_ct()
{
    Send, ^{w}
}


;dc: 清除颜色标记
np_dc()
{
    Send, ^!+{F11}
}


;dm: 清除所有书签
np_dm()
{
    Send, ^!+{F2}
}


;ed: 展开当前层次
np_ed()
{
    Send, ^!+{f}
}


;ED: 展开所有层次
np_@e@d()
{
    Send, !+{0}
}


;fd: 折叠当前层次
np_fd()
{
    Send, ^!{f}
}


;FD: 折叠所有层次
np_@f@d()
{
    Send, !{0}
}


;ff: 查找
np_ff()
{
    Send, ^!i
}


;gd: 跳转到定义处
np_gd()
{
    Send, ^+{Enter}
}


;mc: 颜色标记
np_mc()
{
    Send, ^!+{F12}
}


;ml: 向下移动行
np_ml()
{
    Send, ^+{down}
}


;ML: 向上移动行
np_@m@l()
{
    Send, ^+{up}
}


;nb: 向后跳转
np_nb()
{
    Send, !{Left}
}


;nf: 向前跳转
np_nf()
{
    Send, !{Right}
}


;nm: 上一个书签
np_nm()
{
    Send, +{F2}
}


;nn: 查找下一个
np_nn()
{
    Send, {F3}
}


;NM: 下一个书签
np_@n@m()
{
    Send, {F2}
}


;NN: 查找上一个
np_@n@n()
{
    Send, +{F3}
}


;ns: 下一标签
np_ns()
{
    Send, ^{PgDn}
}


;NS: 上一标签
np_@n@s()
{
    Send, ^{PgUp}
}


;q: QuickText 扩展标签
np_q()
{
    Send, ^!{Tab}
}


;ru: 运行程序1
np_ru()
{
    Send, ^+{F5}
}


;RU: 运行程序2
np_@r@u()
{
    Send, ^+{F4}
}


;sc: SourceCookifier开关
np_sc()
{
    Send, ^!+{s}
}


;列编辑模式，光标向左移动
np_zh()
{
    Send, !+{Left}
}


;列编辑模式，光标向下移动
np_zj()
{
    Send, !+{Down}
}


;列编辑模式，光标向上移动
np_zk()
{
    Send, !+{Up}
}


;列编辑模式，光标向右移动
np_zl()
{
    Send, !+{Right}
}