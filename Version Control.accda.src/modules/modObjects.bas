'---------------------------------------------------------------------------------------
' Module    : modObjects
' Author    : Adam Waller
' Date      : 12/4/2020
' Purpose   : Wrapper functions for classes and other objects available globally.
'---------------------------------------------------------------------------------------
Option Compare Database
Option Private Module
Option Explicit


' Logging and options classes
Private m_Perf As clsPerformance
Private m_Log As clsLog
Private m_Options As clsOptions
Private m_VCSIndex As clsVCSIndex

' Keep a persistent reference to file system object after initializing version control.
' This way we don't have to recreate this object dozens of times while using VCS.
Private m_FSO As FileSystemObject


'---------------------------------------------------------------------------------------
' Procedure : LoadOptions
' Author    : Adam Waller
' Date      : 4/15/2020
' Purpose   : Loads the current options from defaults and this project.
'---------------------------------------------------------------------------------------
'
Public Function LoadOptions() As clsOptions
    Dim Options As clsOptions
    Set Options = New clsOptions
    Options.LoadProjectOptions
    Set LoadOptions = Options
End Function


'---------------------------------------------------------------------------------------
' Procedure : Options
' Author    : Adam Waller
' Date      : 5/2/2020
' Purpose   : A global property to access options from anywhere in code.
'           : (Avoiding a global state is better OO programming, but this approach keeps
'           :  the coding simpler when you don't have to tie everything back to the
'           :  primary object.) I.e. You can just use `Encrypt("text")` instead of
'           :  having to use `Options.Encrypt("text")`
'           : To clear the current set of options, simply set the property to nothing.
'---------------------------------------------------------------------------------------
'
Public Property Get Options() As clsOptions
    If m_Options Is Nothing Then Set m_Options = LoadOptions
    Set Options = m_Options
End Property
Public Property Set Options(cNewOptions As clsOptions)
    Set m_Options = cNewOptions
End Property


'---------------------------------------------------------------------------------------
' Procedure : Perf
' Author    : Adam Waller
' Date      : 11/3/2020
' Purpose   : Wrapper for performance logging class
'---------------------------------------------------------------------------------------
'
Public Function Perf() As clsPerformance
    If m_Perf Is Nothing Then Set m_Perf = New clsPerformance
    Set Perf = m_Perf
End Function


'---------------------------------------------------------------------------------------
' Procedure : Log
' Author    : Adam Waller
' Date      : 4/28/2020
' Purpose   : Wrapper for log file class
'---------------------------------------------------------------------------------------
'
Public Function Log() As clsLog
    If m_Log Is Nothing Then Set m_Log = New clsLog
    Set Log = m_Log
End Function


'---------------------------------------------------------------------------------------
' Procedure : FSO
' Author    : Adam Waller
' Date      : 1/18/2019
' Purpose   : Wrapper for file system object. A property allows us to clear the object
'           : reference when we have completed an export or import operation.
'---------------------------------------------------------------------------------------
'
Public Property Get FSO() As FileSystemObject
    If m_FSO Is Nothing Then Set m_FSO = New FileSystemObject
    Set FSO = m_FSO
End Property
Public Property Set FSO(ByVal RHS As FileSystemObject)
    Set m_FSO = RHS
End Property


'---------------------------------------------------------------------------------------
' Procedure : VSCIndex
' Author    : Adam Waller
' Date      : 12/1/2020
' Purpose   : Reference to the VCS Index class (saved state from vcs-index.json)
'---------------------------------------------------------------------------------------
'
Public Property Get VCSIndex() As clsVCSIndex
    If m_VCSIndex Is Nothing Then
        Set m_VCSIndex = New clsVCSIndex
        m_VCSIndex.LoadFromFile
    End If
    Set VCSIndex = m_VCSIndex
End Property
Public Property Set VCSIndex(cIndex As clsVCSIndex)
    Set m_VCSIndex = cIndex
End Property