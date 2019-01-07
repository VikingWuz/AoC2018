$numbers = Get-Content C:\AoC\2018\AoC2018D1.txt
$i = 0

foreach ($number in $numbers) {    
    $i +=$number
}

$i

