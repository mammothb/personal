terra/data
terra/stats

job: P001/lab-4/multicol
result: multicol.csv

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
        $temperature-admiralty average_all
        $temperature-ang-mo-kio average_all
        $temperature-boon-lay-east average_all
        $temperature-changi average_all
        $temperature-choa-chu-kang-south average_all
        $rainfall-admiralty average_all
        $rainfall-admiralty-west average_all
        $rainfall-ang-mo-kio average_all
        $rainfall-boon-lay-east average_all
        $rainfall-boon-lay-west average_all
        $temperature-admiralty minimum_all
        $temperature-ang-mo-kio minimum_all
        $temperature-boon-lay-east minimum_all
        $temperature-changi minimum_all
        $temperature-choa-chu-kang-south minimum_all
        $rainfall-admiralty minimum_all
        $rainfall-admiralty-west minimum_all
        $rainfall-ang-mo-kio minimum_all
        $rainfall-boon-lay-east minimum_all
        $rainfall-boon-lay-west minimum_all
        $temperature-admiralty maximum_all
        $temperature-ang-mo-kio maximum_all
        $temperature-boon-lay-east maximum_all
        $temperature-changi maximum_all
        $temperature-choa-chu-kang-south maximum_all
        $rainfall-admiralty maximum_all
        $rainfall-admiralty-west maximum_all
        $rainfall-ang-mo-kio maximum_all
        $rainfall-boon-lay-east maximum_all
        $rainfall-boon-lay-west maximum_all
        $population-sg upsample_year_to_week
    }} "-" >csv 
;

