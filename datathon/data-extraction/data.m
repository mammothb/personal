\
\ @author: Arnold Doray
\ @date: 3 Dec 2019
\
\ A simple data extraction script.
\

terra/data  \ data access into the dengue and other datasets.
terra/stats \ statistical functions like average, sd, etc. 

\ The name of your data extraction job. 
job: P001/lab-3

\ Where to save the results. 
result: data.csv

: ref ; 0 ,

: counter
	['] ref @ 
	1 + dup
	['] ref ! 
\ 	. 
;

: replace_null ( n n -- n ) { a b }
\    b null? -> 1 exit |. b
  counter
\   b
; 

: avg ( n n -- n ) 
   dup null? -> drop exit |. 
   +. 2 /. 
;

\ Extracts all data from $dengue-sg before present and 
\ averages them. 
: script
    $temperature-changi $rainfall-admiralty-west ['] replace_null fuse
\     $dengue-sg
\     $temperature-admiralty
\     $temperature-ang-mo-kio
\     $temperature-boon-lay-east
\     $temperature-changi
\     $temperature-choa-chu-kang-south
\     $temperature-clementi
\     $temperature-east-coast-parkway
\     $temperature-jurong-island
\     $temperature-khatib
\     $temperature-marina-barrage
\     $temperature-newton
\     $temperature-pasir-panjang
\     $temperature-pulau-ubin
\     $temperature-seletar
\     $temperature-semakau-island
\     $temperature-sembawang
\     $temperature-sentosa-island
\     $temperature-tai-seng
\     $temperature-tengah
\     $temperature-tuas-south
\     $rainfall-admiralty
\     $rainfall-admiralty-west
\     $rainfall-ang-mo-kio
\     $rainfall-boon-lay-east
\     $rainfall-boon-lay-west
\     $rainfall-botanic-garden
\     $rainfall-buangkok
\     $rainfall-bukit-panjang
\     $rainfall-bukit-timah
\     $rainfall-buona-vista
\     $rainfall-chai-chee
\     $rainfall-changi
\     $rainfall-choa-chu-kang-central
\     $rainfall-choa-chu-kang-south
\     $rainfall-choa-chu-kang-west
\     $rainfall-clementi
\     $rainfall-dhoby-ghaut
\     $rainfall-east-coast-parkway
\     $rainfall-jurong-east
\     $rainfall-jurong-north
\     $rainfall-jurong-island
\     $rainfall-jurong-pier
\     $rainfall-kampong-bahru
\     $rainfall-kent-ridge
\     $rainfall-khatib
\     $rainfall-kranji-reservoir
\     $rainfall-lim-chu-kang
\     $rainfall-lower-peirce-reservoir
\     $rainfall-macritchie-reservoir
\     $rainfall-mandai
\     $rainfall-marina-barrage
\     $rainfall-marine-parade
\     $rainfall-newton
\     $rainfall-nicoll-highway
\     $rainfall-pasir-panjang
\     $rainfall-pasir-ris-central
\     $rainfall-pasir-ris-west
\     $rainfall-paya-lebar
\     $rainfall-pulau-ubin
\     $rainfall-punggol
\     $rainfall-queenstown
\     $rainfall-seletar
\     $rainfall-semakau-island
\     $rainfall-sembawang
\     $rainfall-sentosa-island
\     $rainfall-serangoon
\     $rainfall-serangoon-north
\     $rainfall-simei
\     $rainfall-somerset-road
\     $rainfall-tai-seng
\     $rainfall-tanjong-katong
\     $rainfall-tanjong-pagar
\     $rainfall-tengah
\     $rainfall-toa-payoh
\     $rainfall-tuas
\     $rainfall-tuas-south
\     $rainfall-tuas-west
\     $rainfall-ulu-pandan
\     $rainfall-upper-peirce-reservoir
\     $rainfall-upper-thomson
\     $rainfall-whampoa
\     $rainfall-yishun
;