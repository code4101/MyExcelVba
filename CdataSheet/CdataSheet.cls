VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "CdataSheet"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim thisSt As Worksheet
Dim headerLine As Long '��ͷ�����У�Ĭ����һ����������ʼ��

Private Sub Class_Initialize()
    Set thisSt = ActiveSheet    'Ĭ���Ե�ǰ����ı���Ϊ������
    headerLine = 1          'Ĭ�ϵ�һ���Ǳ�ͷ
End Sub

Sub SetUp( _
    ByVal st_ As Worksheet, _
    Optional ByVal headerLine_ As Long = 1)
    
    Set thisSt = st_
    headerLine = headerLine_
    
End Sub

'�ж���һ�ű��ı�ͷ�Ƿ��thisSt��ͬ������theOtherStĩβ�����ͬ�У�
Function isInTheSameHeader(ByVal theOtherSt As Worksheet) As Boolean
    Dim j As Long
    For j = 1 To thisSt.UsedRange.Columns.Count
        If thisSt.Cells(headerLine, j) <> theOtherSt.Cells(headerLine, j) Then
            isInTheSameHeader = False
            Stop
            Exit Function
        End If
    Next j
    isInTheSameHeader = True
End Function

Sub ClearData()
    Dim dataStartLine As Long: dataStartLine = headerLine + 1
    Dim dataEndLine As Long: dataEndLine = thisSt.UsedRange.Rows.Count
    If dataEndLine > dataStartLine Then thisSt.Rows(dataStartLine & ":" & dataEndLine).Clear
    Debug.Print "�� "; thisSt.name; " ɾ����"; dataEndLine - headerLine; " ����¼"
End Sub

Sub AddData(ByVal fromSt As Worksheet, Optional ByVal paste As XlPasteType = xlPasteAll)
'(1)�ȼ���ͷ�Ƿ�һ��
    If Not isInTheSameHeader(fromSt) Then
        Debug.Print "thisSt:", thisSt.name; " fromSt:", fromSt.name; " ��ͷ�в���������ݶ�ȡ"
    End If
'(2)�������ֵ
    Dim lastLine1 As Long: lastLine1 = thisSt.UsedRange.Rows.Count
    Dim lastLine2 As Long: lastLine2 = fromSt.UsedRange.Rows.Count
    Dim n As Long: n = lastLine2 - headerLine   'Ҫ���ӵ�������
'(3)����
    If n <> 0 Then
        fromSt.Rows((headerLine + 1) & ":" & (headerLine + n)).Copy
        thisSt.Rows((lastLine1 + 1) & ":" & (lastLine1 + n)).PasteSpecial paste
    End If
    Debug.Print "�� "; fromSt.name; " ������"; n; "����¼�� "; thisSt.name
End Sub