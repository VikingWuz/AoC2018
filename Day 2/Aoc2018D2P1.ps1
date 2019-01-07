$ids = Get-Content C:\AoC\2018\AoC2018D2.txt
$checksum = 0
$exactlyTwo = 0
$exactlyTree = 0

foreach ($id in $ids) {
    $count = @{}
    for($i = 0; $i -lt $id.Length; $i++) {
        $char = $id[$i]
        if ($count.ContainsKey($char)) {
            $count[$char] = ++$count[$char]
        } else {
            $count.Add($char,1)
        }
    }
    if ($count.ContainsValue(2)) {
        $exactlyTwo++
    }
    if ($count.ContainsValue(3)) {
        $exactlyTree++
    }
}

$checksum =+ $exactlyTwo * $exactlyTree
$checksum