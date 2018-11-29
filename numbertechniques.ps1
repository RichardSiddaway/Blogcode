##
##  only works if ONE missing value
##
function get-missinginteger {
  [CmdletBinding()]
  param (
    [int[]]$iarray,
    
    [int]$expectedlength
  )

  #$expectedSum = ($expectedlength * ($expectedlength + 1) ) / 2

  # don't know if array is in numeric order
  $sarray = $iarray | sort
  
  $expectedSum = $expectedlength * (($sarray[0] + $sarray[-1]) / 2)

  $actualsum = 0
  foreach ($n in $iarray) {
    $actualsum += $n
  }

  $missingnumber = $expectedSum - $actualsum
  $missingnumber
}


function get-duplicate {
  [CmdletBinding()]
  param (
    [int[]]$iarray
  )

  $iarray | Group-Object | 
  where Count -gt 1 |
  foreach {
    New-Object -TypeName PSobject -Property @{
      DuplicateNumber = $_.Name
      Count           = $_.Count
    }
  }
}



function remove-duplicate {
  [CmdletBinding()]
  param (
    [int[]]$iarray
  )
    
  $dupcount =@{}
  
  $duplicates = get-duplicate -iarray $iarray

  $dedup = $iarray | foreach {
    if ($_ -in $duplicates.DuplicateNumber) {
      if ( -not $dupcount["$_"]) {
         $dupcount += @{"$_" = 1 }
         $psitem
      } 
    }
    else {
       $psitem
    }
  }

  $dedup
}



function get-minmax {
  [CmdletBinding()]
  param (
    [int[]]$iarray
  )
  
  $mm = $iarray | Measure-Object -Minimum -Maximum 
  
  New-Object -TypeName PSobject -Property @{
    Minimum = $mm.Minimum
    Maximum = $mm.Maximum
  }
}


function get-pairs {
  [CmdletBinding()]
  param (
    [int[]]$iarray,

    [int]$value
  )

  Write-Information -MessageData "Array: $iarray" -InformationAction Continue
  Write-Information -MessageData "Sum: $value" -InformationAction Continue
  
  for ($i=0; $i -le ($iarray.Count -1); $i++){
    
    for ($j= $i+1; $j -le ($iarray.Count -1); $j++){

      if( ($iarray[$i] + $iarray[$j]) -eq $value) {
         
               Write-Information -MessageData "Pair to give sum: ($($iarray[$i]), $($iarray[$j]))" -InformationAction Continue

      }
    } 
  }
}

function get-pairs1 {
  [CmdletBinding()]
  param (
    [int[]]$iarray,

    [int]$value
  )

  Write-Information -MessageData "Array: $iarray" -InformationAction Continue
  Write-Information -MessageData "Sum: $value" -InformationAction Continue
  
  foreach ($n in $iarray){
    $target = $value - $n

    if ($target -in $iarray) {
      Write-Information -MessageData "Pair to give sum: ($n, $target)" -InformationAction Continue
    }
  }
}

function get-pairs2 {
  [CmdletBinding()]
  param (
    [int[]]$iarray,

    [int]$value
  )
    
  $sarray = $iarray | Sort-Object

  Write-Information -MessageData "Array: $iarray" -InformationAction Continue
  Write-Information -MessageData "Sorted Array: $sarray" -InformationAction Continue
  Write-Information -MessageData "Sum: $value" -InformationAction Continue
  
  $left = 0
  $right = $sarray.Count - 1
  
  while ($left -lt $right){
    Write-Verbose -Message "left = $left  right =$right"
    $sum = $sarray[$left] + $sarray[$right]

    if ($sum -eq $value){
       Write-Information -MessageData "Pair to give sum: ($($sarray[$left]), $($sarray[$right]))" -InformationAction Continue
       $left += 1
       $right -= 1
    }
    elseif ($sum -lt $value) {
      $left += 1
    }
    elseif ($sum -gt $value){
      $right -= 1
    }
  } 
}


##
##  EXAMPLES
##
##

##
## get missing number
##
## 10 integers - number 7 missing
$iarray = 1,2,3,4,5,6,8,9,10

get-missinginteger -iarray $iarray -expectedlength 10

## 25 integers - number 19 missing
$iarray = 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,20,21,22,23,24,25

get-missinginteger -iarray $iarray -expectedlength 25


## 20 integers - number 19 missing. Starts at 6
$iarray = 6,7,8,9,10,11,12,13,14,15,16,17,18,20,21,22,23,24,25

get-missinginteger -iarray $iarray -expectedlength 20


##
## get duplicate number
##
$iarray = 1,2,3,4,23,5,6,7,8,9,10,23,11,12,13,7,14,15,16,17,18,20,21,22,11,23,24,25
get-duplicate -iarray $iarray

remove-duplicate -iarray $iarray

remove-duplicate -iarray $iarray | sort


##
## get maximum and minimum
##
$iarray = 1,2,3,4,23,5,6,7,8,9,10,23,11,12,13,7,14,15,16,17,18,20,21,22,11,23,24,25
get-minmax -iarray $iarray

$iarray = 1..100 | foreach {Get-Random -Minimum 1 -Maximum 101}
get-minmax -iarray $iarray

##
## pairs adding up to given number
##
$iarray = 1,8,3,-3,6,4,9,5,10,2
get-pairs -iarray $iarray -value 7 

get-pairs1 -iarray $iarray -value 7 