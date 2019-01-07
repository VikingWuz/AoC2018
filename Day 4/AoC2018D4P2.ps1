$records = Get-Content C:\AoC\2018\AoC2018D4.txt

$timer = New-Object System.Diagnostics.Stopwatch
$timer.Start()

$sortedRecords = $records | Sort-Object

$allGuards = @{}
foreach ($sortedRecord in $sortedRecords) {
    $possibilities = $sortedRecord.Replace('[', '').Replace(']', '').Replace(':', ' ').Replace('#', '').Split(' ')
    if ($possibilities[3] -eq "Guard") {        
        [int]$guardID = $possibilities[4]
        $allGuards[$guardID] = $guardRecord = @{}
    }
}



foreach ($sortedRecord in $sortedRecords) {
    $possibilities = $sortedRecord.Replace('[', '').Replace(']', '').Replace(':', ' ').Replace('#', '').Split(' ')
    $awake = $false
    
    # There are 3 possible states
    # 1: Guard ID
    # 2: Falls asleep
    # 3: Wakes up

    if ($possibilities[3] -eq "Guard") {
        # $guardID = 2707 for first $sortedrecord
        [int]$guardID = $possibilities[4]
    } elseif ($possibilities[3] -eq "falls") {
        # $fallsAsleep = 26 for first $sortedrecord
        [int]$fallsAsleep = $possibilities[2]
    } else {
        # $wakesUp = 55 for first $sortedrecord
        $awake = $true
        [int]$wakesUp = $possibilities[2]
    }
    if ($fallsAsleep -ne $null -and $wakesUp -ne $null -and $awake -eq $true) {
        for ($i = $fallsAsleep; $i -lt  $wakesUp ; $i++) {
            $allGuards[$guardID][$i]++
        }
    }        
    
}
$mostMinutesAsleep = 0
$guardIDmostAsleep = 0

foreach($guards in $allGuards.keys) {
    $max = ($allGuards[$guards].Values | Measure-Object -Maximum).Maximum
    if ($max -gt $mostMinutesAsleep) {
        $mostMinutesAsleep = $max
        $guardIDmostAsleep = $guards
    }
}

Foreach ($Key in ($allGuards[$guardIDmostAsleep].GetEnumerator() | Where-Object {$_.Value -eq $mostMinutesAsleep})){
    $excatMinute =$Key.name
}


$result = $guardIDmostAsleep * $excatMinute
$result

$timer.Stop()
Write-Host $timer.Elapsed