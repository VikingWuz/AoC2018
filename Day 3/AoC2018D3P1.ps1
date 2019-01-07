$claims= Get-Content C:\AoC\2018\AoC2018D3.txt
$coordinateSystem = @{}
for ($i = 0; $i -lt 1000; $i++) {
    for ($j = 0; $j -lt 1000; $j++) {
        $coordinateSystem["$i,$j"] = 0
    }
}
$totalSquareFeet = 0

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
            $coordinateSystem["$i,$j"]++
        }
    }
}

foreach ($value in $coordinateSystem.values) {
    if($value -gt 1) {
        $totalSquareFeet++
    }
}

$totalSquareFeet