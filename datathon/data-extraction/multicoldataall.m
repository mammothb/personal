terra/data
terra/stats

job: P001/lab-4/multicol
result: multicolall.csv

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
        $temperature-admiralty  average_all
        $temperature-ang-mo-kio  average_all
        $temperature-boon-lay-east  average_all
        $temperature-changi  average_all
        $temperature-choa-chu-kang-south  average_all
        $temperature-clementi  average_all
        $temperature-east-coast-parkway  average_all
        $temperature-jurong-island  average_all
        $temperature-khatib  average_all
        $temperature-marina-barrage  average_all
        $temperature-newton  average_all
        $temperature-pasir-panjang  average_all
        $temperature-pulau-ubin  average_all
        $temperature-seletar  average_all
        $temperature-semakau-island  average_all
        $temperature-sembawang  average_all
        $temperature-sentosa-island  average_all
        $temperature-tai-seng  average_all
        $temperature-tengah  average_all
        $temperature-tuas-south  average_all
        $rainfall-admiralty  average_all
        $rainfall-admiralty-west  average_all
        $rainfall-ang-mo-kio  average_all
        $rainfall-boon-lay-east  average_all
        $rainfall-boon-lay-west  average_all
        $rainfall-botanic-garden  average_all
        $rainfall-buangkok  average_all
        $rainfall-bukit-panjang  average_all
        $rainfall-bukit-timah  average_all
        $rainfall-buona-vista  average_all
        $rainfall-chai-chee  average_all
        $rainfall-changi  average_all
        $rainfall-choa-chu-kang-central  average_all
        $rainfall-choa-chu-kang-south  average_all
        $rainfall-choa-chu-kang-west  average_all
        $rainfall-clementi  average_all
        $rainfall-dhoby-ghaut  average_all
        $rainfall-east-coast-parkway  average_all
        $rainfall-jurong-east  average_all
        $rainfall-jurong-north  average_all
        $rainfall-jurong-island  average_all
        $rainfall-jurong-pier  average_all
        $rainfall-kampong-bahru  average_all
        $rainfall-kent-ridge  average_all
        $rainfall-khatib  average_all
        $rainfall-kranji-reservoir  average_all
        $rainfall-lim-chu-kang  average_all
        $rainfall-lower-peirce-reservoir  average_all
        $rainfall-macritchie-reservoir  average_all
        $rainfall-mandai  average_all
        $rainfall-marina-barrage  average_all
        $rainfall-marine-parade  average_all
        $rainfall-newton  average_all
        $rainfall-nicoll-highway  average_all
        $rainfall-pasir-panjang  average_all
        $rainfall-pasir-ris-central  average_all
        $rainfall-pasir-ris-west  average_all
        $rainfall-paya-lebar  average_all
        $rainfall-pulau-ubin  average_all
        $rainfall-punggol  average_all
        $rainfall-queenstown  average_all
        $rainfall-seletar  average_all
        $rainfall-semakau-island  average_all
        $rainfall-sembawang  average_all
        $rainfall-sentosa-island  average_all
        $rainfall-serangoon  average_all
        $rainfall-serangoon-north  average_all
        $rainfall-simei  average_all
        $rainfall-somerset-road  average_all
        $rainfall-tai-seng  average_all
        $rainfall-tanjong-katong  average_all
        $rainfall-tanjong-pagar  average_all
        $rainfall-tengah  average_all
        $rainfall-toa-payoh  average_all
        $rainfall-tuas  average_all
        $rainfall-tuas-south  average_all
        $rainfall-tuas-west  average_all
        $rainfall-ulu-pandan  average_all
        $rainfall-upper-peirce-reservoir  average_all
        $rainfall-upper-thomson  average_all
        $rainfall-whampoa  average_all
        $rainfall-yishun
        $population-sg upsample_year_to_week
    }} "-" >csv 
;