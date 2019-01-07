##
#
# Basicaly the same as part 1, just added a counter timepassed an in/decresed it for every loop
#
##

$positionsAndVelocities = Get-Content C:\AoC\2018\AoC2018D10.txt

# create a points array which contain point objects
$points = @()
foreach ($positionAndVelocitiy in $positionsAndVelocities) {
    $parsedPositionAndVelocitiy = $positionAndVelocitiy.Split("=<").Split(">").Split(",").Trim(" ")
    [int]$x = $parsedPositionAndVelocitiy[2]
    [int]$y = $parsedPositionAndVelocitiy[3]
    [int]$velocityX = $parsedPositionAndVelocitiy[6]
    [int]$velocityY = $parsedPositionAndVelocitiy[7]
    
    $points += [PSCustomObject]@{
        point = $positionsAndVelocities.IndexOf($positionAndVelocitiy)
        x = $x
        y = $y
        velocityX = $velocityX
        velocityy = $velocityY
    }
}

# calculate the lenght of y and y coordinates by calculating the max lenght between the 2 fartest x and y points(would be better to write as a functions so that it can be reused, but im too lazy)
$maxMinX = $points.x | Measure-Object -Maximum -Minimum
$maxMinY = $points.y | Measure-Object -Maximum -Minimum
$maxX = $maxMinX.Maximum
$minX = $maxMinX.Minimum
$maxY = $maxMinY.Maximum
$minY = $maxMinY.Minimum
[int]$xLength = ($maxX - $minX)
[int]$yLength = ($maxY - $minY)

$timepassed = 0
$multiplicator = 100

# simulate 100 steps(would be better to write as a functions so that it can be reused, but im too lazy)
do {
    $tempXLength = $xLength
    $tempYLength = $yLength

    foreach ($point in $points) {
        $point.x = $point.x + $point.velocityX * $multiplicator
        $point.y = $point.y + $point.velocityy * $multiplicator
    }
    
    $maxMinX = $points.x | Measure-Object -Maximum -Minimum
    $maxMinY = $points.y | Measure-Object -Maximum -Minimum
    $maxX = $maxMinX.Maximum
    $minX = $maxMinX.Minimum
    $maxY = $maxMinY.Maximum
    $minY = $maxMinY.Minimum
    [int]$xLength = ($maxX - $minX)
    [int]$yLength = ($maxY - $minY)

    $timepassed = $timepassed + $multiplicator

} while ($tempXLength -gt $xLength -and $tempYLength -gt $yLength)

# go back 100 steps
foreach ($point in $points) {
    $point.x = $point.x - $point.velocityX * $multiplicator
    $point.y = $point.y - $point.velocityy * $multiplicator
}
$timepassed =  $timepassed - $multiplicator

$maxMinX = $points.x | Measure-Object -Maximum -Minimum
$maxMinY = $points.y | Measure-Object -Maximum -Minimum
$maxX = $maxMinX.Maximum
$minX = $maxMinX.Minimum
$maxY = $maxMinY.Maximum
$minY = $maxMinY.Minimum
[int]$xLength = ($maxX - $minX)
[int]$yLength = ($maxY - $minY)

# simulate 1 step at a time
do {
    $tempXLength = $xLength
    $tempYLength = $yLength

    foreach ($point in $points) {
        $point.x = $point.x + $point.velocityX 
        $point.y = $point.y + $point.velocityy
    }
    
    $maxMinX = $points.x | Measure-Object -Maximum -Minimum
    $maxMinY = $points.y | Measure-Object -Maximum -Minimum
    $maxX = $maxMinX.Maximum
    $minX = $maxMinX.Minimum
    $maxY = $maxMinY.Maximum
    $minY = $maxMinY.Minimum
    [int]$xLength = ($maxX - $minX)
    [int]$yLength = ($maxY - $minY)

    $timepassed++

} while ($tempXLength -gt $xLength -and $tempYLength -gt $yLength)

# go back 1 step
foreach ($point in $points) {
    $point.x = $point.x - $point.velocityX
    $point.y = $point.y - $point.velocityy
}
$timepassed--
$timepassed
