;=== 自定义寄存器函数 ===

;F寄存器，存入数据时在数据尾部添加回车换行符对数据进行分隔，注意F寄存器是追加形式的寄存器
_@f(value)
{
    value := value . "`r`n"
    return value
}


;F寄存器，读出数据时，数据先进先出，数据移出后会从寄存器中删除
@f_(value)
{
    global registers
    if (value <> "")
    {
        StringTrimRight, value, value, 2
        StringSplit, OutputArray, value, `n, `r
        newvalue := ""
        Loop %OutputArray0%
            if (A_Index > 1)
                newvalue := newvalue . OutputArray%A_Index% . "`r`n"
        registers["@f"] := newvalue
        return OutputArray1
    }
    else
        return value
}