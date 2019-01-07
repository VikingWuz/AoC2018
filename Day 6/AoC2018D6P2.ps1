$coordinates = Get-Content C:\AoC\2018\AoC2018D6.txt

$points = @()
foreach ($coordinate in $coordinates) {
    [int]$x = $coordinate.Split(", ")[0]
    [int]$y = $coordinate.Split(", ")[2]
    $points += [PSCustomObject]@{
        point = $coordinates.IndexOf($coordinate)
        x = $x
        y = $y
    }
}

$left = ($points | Sort-Object x)[0].x
$right = ($points | Sort-Object x)[-1].x
$top= ($points | Sort-Object y)[0].y
$bottom = ($points | Sort-Object y)[-1].y

$maxSumOfDistances = 10000
$regionsize = 0

for ($yCoordinate = $top; $yCoordinate -lt ($bottom + 1); $yCoordinate++) {
    for ($xCoordinate = $left; $xCoordinate -lt ($right + 1); $xCoordinate++) {
        $totalDistance = 0
        foreach ($point in $points) {
            $distance = [math]::abs($yCoordinate - $point.y) + [math]::abs($xCoordinate - $point.x)            
            $totalDistance += $distance
        }
        if ($totaldistance -lt $maxSumOfDistances) {
            $regionsize++
        }
    }
}

$regionsize