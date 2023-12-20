VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_frmInstructorEntry"
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
End If

DoCmd.Close acForm, Me.Name

End Sub

Private Sub btnDelete_Click()

On Error Resume Next
RunCommand acCmdDeleteRecord

DoCmd.Close acForm, Me.Name

End Sub

Private Sub Form_Load()

If Forms!frmLogin!cboUser.Column(4) = 2 Then
   Me.AllowEdits = False
   Me.AllowAdditions = False
   Me.AllowDeletions = False
Else
   Me.AllowEdits = True
   Me.AllowAdditions = True
   Me.AllowDeletions = True
End If

End Sub
