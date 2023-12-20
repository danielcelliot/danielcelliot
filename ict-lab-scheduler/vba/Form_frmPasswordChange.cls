VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_frmPasswordChange"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Compare Database
Option Explicit

Private Sub Form_Load()

Me.txtPassword.SetFocus

End Sub

Private Sub btnConfirm_Click()

With Me
    If .txtPassword = "" Then
        MsgBox "New password cannot be blank.", vbCritical
        .txtPassword.SetFocus
    'Verify new password
    ElseIf .txtPassword = .txtConfPW Then
        MsgBox "Password change successful!", vbOKOnly
        ActivityLog ("password change")
        .PWReset = False
        DoCmd.Close acForm, .Name
    Else
        MsgBox "Passwords don't match. Please re-enter.", vbOKOnly
        .txtPassword.SetFocus
    End If
End With

End Sub

Private Sub btnCancel_Click()

If Me.Dirty Then 'Undo any changes.
    Me.Undo
End If
DoCmd.Close acForm, Me.Name

End Sub
