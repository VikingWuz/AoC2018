$polymers = Get-Content C:\AoC\2018\AoC2018D5.txt
$shortestLenght = $polymers.Length

for ($i = 65; $i -lt 91; $i++) {    
    65..90 | ForEach-Object { 
        [string]$polymer = $polymers
        [string]$uppercase = [char]$_
        [string]$lowercase = [char]($_ + 32)
        $polymer = $polymer.Replace("$($lowercase)","").Replace("$($uppercase)","")

        $initalLength = $polymer.Length + 1
        while ($polymer.Length -lt $initalLength) {
            $initalLength = $polymer.Length
            65..90 | ForEach-Object { 
                [string]$uppercase = [char]$_
                [string]$lowercase = [char]($_ + 32)
                $polymer = $polymer.Replace("$($lowercase)$($uppercase)","").Replace("$($uppercase)$($lowercase)","")
            }
        }

        if ($polymer.Length -lt $shortestLenght) {
            $shortestLenght = $polymer.Length
        }
    }    
}

$shortestLenght