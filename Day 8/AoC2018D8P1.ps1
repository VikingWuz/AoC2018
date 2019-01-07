$licenseFile = Get-Content C:\AoC\2018\AoC2018D8.txt
[int[]]$licenseFileNumbers = $licenseFile.Split(" ")

function calculateMetaData ($licenseFilePointer) {
    $metaDataSum = 0
    $quantityChildNodes = $licenseFileNumbers[$licenseFilePointer]
    $licenseFilePointer++
    $quantityMetaDataEntries = $licenseFileNumbers[$licenseFilePointer]
    $licenseFilePointer++

    for ($i = 0; $i -lt $quantityChildNodes; $i++) {
        $childNodes = calculateMetaData -licenseFilePointer $licenseFilePointer
        $metaDataSum += $childNodes[0]
        $licenseFilePointer = $childNodes[1]
    }

    for ($j = 0; $j -lt $quantityMetaDataEntries; $j++) {
        $metaDataSum += $licenseFileNumbers[$licenseFilePointer]
        $licenseFilePointer++
    }
    return @($metaDataSum, $licenseFilePointer)
}

$metaDataTotalSum = calculateMetaData -licenseFilePointer 0
$metaDataTotalSum[0]