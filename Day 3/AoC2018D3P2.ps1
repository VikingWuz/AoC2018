$claims= Get-Content C:\AoC\2018\AoC2018D3.txt

$timer = New-Object System.Diagnostics.Stopwatch
$timer.Start()

$coordinateSystem = @{}
$searchedID = 0
$found = $false

foreach ($claim in $claims) {
    $instructions = $claim.Split(" ")
    
    $postions = $instructions[2].trim(':').split(',')
    [int]$posx = $postions[0]
    [int]$posy = $postions[1]

    $rectangle = $instructions[3].Split("x")
    [int]$width = $rectangle[0]
    [int]$height = $rectangle[1]

    for ($i = $posx; $i -lt ($posx +$width); $i++) {
        for ($j = $posy; $j -lt ($posy + $height); $j++) {
            ++$coordinateSystem["$i,$j"]
        }
    } 
}

:iteration foreach($claim in $claims) {
    $instructions = $claim.Split(" ")
    $id = $instructions[0].Trim("#")
        
    $postions = $instructions[2].trim(':').split(',')
    [int]$posx = $postions[0]
    [int]$posy = $postions[1]
    
    $rectangle = $instructions[3].Split("x")
    [int]$width = $rectangle[0]
    [int]$height = $rectangle[1]        
    
    for ($i = $posx; $i -lt ($posx +$width); $i++) {
        for ($j = $posy; $j -lt ($posy + $height); $j++) {
            if($coordinateSystem["$i,$j"] -eq 1) {
                $found = $true
            } else {
                $found = $false
                continue iteration
            }
        }
    }
    if ($found -eq $true) {
        $searchedID = $id
    }
}

$searchedID

$timer.Stop()
Write-Host $timer.Elapsed
