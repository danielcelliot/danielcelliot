VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_frmBooking"
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

Me.subForm.SourceObject = "Report.rptBooking"
'Forms!frmBooking![subForm].SourceObject = "Report.rptBooking"

Me.subForm.Requery

End Sub

Private Sub btnNewCourse_Click()

DoCmd.OpenForm "frmBookingEntry", , , , acFormAdd
ActivityLog ("frmBookingEntry open")

End Sub

Private Sub Form_Load()

Me.subForm.SourceObject = "Form.frmDefault"

End Sub

