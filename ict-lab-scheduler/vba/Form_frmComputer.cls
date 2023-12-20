VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_frmComputer"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Compare Database
Option Explicit
Dim tmpLab As TempVars
Dim tmpActive As TempVars


Private Sub btnGo_Click()

TempVars!tmpLab = Me.cboLab.Value
TempVars!tmpActive = Me.cboActive.Value

Me.subForm.SourceObject = "Report.rptComputer"

Me.subForm.Requery

ActivityLog ("frmComputer view report")

End Sub

Private Sub btnNewCourse_Click()

DoCmd.OpenForm "frmComputerEntry", , , , acFormAdd
ActivityLog ("frmComputer open frmComputerEntry")

End Sub

Private Sub cboActive_KeyDown(KeyCode As Integer, Shift As Integer)

Select Case KeyCode
    Case vbKeyReturn, vbKeyTab, vbKeyUp, vbKeyDown, vbKeyBack, vbKeyDelete
        KeyCode = KeyCode  'Accept these keys
    Case Else
        KeyCode = 0 'Block all other keys
End Select

End Sub

Private Sub cboLab_KeyDown(KeyCode As Integer, Shift As Integer)

Select Case KeyCode
    Case vbKeyReturn, vbKeyTab, vbKeyUp, vbKeyDown, vbKeyBack, vbKeyDelete
        KeyCode = KeyCode  'Accept these keys
    Case Else
        KeyCode = 0 'Block all other keys
End Select

End Sub

Private Sub cmdSelectSoftware_Click()

DoCmd.OpenForm "frmComputerSoftwareEntry"
ActivityLog ("frmComputer open frmComputerSoftwareEntry")

End Sub

Private Sub Form_Load()

Me.subForm.SourceObject = "Form.frmDefault"

End Sub
