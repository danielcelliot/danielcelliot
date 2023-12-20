VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_frmComputerSoftwareEntry"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Compare Database
Option Explicit

Private Sub btnAddSoftware_Click()

DoCmd.OpenForm "frmAddSoftware", , , , acFormAdd
Me.lstSoftware.Requery
' call form's Current event procedure to update list box
Form_Current
ActivityLog ("frmComputerSoftwareEntry open frmAddSoftware")

End Sub

Private Sub btnClose_Click()

DoCmd.Close acForm, Me.Name

End Sub

Private Sub cboComputer_AfterUpdate()

' find matching row in form's recordset's clone
' and synchronize bookmarks if found
With Me.RecordsetClone
    .FindFirst "ComputerId = " & Nz(Me.cboComputer, 0)
    If Not .NoMatch Then
        Me.Bookmark = .Bookmark
    End If
End With

End Sub

Private Sub cboLab_Change()

cboComputer.Requery
Me.cboComputer = Me.cboComputer.ItemData(0)
Call cboComputer_AfterUpdate

End Sub

Private Sub cboLab_LostFocus()

cboComputer.Requery
Me.cboComputer = Me.cboComputer.ItemData(0)
Call cboComputer_AfterUpdate

End Sub

Private Sub Form_Current()

Dim varItem As Variant
Dim strCriteria As String
Dim i As Integer

' synchronize go to computer combo box
' with current record
Me.cboComputer = Me.ComputerId

With Me.lstSoftware
    ' deselect all items in list box
    For i = .ListCount - 1 To 0 Step -1
        .Selected(i) = False
    Next i
    .Requery
    ' loop through list box items and select items where computer assigned to software
    For i = .ListCount - 1 To 0 Step -1
        strCriteria = "ComputerId = " & Nz(Me.ComputerId, 0) & " And SoftwareId = " & .ItemData(i)
        .Selected(i) = Not IsNull(DLookup("ComputerId", "tblComputerSoftware", strCriteria))
    Next i
End With
      
End Sub

Private Sub lstSoftware_AfterUpdate()

Dim i As Integer
Dim strCriteria As String
Dim strSQL As String

With Me.lstSoftware
    For i = .ListCount - 1 To 0 Step -1
        strCriteria = "ComputerId = " & Nz(Me.ComputerId, 0) & " And SoftwareId = " & .ItemData(i)
        If .Selected(i) = False Then
            ' if item has been deselected then delete row from table
            If Not IsNull(DLookup("ComputerId", "tblComputerSoftware", strCriteria)) Then
               strSQL = "DELETE * FROM tblComputerSoftware WHERE " & strCriteria
               CurrentDb.Execute strSQL, dbFailOnError
               
               ActivityLog ("Delete software in record from list")

            End If
        Else
            ' if item has been selected then insert row into table
             If IsNull(DLookup("ComputerId", "tblComputerSoftware", strCriteria)) Then
               strSQL = "INSERT INTO tblComputerSoftware (ComputerId, SoftwareId) " & _
                        "VALUES(" & Me.ComputerId & "," & .ItemData(i) & ")"
               CurrentDb.Execute strSQL, dbFailOnError
               
               ActivityLog ("Add software in record from list")
            End If
        End If
    Next i
End With

End Sub
