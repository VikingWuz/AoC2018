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
$maxDistance =  ($right - $left) + ($bottom - $top)

$coordinateSystem = @{}

for ($yCoordinate = $top; $yCoordinate -lt ($bottom + 1); $yCoordinate++) {
    for ($xCoordinate = $left; $xCoordinate -lt ($right + 1); $xCoordinate++) {
        $currentDistance = $maxDistance
        $clostestpoint = "noClosetpointfoundYet"
        foreach ($point in $points) {
            $coordinateSystem[$xCoordinate] += @{}
            $coordinateSystem[$xCoordinate][$yCoordinate] += $clostestpoint
            $distance = [math]::abs($yCoordinate - $point.y) + [math]::abs($xCoordinate - $point.x)            
            
            if ($distance -lt $currentDistance) {
                $currentDistance = $distance
                $clostestpoint = $point.point
            } elseif ($distance -eq $currentDistance) {                
                $clostestpoint = "Equaly close to 2 or more"
            }
            $coordinateSystem[$xCoordinate][$yCoordinate] = $clostestpoint
        }
    }
}

$infinitPoints = $coordinateSystem[$left].values
$infinitPoints += $coordinateSystem[$right].values
for ($xCoordinate = $left; $xCoordinate -lt ($right + 1); $xCoordinate++) {
    $infinitPoints += $coordinateSystem[$xCoordinate][$top]
    $infinitPoints += $coordinateSystem[$xCoordinate][$bottom]
}

$infinitPoints = $infinitPoints | Select-Object -Unique

$a = $coordinateSystem.values.values | Where-Object {$_ -notin $infinitPoints} 
$b = $a | Group-Object 
$c = $b | Sort-Object count | Select-Object -Last 1
$c.count
