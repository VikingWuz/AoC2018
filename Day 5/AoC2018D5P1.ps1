$polymer = Get-Content C:\AoC\2018\AoC2018D5.txt
$initalLength = $polymer.Length + 1

while ($polymer.Length -lt $initalLength) {
    $initalLength = $polymer.Length
    65..90 | ForEach-Object { 
        [string]$uppercase = [char]$_
        [string]$lowercase = [char]($_ + 32)
        $polymer = $polymer.Replace("$($lowercase)$($uppercase)","").Replace("$($uppercase)$($lowercase)","")
    }
}

$polymer.Length


