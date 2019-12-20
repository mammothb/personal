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
        \ temperature-north
        {{
            $temperature-changi
            $temperature-admiralty
            $temperature-khatib
            $temperature-sembawang
        }} spacial_avg average_all
\         \ temperature-northeast
\         {{
\             $temperature-seletar
\             $temperature-ang-mo-kio
\             $temperature-tai-seng
\         }} spacial_avg average_all
\         \ temperature-east
\         {{
\             $temperature-changi
\             $temperature-east-coast-parkway
\             $temperature-pulau-ubin
\         }} spacial_avg average_all
\         \ temperature-west
\         {{
\             $temperature-tengah
\             $temperature-boon-lay-east
\             $temperature-choa-chu-kang-south
\             $temperature-clementi
\             $temperature-jurong-island
\             $temperature-pasir-panjang
\             $temperature-semakau-island
\             $temperature-tuas-south
\         }} spacial_avg average_all
\         \ temperature-central
\         {{
\             $temperature-newton
\             $temperature-marina-barrage
\             $temperature-sentosa-island
\         }} spacial_avg average_all
\         \ rainfall-north
\         {{
\             $rainfall-sembawang
\             $rainfall-admiralty
\             $rainfall-admiralty-west
\             $rainfall-khatib
\             $rainfall-kranji-reservoir
\             $rainfall-lim-chu-kang
\             $rainfall-mandai
\             $rainfall-yishun
\         }} spacial_avg average_all
\         \ rainfall-northeast
\         {{
\             $rainfall-seletar
\             $rainfall-ang-mo-kio
\             $rainfall-buangkok
\             $rainfall-lower-peirce-reservoir
\             $rainfall-punggol
\             $rainfall-serangoon
\             $rainfall-serangoon-north
\             $rainfall-tai-seng
\             $rainfall-upper-peirce-reservoir
\             $rainfall-upper-thomson
\         }} spacial_avg average_all
\         \ rainfall-east
\         {{
\             $rainfall-changi
\             $rainfall-chai-chee
\             $rainfall-east-coast-parkway
\             $rainfall-pasir-ris-central
\             $rainfall-pasir-ris-west
\             $rainfall-paya-lebar
\             $rainfall-pulau-ubin
\             $rainfall-simei
\             $rainfall-tanjong-katong
\         }} spacial_avg average_all
\         \ rainfall-west
\         {{
\             $rainfall-tengah
\             $rainfall-boon-lay-east
\             $rainfall-boon-lay-west
\             $rainfall-bukit-panjang
\             $rainfall-choa-chu-kang-central
\             $rainfall-choa-chu-kang-south
\             $rainfall-choa-chu-kang-west
\             $rainfall-clementi
\             $rainfall-jurong-east
\             $rainfall-jurong-north
\             $rainfall-jurong-island
\             $rainfall-jurong-pie
\             $rainfall-kent-ridge
\             $rainfall-pasir-panjang
\             $rainfall-semakau-island
\             $rainfall-tuas
\             $rainfall-tuas-south
\             $rainfall-tuas-west
\         }} spacial_avg average_all
\         \ rainfall-central
\         {{
\             $rainfall-kampong-bahru
\             $rainfall-botanic-garden
\             $rainfall-bukit-timah
\             $rainfall-buona-vista
\             $rainfall-dhoby-ghaut
\             $rainfall-macritchie-reservoir
\             $rainfall-marina-barrage
\             $rainfall-marine-parade
\             $rainfall-newton
\             $rainfall-nicoll-highway
\             $rainfall-queenstown
\             $rainfall-sentosa-island
\             $rainfall-somerset-road
\             $rainfall-tanjong-pagar
\             $rainfall-toa-payoh
\             $rainfall-ulu-pandan
\             $rainfall-whampoa
\         }} spacial_avg average_all
        $population-sg upsample_year_to_week
    }} "-" >csv 
;


