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

$workers = @()
for ($i = 0; $i -lt 5; $i++) {
    $workers += [PSCustomObject]@{
        id = $i
        taskTimeLeft = 0
        task = "no task at the moment"
    }
}

[System.Collections.ArrayList]$stepsActive = @()
[System.Collections.ArrayList]$workersActiveWorking = @()
$finished = $false
$baseTimeToComplete = 60
$timePassed = 0

while (! $finished) {
    # search for steps which have no prerequisites and therefore can start immediately
    $availableSteps = @()
    foreach ($step in $steps) {
        if (($step.before -notin $steps.after) -and ($step.before -notin $stepsActive)) { 
            $availableSteps += $step.before
        }
    }
    # order them alphabeticaly, select uniques
    $sortedAvailableSteps = $availableSteps | Sort-Object | Select-Object -Unique

    # select workers which currently have no task assigned
    $availableWorkers = @()
    foreach ($worker in $workers) {
        if ($worker.task -eq "no task at the moment") {
            $availableWorkers += $worker
        }
    }

    # calculate how many steps can be actively worked on by taken the smallest of available steps and available workers
    $numOfAvailableSteps = $sortedAvailableSteps.Count
    $numOfAvailableWorkers = $availableWorkers.count
    $numOfWorkThatCanBeDone = 0
    if ($numOfAvailableSteps -lt $numOfAvailableWorkers) {
        $numOfWorkThatCanBeDone = $numOfAvailableSteps
    } else {
        $numOfWorkThatCanBeDone = $numOfAvailableWorkers
    }

    # assign workers to a step
    for ($i = 0; $i -lt $numOfWorkThatCanBeDone; $i++) {
        $workersActiveWorking += $availableWorkers[$i]
        $workersActiveWorking[-1].task = $sortedAvailableSteps[$i]
        $workersActiveWorking[-1].taskTimeLeft = $baseTimeToComplete + ([int][char]$sortedAvailableSteps[$i] - 64)
        [void]$stepsActive.Add($sortedAvailableSteps[$i])
        Write-Host "Assigned worker $($workersActiveWorking[-1].id) task $($sortedAvailableSteps[$i])"
    }
    
    # check if TODO
    [System.Collections.ArrayList]$workersToIterate = @()
    $workersToIterate += $workersActiveWorking
    foreach ($workerActiveWorking in $workersToIterate) {        
        $workerActiveWorking.taskTimeLeft = $workerActiveWorking.taskTimeLeft - 1
        if ($workerActiveWorking.taskTimeLeft -eq 0) {
            # create temp list to avoid enumeration error, there should be a better way, but at the moment i dont know how to do it else
            [System.Collections.ArrayList]$stepsToIterate = @()
            $stepsToIterate += $steps

            # remove the last step(prerequisites) that was done from the initial list 
            # TODO
            foreach ($step in $stepsToIterate) {
                if ($step.before -in $workerActiveWorking.task) { 
                    [void]$steps.Remove($step)
                }
            }
            Write-Host "Worker $($workerActiveWorking.id) finished task $($workerActiveWorking.task)"
            $workers | Where-Object {$_.task -eq $workerActiveWorking.task} | ForEach-Object {$_.task = "no task at the moment"; $_.taskTimeLeft = -1}             
            [void]$workersActiveWorking.Remove($workerActiveWorking)
        }
    }    

    $timePassed++

    # Add last Step to the $timePassed and break out of loop
    if ($steps.Count -eq 1) {
        $a = ([int][char]$steps[0].before - 64 + $baseTimeToComplete)
        $b = ([int][char]$steps[0].after - 64 + $baseTimeToComplete)
        $timePassed += $a
        $timePassed += $b
        $finished = $true
    }
}

$timePassed