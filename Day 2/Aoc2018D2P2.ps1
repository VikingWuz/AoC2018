$ids = Get-Content C:\AoC\2018\AoC2018D2.txt
$positionInIDs = 0

:loop while($true) {
    foreach ($id in $ids) {
        for ($i = 0; $i -lt $ids.Count; $i++) {
            if($i -ne $positionInIDs) {
                for ($j = 0; $j -lt $id.Length; $j++) {
                    if ($id[$j] -eq $ids[$i][$j] ) {
                        [string]$result += $id[$j]
                        if ($result.Length -eq $id.Length - 1) {
                            break loop
                        } 
                    }
                }
            }
            [string]$result = ""
        }
        ++$positionInIDs
    }
}

$result