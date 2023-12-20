VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_frmComputerEntry"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Compare Database
Option Explicit

Private Sub btnCancel_Click()

If Me.Dirty Then 'Undo any changes.
    Me.Undo
End If

DoCmd.Close acForm, Me.Name

End Sub

Private Sub btnConfirm_Click()

If Me.Dirty Then 'Save any changes
        Me.Dirty = False
        ActivityLog ("frmComputerEntry save record")
End If

DoCmd.Close acForm, Me.Name

End Sub

Private Sub btnDelete_Click()

On Error Resume Next
RunCommand acCmdDeleteRecord
ActivityLog ("frmComputerEntry delete record")

DoCmd.Close acForm, Me.Name

End Sub
