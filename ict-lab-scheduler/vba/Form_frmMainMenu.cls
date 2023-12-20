VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_frmMainMenu"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Compare Database
Option Explicit

Private Sub Form_Load()

If Forms!frmLogin!cboUser.Column(4) <> 1 Then
    Me.navBtnUser.Enabled = False
End If

Me.TimerInterval = 60000 '(1 minute/60 secs)

'Displays current user in Main Menu
txtUserName.Value = pstrUserName

End Sub

Private Sub Form_Timer()

With Me
    'Update date and time every 60 seconds
    .txtCurrentDate.ControlSource = "=Date()"
    .txtCurrentTime.ControlSource = "=Time()"
End With

End Sub

Private Sub imgUserIcon_Click()

'Log off user
DoCmd.Close acForm, Me.Name, acSaveNo
DoCmd.Close acForm, "frmLogin", acSaveNo
ActivityLog ("log off")

End Sub

