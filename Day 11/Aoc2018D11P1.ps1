$serialNumber = Get-Content C:\AoC\2018\AoC2018D11.txt

# Initialize grid as a hashtable containing hashtables and calculate the power level of each coordinate - grid[y][x]
$grid = @{}
for ($y = 1; $y -le 300; $y++) {
    for ($x = 1; $x -le 300; $x++) {
        $grid[$y] += @{}
        $rackID = $x + 10
        $powerLevel = $rackID * $y
        $powerLevel = $powerLevel + $serialNumber
        $powerLevel = $powerLevel * $rackID
        $powerLevelString = $powerLevel.ToString()
        
        if ($powerLevelString.Length -lt 3) {
            $powerLevel = 0
        } else {
            [int]$powerLevel = [string]$powerLevelString[-3]
        }
        $powerLevel = $powerLevel - 5

        $grid[$y][$x] = $powerLevel        
    }
}

$highestSum = 0
$topLeftY = 0
$topLeftX = 0

$startY = 1
$startX = 1
do {
    for ($y = 0; $y -lt 3; $y++) {
        for ($x = 0; $x -lt 3; $x++) {
            $currentY = $startY + $y
            $currentX = $startx + $x
            $squareSum += $grid[$currentY][$currentX]    
        }        
    }
    if ($squareSum -gt $highestSum) {    
        $highestSum = $squareSum
        $topLeftY = $startY
        $topLeftX =  $startX     
        Write-Host "New square found - Coordinate x: $startX y: $startY sum: $squareSum"      
    }
    $squareSum = 0
    $startY += 1
    if ($startY -ge 297) {
        $startY = 1
        $startX += 1
    }

} while ($startX -le 297)

Write-Host "Topleft coordinates are $topLeftX,$topLeftY"


