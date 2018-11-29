﻿## 
## reverse an array
##

 $carray = 'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'
 $carray -join ','
 [array]::Reverse($carray)
 $carray -join ','

 $iarray = 1,2,3,4,5,6,8,9,10
 "$iarray"
 [array]::Reverse($iarray)
 "$iarray"

 $psa = Get-Process p*
 $psa
 [array]::Reverse($psa)
 $psa