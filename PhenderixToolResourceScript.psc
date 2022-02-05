Scriptname PhenderixToolResourceScript   

String function processName(String name) global
	Int index1 = stringutil.Find(name, "<", 0)
	if index1 != -1
		String s1 = stringutil.Substring(name, 0, index1)
		String s2 = stringutil.Substring(name, stringutil.GetLength(s1) + 1, 0)
		name = s1 + s2
	endIf
	index1 = stringutil.Find(name, ">", 0)
	if index1 != -1
		String s1 = stringutil.Substring(name, 0, index1)
		String s2 = stringutil.Substring(name, stringutil.GetLength(s1) + 1, 0)
		name = s1 + s2
	endIf
	index1 = stringutil.Find(name, ":", 0)
	if index1 != -1
		String s1 = stringutil.Substring(name, 0, index1)
		String s2 = stringutil.Substring(name, stringutil.GetLength(s1) + 1, 0)
		name = s1 + s2
	endIf
	index1 = stringutil.Find(name, "@", 0)
	if index1 != -1
		String s1 = stringutil.Substring(name, 0, index1)
		String s2 = stringutil.Substring(name, stringutil.GetLength(s1) + 1, 0)
		name = s1 + s2
	endIf
	index1 = stringutil.Find(name, "/", 0)
	if index1 != -1
		String s1 = stringutil.Substring(name, 0, index1)
		String s2 = stringutil.Substring(name, stringutil.GetLength(s1) + 1, 0)
		name = s1 + s2
	endIf
	index1 = stringutil.Find(name, "\\", 0)
	if index1 != -1
		String s1 = stringutil.Substring(name, 0, index1)
		String s2 = stringutil.Substring(name, stringutil.GetLength(s1) + 1, 0)
		name = s1 + s2
	endIf
	index1 = stringutil.Find(name, "|", 0)
	if index1 != -1
		String s1 = stringutil.Substring(name, 0, index1)
		String s2 = stringutil.Substring(name, stringutil.GetLength(s1) + 1, 0)
		name = s1 + s2
	endIf
	index1 = stringutil.Find(name, "*", 0)
	if index1 != -1
		String s1 = stringutil.Substring(name, 0, index1)
		String s2 = stringutil.Substring(name, stringutil.GetLength(s1) + 1, 0)
		name = s1 + s2
	endIf
	index1 = stringutil.Find(name, "?", 0)
	if index1 != -1
		String s1 = stringutil.Substring(name, 0, index1)
		String s2 = stringutil.Substring(name, stringutil.GetLength(s1) + 1, 0)
		name = s1 + s2
	endIf
	return name
endFunction


string Function Proteus_Round(float number, int precision) global
    string result = number as int
    number -= number as int
    if precision > 0
        result += "."
    endif
    while precision > 0
        number *= 10
        precision -= 1
        if precision == 0
            number += 0.5
        endif
        result += number as int
        number -= number as int
    endwhile
    return result
EndFunction


;option 0 = normal string, option 1 = int string, not built out yet
string Function Proteus_TextEntry(int option) global
	UITextEntryMenu textEntry = UIExtensions.GetMenu("UITextEntryMenu") as UITextEntryMenu 
	textEntry.OpenMenu()
	String result = textEntry.GetResultString()
	Int lengthInt = StringUtil.GetLength(result as String)
	
	return result

endFunction

String function ConvertIDToHex(Int m)
    String s
    int i = 0
    While (i < 8)
        int j = Math.LogicalAnd(m, 0xF)
        s = StringUtil.GetNthChar("0123456789abcdef", j) + s
        m = Math.RightShift(m, 4);
        i += 1
    EndWhile
    Return s
EndFunction


