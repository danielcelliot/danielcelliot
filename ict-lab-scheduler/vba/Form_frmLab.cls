VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_frmLab"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Compare Database
Option Explicit
Dim tmpCapacity As TempVars
Dim tmpProjector As TempVars

Private Sub btnGo_Click()

TempVars!tmpCapacity = Me.txtCapacity.Value
TempVars!tmpProjector = Me.cboProjector.Value

Me.subForm.SourceObject = "Report.rptLab"

Me.subForm.Requery

End Sub

Private Sub btnNewLab_Click()

DoCmd.OpenForm "frmLabEntry", , , , acFormAdd

End Sub

Private Sub cboProjector_KeyDown(KeyCode As Integer, Shift As Integer)

Select Case KeyCode
    Case vbKeyReturn, vbKeyTab, vbKeyUp, vbKeyDown, vbKeyBack, vbKeyDelete
        KeyCode = KeyCode  'Accept these keys
    Case Else
        KeyCode = 0 'Block all other keys
End Select

End Sub

Private Sub cmdSelectProgramme_Click()

DoCmd.OpenForm "frmLabProgrammeEntry"

End Sub

Private Sub Form_Load()

Me.subForm.SourceObject = "Form.frmDefault"

If Forms!frmLogin!cboUser.Column(4) <> 1 Then
    Me.btnNewLab.Enabled = False
    Me.cmdSelectProgramme.Enabled = False
End If

End Sub
