VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Report_rptCourse"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Compare Database
Option Explicit

Private Sub CourseName_Click()

DoCmd.OpenForm "frmCourseEntry", , , "CourseId = " & Me.CourseId
Forms![frmCourseEntry].AllowAdditions = False

End Sub

