VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_frmCourse"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Compare Database
Option Explicit
Dim tmpYear As TempVars
Dim tmpSemester As TempVars


Private Sub btnGo_Click()

TempVars!tmpYear = Me.cboYear.Value
TempVars!tmpSemester = Me.cboSemester.Value

Me.subForm.SourceObject = "Report.rptCourse"

Me.subForm.Requery

End Sub

Private Sub btnNewCourse_Click()

DoCmd.OpenForm "frmCourseEntry", , , , acFormAdd

End Sub

Private Sub Form_Load()

Me.subForm.SourceObject = "Form.frmDefault"

If Forms!frmLogin!cboUser.Column(4) <> 1 Then
    Me.btnNewCourse.Enabled = False
End If

End Sub
