VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_frmLogin"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Compare Database
Option Explicit

Private Sub btnLogin_Click()

'Check that User is selected
If IsNull(Me.cboUser) Then
    MsgBox "Please select a user.", vbCritical
    Me.cboUser.SetFocus
'Check that password is not empty
ElseIf IsNull(Me.txtPassword) Then
    MsgBox "Please enter a password.", vbCritical
    Me.txtPassword.SetFocus
Else
   'Check for correct password
    If Me.txtPassword = Me.cboUser.Column(2) Then
        'Check if password needs to be reset
        If Me.cboUser.Column(3) = True Then
            DoCmd.OpenForm "frmPasswordChange", , , "[UserID] = " & Me.cboUser
        End If
        'Store username and ID to variable
        pstrUserName = Me.cboUser.Column(1)
        intUserId = Me.cboUser.Column(0)
        
        DoCmd.OpenForm "frmMainMenu"
        ActivityLog ("login")
        
        'Hide login form
        Me.Visible = False
    Else
        MsgBox "Incorrect password. Please re-enter."
        Me.txtPassword = Null
        Me.txtPassword.SetFocus
    End If
End If

End Sub

Private Sub btnQuit_Click()

'Quits MS Access Application
DoCmd.Quit acSaveNo

End Sub

Private Sub Form_Close()

    ' restore database window/navigation pane
    DoCmd.SelectObject acForm, Me.Name, True
    DoCmd.Restore
    
End Sub

Private Sub Form_Open(Cancel As Integer)

    ' minimize database window/navigation pane
    DoCmd.SelectObject acForm, Me.Name, True
    DoCmd.Minimize

End Sub

