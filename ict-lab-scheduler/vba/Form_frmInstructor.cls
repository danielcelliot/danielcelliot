VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_frmInstructor"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Compare Database
Option Explicit
Dim tmpActive As TempVars


Private Sub btnGo_Click()

TempVars!tmpActive = Me.cboActive.Value

Me.subForm.SourceObject = "Report.rptInstructor"

Me.subForm.Requery

End Sub

Private Sub btnNewInstructor_Click()

DoCmd.OpenForm "frmInstructorEntry", , , , acFormAdd

End Sub

Private Sub cmdSelectProgramme_Click()

DoCmd.OpenForm "frmInstructorProgrammeEntry"

End Sub

Private Sub Form_Load()

Me.subForm.SourceObject = "Form.frmDefault"

If Forms!frmLogin!cboUser.Column(4) <> 1 Then
    Me.btnNewInstructor.Enabled = False
    Me.cmdSelectProgramme.Enabled = False
End If

End Sub
