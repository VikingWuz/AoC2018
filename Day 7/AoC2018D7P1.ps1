$instructions = Get-Content C:\AoC\2018\AoC2018D7.txt

[System.Collections.ArrayList]$steps = @()
foreach ($instruction in $instructions) {
    $before = $instruction.Split(" ")[1]
    $after = $instruction.Split(" ")[7]
    $steps += [PSCustomObject]@{   
        before = $before
        after = $after
    }
}

[System.Collections.ArrayList]$stepsDone= @()
$finished = $false

while (! $finished) {
    # search for steps which have no prerequisites and therefore can start immediately
    $nextStepsToMake = @()
    foreach ($step in $steps) {
        if ($step.before -notin $steps.after) { 
            $nextStepsToMake += $step.before
        }
    }

    # order them alphabeticaly, pick the first one and add them to the stepsDone List
    $sortedNextStepsToMake = $nextStepsToMake | Sort-Object
    [void]$stepsDone.Add($sortedNextStepsToMake[0])

    # create temp list to avoid enumeration error, there should be a better way, but at the moment i dont know how to do it else
    [System.Collections.ArrayList]$stepsToIterate = @()
    $stepsToIterate += $steps

    # remove the last step(prerequisites) that was done from the initial list 
    foreach ($step in $stepsToIterate) {
        if ($step.before -in $sortedNextStepsToMake[0]) { 
        $steps.Remove($step)
       }
    }

    # Add last Step to the list!!! and break out of loop
    if ($steps.Count -eq 0) {
        [void]$stepsDone.Add($step.after)
        $finished = $true
    }
}
$stepsDone -join ""