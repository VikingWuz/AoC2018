##
#
# Extremly slow bruteforce method, should be done with summed areas
#
##

$serialNumber = Get-Content C:\AoC\2018\AoC2018D11.txt
$squareSizes = 2..300
$gridlLenght = 300 

# Initialize grid as a hashtable containing hashtable and calculate the power level of each coordinate - grid[y][x]
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
$squareSizeLargestPower = 0

$startY = 1
$startX = 1
foreach ($squareSize in $squareSizes) {
    do {
        for ($y = 0; $y -lt $squareSize; $y++) {
            for ($x = 0; $x -lt $squareSize; $x++) {
                $currentY = $startY + $y
                $currentX = $startx + $x
                $squareSum += $grid[$currentY][$currentX]        
            }        
        }
        if ($squareSum -gt $highestSum) {
            $highestSum = $squareSum
            $topLeftY = $startY
            $topLeftX =  $startX  
            $squareSizeLargestPower = $squareSize          
            Write-Host "New square found - Coordinate x: $startX y: $startY sum: $squareSum squaresize: $squareSizeLargestPower"   
        }
        $squareSum = 0
        $startY += 1
        if ($startY -ge ($gridlLenght - $squareSize)) {
            $startY = 1
            $startX += 1
        }
    
    } while ($startX -le ($gridlLenght - $squareSize))
    $startY = 1
    $startX = 1
}
    
Write-Host "Topleft coordinates are $topLeftX,$topLeftY squaresize is $squareSizeLargestPower"
    