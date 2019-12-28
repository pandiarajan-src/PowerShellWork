$SourceFolder="C:\workspace\Debug"
$DestFolder="C:\Program Files\SampleApp"

Write-Host $SourceFolder to $DestFolder

Copy-Item -Path $SourceFolder\* -Destination $DestFolder -Include *.dll,*.exe,*.pdb

