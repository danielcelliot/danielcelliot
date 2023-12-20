VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_frmAddSoftware"
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
        ActivityLog ("frmAddSoftware save")
End If

DoCmd.Close acForm, Me.Name

End Sub
