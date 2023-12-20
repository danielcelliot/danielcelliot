VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_frmLabProgrammeEntry"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Compare Database
Option Explicit

Private Sub btnClose_Click()

DoCmd.Close acForm, Me.Name

End Sub

Private Sub btnNewProgramme_Click()

DoCmd.OpenForm "frmAddProgramme", , , , acFormAdd
Me.lstProgramme.Requery
' call form's Current event procedure to update list box
Form_Current

End Sub

Private Sub cboLab_AfterUpdate()

' find matching row in form's recordset's clone
' and synchronize bookmarks if found
With Me.RecordsetClone
    .FindFirst "LabId = " & Nz(Me.cboLab, 0)
    If Not .NoMatch Then
        Me.Bookmark = .Bookmark
    End If
End With

End Sub

Private Sub Form_Current()

Dim varItem As Variant
Dim strCriteria As String
Dim i As Integer

' synchronize go to lab combo box
' with current record
Me.cboLab = Me.LabId

With Me.lstProgramme
    ' deselect all items in list box
    For i = .ListCount - 1 To 0 Step -1
        .Selected(i) = False
    Next i
    .Requery
    ' loop through list box items and select items where lab assigned to programme
    For i = .ListCount - 1 To 0 Step -1
        strCriteria = "LabId = " & Nz(Me.LabId, 0) & " And ProgrammeId = " & .ItemData(i)
        .Selected(i) = Not IsNull(DLookup("LabId", "tblLabProgramme", strCriteria))
    Next i
End With

End Sub

Private Sub lstProgramme_AfterUpdate()

Dim i As Integer
Dim strCriteria As String
Dim strSQL As String

With Me.lstProgramme
    For i = .ListCount - 1 To 0 Step -1
        strCriteria = "LabId = " & Nz(Me.LabId, 0) & " And ProgrammeId = " & .ItemData(i)
        If .Selected(i) = False Then
            ' if item has been deselected then delete row from table
            If Not IsNull(DLookup("LabId", "tblLabProgramme", strCriteria)) Then
               strSQL = "DELETE * FROM tblLabProgramme WHERE " & strCriteria
               CurrentDb.Execute strSQL, dbFailOnError
            End If
        Else
            ' if item has been selected then insert row into table
             If IsNull(DLookup("LabId", "tblLabProgramme", strCriteria)) Then
               strSQL = "INSERT INTO tblLabProgramme (LabId, ProgrammeId) " & _
                        "VALUES(" & Me.LabId & "," & .ItemData(i) & ")"
               CurrentDb.Execute strSQL, dbFailOnError
            End If
        End If
    Next i
End With

End Sub
