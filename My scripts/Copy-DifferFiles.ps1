$PathHHSWeb_Stage1 = 'D:\HHSWeb\HHSWeb_STAGE1\'
$PathHHSWeb_TFS = 'D:\HHSWeb\HHSWeb_TFS\'

$HHSWeb_Stage1 = gci -Recurse -Path $PathHHSWeb_Stage1 -Exclude *.cs, *.bak -File | foreach {
    $_.FullName.Substring($PathHHSWeb_Stage1.Length)    
}
$HHSWeb_TFS = gci -Recurse -Path $PathHHSWeb_TFS -File | foreach {
    $_.FullName.Substring($PathHHSWeb_TFS.Length)
}


$sourcepath = Compare-Object -ReferenceObject $HHSWeb_Stage1 -DifferenceObject $HHSWeb_TFS | Where-Object -Property SideIndicator -eq '<=' | foreach {
    Join-Path -Path D:\HHSWeb\HHSWeb_STAGE1 -ChildPath $_.InputObject
}

$destinationPath = Compare-Object -ReferenceObject $HHSWeb_Stage1 -DifferenceObject $HHSWeb_TFS | Where-Object -Property SideIndicator -eq '<=' | foreach {
    Join-Path -Path D:\HHSWeb\differ -ChildPath $_.InputObject
}

gci $PathHHSWeb_Stage1 -Exclude *.cs, *.bak -File -Recurse | foreach {
    if ($_.FullName -in $sourcepath)
    {
       New-Item -Path $destinationPath -Force
    }
}