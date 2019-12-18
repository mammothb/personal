terra/data
terra/stats

job: P001/lab-4/multicol
result: multicolspacial.csv

: upsample_year_to_week { db }
  $dengue-sg db 365 days linear interpolate
; 

: avg ( n n -- n ) { a b }
    drop drop 1
; 

: interpolate_two_years { db }
    $dengue-sg db 730 days linear interpolate
; 

: average_all { db } 
    $dengue-sg db ['] average aggregate
; 

: maximum_all { db } 
    $dengue-sg db ['] maximum aggregate
; 

: minimum_all { db } 
    $dengue-sg db ['] minimum aggregate
; 

: _add
    dup null? -> drop exit |. +.
; 

: sums ( seq-# -- # ) { xs } 
   xs head 
   xs tail [: ['] _add fuse ;] reduce 
; 

: has?
    null? -> 0 exit |. 1
; 

: lengths { xs } 
  xs head ['] has? apply
  xs tail [: [: has? + ;] fuse ;] reduce 
; 

: spacial_avg ( seq-# -- # ) { xs }
    xs sums
    xs lengths
    ['] /. fuse
; 

\ Converts times to dd/MMM/yyyy
: human-times ( # -- # ) 
  [: 0 "dd/MMM/yyyy" format-time ;] apply-t
; 

: unix-times ( # -- # ) 
  [: 1000 /. ;] apply-t
;

: script  
    "0.0" %n
    {{ 
        $dengue-sg human-times
        $dengue-sg
        $temperature-marina-barrage average_all
        $temperature-newton average_all
        $temperature-sentosa-island average_all
        {{
            $temperature-newton
            $temperature-marina-barrage
            $temperature-sentosa-island
        }} spacial_avg average_all
        $population-sg upsample_year_to_week
    }} "-" >csv 
;