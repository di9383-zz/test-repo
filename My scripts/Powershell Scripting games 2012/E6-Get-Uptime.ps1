# -------------------------------------------------------------------------------------
# Script: E6-Get-Uptime.ps1
# Author: dzianis sinevich
# Date: Thursday, March 30, 2017 15:51:24
# Keywords: Scripting Techniques, Dates and times, Operating System,
# basic information, Beginner, Scripting Games
# -------------------------------------------------------------------------------------

$WMIOS = Get-WmiObject -Class Win32_OperatingSystem 

$TimeSpan = New-TimeSpan $WMIOS.ConvertToDateTime($WMIOS.LastBootUpTime) (get-date)

Write-Output ("The computer {0} has been up for {1} days {2} hours {3} minutes, {4} seconds as of {5}" -f $WMIOS.__SERVER, $TimeSpan.Days, $TimeSpan.Hours, $TimeSpan.Minutes, $TimeSpan.Seconds, (get-date))
