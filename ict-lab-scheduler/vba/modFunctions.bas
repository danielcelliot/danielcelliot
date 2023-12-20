Attribute VB_Name = "modFunctions"
Option Compare Database
Option Explicit

Public Function getDaysInMonth(MonthDayYear As Date) As Integer

getDaysInMonth = DateDiff("d", MonthDayYear, DateAdd("m", 1, MonthDayYear))

End Function

Public Function ActivityLog(Activity As String)

CurrentDb.Execute "INSERT INTO tblUserActivityLog (UserId, ActivityType) " & _
                "VALUES(" & intUserId & ",'" & Activity & "')"
                
End Function
