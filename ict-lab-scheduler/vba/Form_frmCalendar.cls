VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_frmCalendar"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Compare Database
Option Explicit

Private dateCurrentMonth As Date
Private intCurrentYear As Integer
Private dateFirstDateOfMonth As Date
Private intFirstWeekday As Integer
Private intLabNumber As Integer
Private intDaysInMonth As Integer
Private arrCalendar() As Variant

Private Sub Form_Load()

With Me
    'Set default values to Lab and Date
    .txtDate = Date
    .cboLab.Value = 107
End With

Call InitVariables

End Sub

Private Sub InitVariables()

dateCurrentMonth = Month(Date)
intCurrentYear = Year(Date)
dateFirstDateOfMonth = DateSerial(intCurrentYear, dateCurrentMonth, 1)
intFirstWeekday = Weekday(dateFirstDateOfMonth, vbMonday)
intDaysInMonth = getDaysInMonth(dateFirstDateOfMonth)
intLabNumber = Me.cboLab

Call Main

End Sub

Private Sub Main()

'Update calendar month and year
With Me
    .txtCalendarMonth = MonthName(dateCurrentMonth)
    .txtCalendarYear = intCurrentYear
End With
'Update date variables
dateFirstDateOfMonth = DateSerial(intCurrentYear, dateCurrentMonth, 1)
intFirstWeekday = Weekday(dateFirstDateOfMonth, vbMonday)

Call AddDaysToArray
Call AddBookingsToArray
Call PrintDaysToCalendar
Call PrintBookingsToCalendar

End Sub

Private Sub AddDaysToArray()

Dim i As Integer

ReDim arrCalendar(0 To 41, 0 To 3)

For i = LBound(arrCalendar) To UBound(arrCalendar)
    'Populate each value in array
    arrCalendar(i, 0) = ((dateFirstDateOfMonth - intFirstWeekday) + 1) + i
    If Month(arrCalendar(i, 0)) = dateCurrentMonth Then 'This day is in the selected month
        arrCalendar(i, 1) = True
        arrCalendar(i, 2) = Day(arrCalendar(i, 0))
    Else
        arrCalendar(i, 1) = False
    End If
    'Debug.Print "myArray" & i & " " & arrCalendar(i, 0) _
                & " " & arrCalendar(i, 1) _
                & " " & arrCalendar(i, 2)
Next i

End Sub

Private Sub AddBookingsToArray()

Dim dbs As DAO.Database
Dim rst As DAO.Recordset
Dim rstFiltered As DAO.Recordset
Dim strSQL As String
Dim i As Integer

'SQL code from qryBooking
strSQL = "SELECT tblSchedule.sDate, tblTime.StartTime, tblTime.EndTime, tblCourse.CourseCode, tblLab.LabId " _
        & "FROM tblTime INNER JOIN (tblSemester INNER JOIN (tblLab INNER JOIN (tblCourse " _
        & "INNER JOIN ((tblAcademicYear INNER JOIN tblSchedule ON tblAcademicYear.YearId = tblSchedule.YearId) " _
        & "INNER JOIN tblSemesterDate ON tblAcademicYear.YearId = tblSemesterDate.YearId) " _
        & "ON tblCourse.CourseId = tblSchedule.CourseId) ON tblLab.LabId = tblSchedule.LabId) " _
        & "ON (tblSemester.SemesterId = tblSemesterDate.SemesterId) AND (tblSemester.SemesterId = tblSchedule.SemesterId)) " _
        & "ON tblTime.TimeId = tblSchedule.TimeId " _
        & "ORDER BY tblSchedule.sDate, tblTime.StartTime;"
        
Set dbs = CurrentDb
Set rst = dbs.OpenRecordset(strSQL)

If Not rst.BOF And Not rst.EOF Then
    For i = LBound(arrCalendar) To UBound(arrCalendar)
        'Populate calendar based on selected date and lab number
        If arrCalendar(i, 1) = True Then
            'Debug.Print arrCalendar(i, 2)
            rst.Filter = "[sDate]= #" & arrCalendar(i, 0) & "#" & " And [LabId]= " & Me.cboLab
            Set rstFiltered = rst.OpenRecordset
            Do While (Not rstFiltered.EOF)
                If Not arrCalendar(i, 3) = Empty Then
                    arrCalendar(i, 3) = arrCalendar(i, 3) & vbNewLine
                End If
                'Add record details to 4th column of array
                arrCalendar(i, 3) = arrCalendar(i, 3) _
                                    & Format(rstFiltered!StartTime, "h:mmAMPM") & " - " _
                                    & Format(rstFiltered!EndTime, "h:mmAMPM") & " " _
                                    & rstFiltered!CourseCode
                rstFiltered.MoveNext
            Loop
            'Debug.Print arrCalendar(i, 3)
        End If
    Next i
End If

'Cleanup
rstFiltered.Close
rst.Close

