##
#
# I first tried to draw every 1000st image but failed horibly with the big numbers, bitmap($xLength,$yLength) is way to big
# and with Forms its impossible to see something....many hours of my life wasted ;)
# Then i tried to count how many times point.x is the same as all x values in points array and comparing it to a variable amountOfXSame, hoping 
# there would be a letter like L or I... with the example it worked but for my input it never finished, propaply should have waited longer O(n*m) for every single step
# Finally by looking at other peoples code i realized that the coordinates move closer for each step, i lopped so long till xLength or yLenght was smaller 
# the xLength or yLenght from the step before, then go back one step...to make it faster i initially make 100 steps at a time till found, then revert 100 steps,
# then make one step at a time, then go back one step. At the end I draw the coordinates with Forms
#
##
[void][reflection.assembly]::LoadWithPartialName( "System.Windows.Forms")
[void][reflection.assembly]::LoadWithPartialName( "System.Drawing")

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
} while ($tempXLength -gt $xLength -and $tempYLength -gt $yLength)

# go back 100 steps
foreach ($point in $points) {
    $point.x = $point.x - $point.velocityX * $multiplicator
    $point.y = $point.y - $point.velocityy * $multiplicator
}

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
} while ($tempXLength -gt $xLength -and $tempYLength -gt $yLength)

# go back 1 step
foreach ($point in $points) {
    $point.x = $point.x - $point.velocityX
    $point.y = $point.y - $point.velocityy
}

$maxMinX = $points.x | Measure-Object -Maximum -Minimum
$maxMinY = $points.y | Measure-Object -Maximum -Minimum
$minX = $maxMinX.Minimum
$minY = $maxMinY.Minimum

$form = New-Object Windows.Forms.Form
$myBrush = new-object Drawing.SolidBrush red
$formGraphics = $form.createGraphics()
$form.add_paint(
{   
    foreach ($point in $points) {
        $formGraphics.FillRectangle($myBrush, $point.x - $minX, $point.y - $minY, 1, 1)
    }
}
)
$form.ShowDialog()
