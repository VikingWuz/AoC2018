$numbers = Get-Content C:\AoC\2018\AoC2018D1.txt
$i = 0
$result = @{}
$found = $false

while(!$found) {
    foreach ($number in $numbers) {
        $i +=$number
        if($result.ContainsKey($i)) {
            $found = $true
            break
        } else {
            $result[$i]++
        }
    }
}

$i