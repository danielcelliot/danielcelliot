VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Report_rptBooking"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Compare Database
Option Explicit

Private Sub sDate_Click()

DoCmd.OpenForm "frmBookingEntry", , , "sDate = #" & Me.sDate & "# AND InstructorId =" & Me.InstructorId
Forms![frmBookingEntry].AllowAdditions = False

End Sub
