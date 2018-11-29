function test-palindrome {
  [CmdletBinding()]
  param (
    [string]$teststring
  )

  Write-Verbose -Message "Input string: $teststring"
  $cr = $teststring.ToCharArray()
  
  $ca = $cr | where {$_ -match '\w'}
  
  $clnstring  = -join $ca
  Write-Verbose -Message "Clean string: $clnstring"

  [array]::Reverse($ca)

  $revstring = -join $ca
  Write-Verbose -Message "Reversed string: $revstring"

  ## make test case insensitive
  if ($revstring -ieq $clnstring){
    $true
  }
  else {
    $false
  }

}

function get-reversestring {
  [CmdletBinding()]
  param (
    [string]$teststring
  )

  $ca = $teststring.ToCharArray()

  [array]::Reverse($ca)

  -join $ca
}