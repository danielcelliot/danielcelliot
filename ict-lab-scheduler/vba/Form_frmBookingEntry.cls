VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_frmBookingEntry"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Compare Database
Option Explicit

Private Sub Form_Load()

Me.chkRepeat = False

End Sub

Private Sub cboLab_Change()

cboTime.Requery

End Sub

Private Sub cboLab_LostFocus()

cboTime.Requery

End Sub

Private Sub txtDate_Change()

cboTime.Requery

End Sub

Private Sub txtDate_LostFocus()

cboTime.Requery

End Sub

Private Sub btnDelete_Click()

On Error Resume Next
RunCommand acCmdDeleteRecord
ActivityLog ("frmBookingEntry delete record")

DoCmd.Close acForm, Me.Name

End Sub

Private Sub btnCancel_Click()

If Me.Dirty Then 'Undo any changes.
    Me.Undo
End If

DoCmd.Close acForm, Me.Name

End Sub

Private Sub btnConfirm_Click()

If Me.chkRepeat = True Then
    Call AddRepeatRecordsToTable
Else
    If Me.Dirty Then 'Save any changes
        Me.Dirty = False
        ActivityLog ("frmBookingEntry save record")
    End If
End If

DoCmd.Close acForm, Me.Name

End Sub

Private Sub AddRepeatRecordsToTable()

Dim dbs As Database
Dim rst As Recordset
Dim dateEntered As Date
Dim dateSemesterEndDate As Date
Dim intWeekday As Integer

dateEntered = Me.txtDate
'Assign day of month (eg. Wednesday) to a variable
intWeekday = Weekday(dateEntered, vbMonday)
dateSemesterEndDate = DLookup("[EndDate]", "tblSemesterDate", "[SemesterId] =" _
                        & Me.cboSemester & " AND [YearId]=" & Me.cboYear)

Set dbs = CurrentDb
Set rst = dbs.OpenRecordset("tblSchedule")

Do While (dateEntered <= dateSemesterEndDate)

    If intWeekday = Weekday(dateEntered, vbMonday) Then
        'Check if record already exists
        If DCount("*", "[tblSchedule]", "[sDate] = #" & dateEntered & "#" _
            & " AND [TimeId] = " & Me.cboTime & " AND [LabId] = " & Me.cboLab) > 0 Then 'Skip this record
            
            MsgBox "A record for lab " & Me.cboLab & " at selected time, on " _
            & dateEntered & " already exists. Skipping Entry...", vbOKOnly + vbExclamation, "Duplicate Record"
        Else
            'Add new record to database
            With rst
                .AddNew
                .Fields("sDate") = dateEntered
                .Fields("TimeId") = Me.cboTime
                .Fields("SemesterId") = Me.cboSemester
                .Fields("InstructorId") = Me.cboInstructor
                .Fields("CourseId") = Me.cboCourse
                .Fields("YearId") = Me.cboYear
                .Fields("LabId") = Me.cboLab
                .Update
            End With
            ActivityLog ("frmBookingEntry AddRepeatRecords save")
        End If
        
        'Debug.Print "xxx"
    End If
    
    'Debug.Print "Date: " & dateEntered & ", Weekday: " & Weekday(dateEntered, vbMonday)
    dateEntered = DateAdd("d", 1, dateEntered)
Loop

'Cleanup
rst.Close

Set rst = Nothing
Set dbs = Nothing

End Sub

Private Sub cboCourse_KeyDown(KeyCode As Integer, Shift As Integer)

Select Case KeyCode
    Case vbKeyReturn, vbKeyTab, vbKeyUp, vbKeyDown
        KeyCode = KeyCode  'Accept these keys
    Case Else
        KeyCode = 0 'Block all other keys
End Select

End Sub

Private Sub cboInstructor_KeyDown(KeyCode As Integer, Shift As Integer)

Select Case KeyCode
    Case vbKeyReturn, vbKeyTab, vbKeyUp, vbKeyDown
        KeyCode = KeyCode  'Accept these keys
    Case Else
        KeyCode = 0 'Block all other keys
End Select

End Sub

Private Sub cboSemester_KeyDown(KeyCode As Integer, Shift As Integer)

Select Case KeyCode
    Case vbKeyReturn, vbKeyTab, vbKeyUp, vbKeyDown
        KeyCode = KeyCode  'Accept these keys
    Case Else
        KeyCode = 0 'Block all other keys
End Select

End Sub

Private Sub cboTime_KeyDown(KeyCode As Integer, Shift As Integer)

Select Case KeyCode
    Case vbKeyReturn, vbKeyTab, vbKeyUp, vbKeyDown
        KeyCode = KeyCode  'Accept these keys
    Case Else
        KeyCode = 0 'Block all other keys
End Select

End Sub

Private Sub cboYear_KeyDown(KeyCode As Integer, Shift As Integer)

Select Case KeyCode
    Case vbKeyReturn, vbKeyTab, vbKeyUp, vbKeyDown
        KeyCode = KeyCode  'Accept these keys
    Case Else
        KeyCode = 0 'Block all other keys
End Select

End Sub