Set rstFiltered = Nothing
Set rst = Nothing
Set dbs = Nothing

End Sub

Private Sub PrintDaysToCalendar()

Dim strCtlName As String
Dim i As Integer

For i = LBound(arrCalendar) To UBound(arrCalendar)
    strCtlName = "txt" & CStr(i + 1)
    Controls(strCtlName) = ""
    Controls(strCtlName) = arrCalendar(i, 2)
    'Change background color for textbox that displays day in calendar
    If Not Controls(strCtlName) = Empty Then
        Controls(strCtlName).BackColor = RGB(240, 240, 240)
    Else
        Controls(strCtlName).BackColor = RGB(230, 230, 230)
    End If
Next i

End Sub

Private Sub PrintBookingsToCalendar()

Dim strCtlName As String
Dim i As Integer

For i = LBound(arrCalendar) To UBound(arrCalendar)
    strCtlName = "txt" & CStr(i) & "_1"
    Controls(strCtlName) = ""
    Controls(strCtlName).Tag = i
    Controls(strCtlName) = arrCalendar(i, 3)
    
    'Change background color for textbox that displays bookings in calendar
    If Not arrCalendar(i, 2) = Empty Then
        Controls(strCtlName).BackColor = RGB(250, 250, 250)
    Else
        Controls(strCtlName).BackColor = RGB(230, 230, 230)
    End If
    'Change OnClick event for textbox that displays bookings in calendar
    If Not arrCalendar(i, 3) = Empty Then
        Controls(strCtlName).OnClick = "[Event Procedure]"
    Else
        Controls(strCtlName).OnClick = ""
    End If

Next i

End Sub

Private Sub OpenCalendarForm(ctlName As String)

Dim ctlValue As Integer
Dim dateInMonth As Date

ctlValue = Controls(ctlName).Tag
dateInMonth = arrCalendar(ctlValue, 0)

DoCmd.OpenForm "frmBookingEntry", , , "[sDate] =#" & dateInMonth & "# AND [LabId] =" & Me.cboLab, acFormEdit
Forms![frmBookingEntry].AllowAdditions = False
ActivityLog ("frmCalendar open calendar txtbox")

End Sub

Private Sub cmdRefresh_Click()

Call AddDaysToArray
Call AddBookingsToArray
Call PrintDaysToCalendar
Call PrintBookingsToCalendar

End Sub

Private Sub btnNewSchedule_Click()

DoCmd.OpenForm "frmBookingEntry", , , , acFormAdd

End Sub

Private Sub btnGo_Click()

With Me
    If Not IsNumeric(.cboLab) Then
        .txtErrorMsg = "* Please select a lab number"
        Exit Sub
    ElseIf Not IsDate(.txtDate) Then
        .txtErrorMsg = "* Please enter a date in the format: MM/DD/YYYY"
        Exit Sub
    Else
        .txtErrorMsg = ""
        intLabNumber = .cboLab
        dateCurrentMonth = Month(.txtDate)
        intCurrentYear = Year(.txtDate)
    End If
End With

Call Main

End Sub

Private Sub cboLab_AfterUpdate()

With Me
    If Not IsNumeric(.cboLab) Then
        .txtErrorMsg = "* Please select a lab number"
        Exit Sub
    Else
        .txtErrorMsg = ""
        intLabNumber = .cboLab
    End If
End With

Call Main

End Sub

Private Sub cmdNextMonth_Click()

If dateCurrentMonth < 12 Then
    dateCurrentMonth = dateCurrentMonth + 1
ElseIf dateCurrentMonth = 12 Then
    dateCurrentMonth = 1
    intCurrentYear = intCurrentYear + 1
End If

Call Main

End Sub

Private Sub cmdPrevMonth_Click()

If dateCurrentMonth > 1 Then
    dateCurrentMonth = dateCurrentMonth - 1
ElseIf dateCurrentMonth = 1 Then
    dateCurrentMonth = 12
    intCurrentYear = intCurrentYear - 1
End If

Call Main

End Sub

Private Sub cboLab_KeyDown(KeyCode As Integer, Shift As Integer)

Select Case KeyCode
    Case vbKeyReturn, vbKeyTab, vbKeyUp, vbKeyDown
        KeyCode = KeyCode  'Accept these keys
    Case Else
        KeyCode = 0 'Block all other keys
End Select

End Sub

Private Sub txt0_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt1_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt2_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt3_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt4_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt5_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt6_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt7_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt8_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt9_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt10_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt11_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt12_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt13_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt14_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt15_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt16_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt17_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt18_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt19_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt20_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt21_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt22_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt23_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt24_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt25_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt26_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt27_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt28_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt29_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt30_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt31_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt32_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt33_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt34_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt35_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt36_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt37_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt38_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt39_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt40_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

Private Sub txt41_1_Click()

OpenCalendarForm Me.ActiveControl.Name

End Sub

