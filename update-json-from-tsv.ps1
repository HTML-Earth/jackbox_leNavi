$jsonPath = $args[0]
$tsvPath = $args[1]

$jsonContent = Get-Content $jsonPath -Raw | ConvertFrom-Json
$tsvContent = Import-Csv $tsvPath -Delimiter '	'

foreach ($row in $tsvContent)
{
    if ($row."na'vi" -ne "")
    {
        $matchingId = $jsonContent.content | Where-Object { $_.id -eq $row.id }
        $matchingId.suggestion = $row."na'vi"

        Write-Output "Replaced $($row.id) (Na'vi)"
    }
    else
    {
        $matchingId = $jsonContent.content | Where-Object { $_.id -eq $row.id }
        $matchingId.suggestion = "[!] $($row.english)"

        Write-Output "Replaced $($row.id) (Prefixed English)"
    }
}

$jsonContent | ConvertTo-Json -Depth 4 | Out-File $jsonPath -Encoding utf8NoBOM