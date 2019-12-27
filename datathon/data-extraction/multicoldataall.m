terra/data
terra/stats

job: P001/lab-4/multicol
result: multicolall.csv

: upsample_year_to_week { db }
  $dengue-sg db 365 days linear interpolate
; 

\ Convert rainfall to boolean
: rainy_day ( # -- # )
    [: 0 > -> 1 exit | 0 ;] apply
; 

: max_consecutive ( seq -- n )
	0 REF { count }
	[: 
		1 = IF 1 count +! ELSE 0 count ! THEN
		count @
	;] MAP maximum
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

: max_consecutive_all { db }
    $dengue-sg db ['] max_consecutive aggregate
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
        $temperature-clementi average_all
        $temperature-east-coast-parkway average_all
        $temperature-jurong-island average_all
        $temperature-khatib average_all
        $temperature-marina-barrage average_all
        $temperature-newton average_all
        $temperature-pasir-panjang average_all
        $temperature-pulau-ubin average_all
        $temperature-seletar average_all
        $temperature-semakau-island average_all
        $temperature-sembawang average_all
        $temperature-sentosa-island average_all
        $temperature-tai-seng average_all
        $temperature-tengah average_all
        $temperature-tuas-south average_all
        
        $temperature-admiralty maximum_all
        $temperature-ang-mo-kio maximum_all
        $temperature-boon-lay-east maximum_all
        $temperature-changi maximum_all
        $temperature-choa-chu-kang-south maximum_all
        $temperature-clementi maximum_all
        $temperature-east-coast-parkway maximum_all
        $temperature-jurong-island maximum_all
        $temperature-khatib maximum_all
        $temperature-marina-barrage maximum_all
        $temperature-newton maximum_all
        $temperature-pasir-panjang maximum_all
        $temperature-pulau-ubin maximum_all
        $temperature-seletar maximum_all
        $temperature-semakau-island maximum_all
        $temperature-sembawang maximum_all
        $temperature-sentosa-island maximum_all
        $temperature-tai-seng maximum_all
        $temperature-tengah maximum_all
        $temperature-tuas-south maximum_all
        
        $temperature-admiralty minimum_all
        $temperature-ang-mo-kio minimum_all
        $temperature-boon-lay-east minimum_all
        $temperature-changi minimum_all
        $temperature-choa-chu-kang-south minimum_all
        $temperature-clementi minimum_all
        $temperature-east-coast-parkway minimum_all
        $temperature-jurong-island minimum_all
        $temperature-khatib minimum_all
        $temperature-marina-barrage minimum_all
        $temperature-newton minimum_all
        $temperature-pasir-panjang minimum_all
        $temperature-pulau-ubin minimum_all
        $temperature-seletar minimum_all
        $temperature-semakau-island minimum_all
        $temperature-sembawang minimum_all
        $temperature-sentosa-island minimum_all
        $temperature-tai-seng minimum_all
        $temperature-tengah minimum_all
        $temperature-tuas-south minimum_all
        
        $rainfall-admiralty average_all
        $rainfall-admiralty-west average_all
        $rainfall-ang-mo-kio average_all
        $rainfall-boon-lay-east average_all
        $rainfall-boon-lay-west average_all
        $rainfall-botanic-garden average_all
        $rainfall-buangkok average_all
        $rainfall-bukit-panjang average_all
        $rainfall-bukit-timah average_all
        $rainfall-buona-vista average_all
        $rainfall-chai-chee average_all
        $rainfall-changi average_all
        $rainfall-choa-chu-kang-central average_all
        $rainfall-choa-chu-kang-south average_all
        $rainfall-choa-chu-kang-west average_all
        $rainfall-clementi average_all
        $rainfall-dhoby-ghaut average_all
        $rainfall-east-coast-parkway average_all
        $rainfall-jurong-east average_all
        $rainfall-jurong-north average_all
        $rainfall-jurong-island average_all
        $rainfall-jurong-pier average_all
        $rainfall-kampong-bahru average_all
        $rainfall-kent-ridge average_all
        $rainfall-khatib average_all
        $rainfall-kranji-reservoir average_all
        $rainfall-lim-chu-kang average_all
        $rainfall-lower-peirce-reservoir average_all
        $rainfall-macritchie-reservoir average_all
        $rainfall-mandai average_all
        $rainfall-marina-barrage average_all
        $rainfall-marine-parade average_all
        $rainfall-newton average_all
        $rainfall-nicoll-highway average_all
        $rainfall-pasir-panjang average_all
        $rainfall-pasir-ris-central average_all
        $rainfall-pasir-ris-west average_all
        $rainfall-paya-lebar average_all
        $rainfall-pulau-ubin average_all
        $rainfall-punggol average_all
        $rainfall-queenstown average_all
        $rainfall-seletar average_all
        $rainfall-semakau-island average_all
        $rainfall-sembawang average_all
        $rainfall-sentosa-island average_all
        $rainfall-serangoon average_all
        $rainfall-serangoon-north average_all
        $rainfall-simei average_all
        $rainfall-somerset-road average_all
        $rainfall-tai-seng average_all
        $rainfall-tanjong-katong average_all
        $rainfall-tanjong-pagar average_all
        $rainfall-tengah average_all
        $rainfall-toa-payoh average_all
        $rainfall-tuas average_all
        $rainfall-tuas-south average_all
        $rainfall-tuas-west average_all
        $rainfall-ulu-pandan average_all
        $rainfall-upper-peirce-reservoir average_all
        $rainfall-upper-thomson average_all
        $rainfall-whampoa average_all
        $rainfall-yishun average_all
        
        $rainfall-admiralty maximum_all
        $rainfall-admiralty-west maximum_all
        $rainfall-ang-mo-kio maximum_all
        $rainfall-boon-lay-east maximum_all
        $rainfall-boon-lay-west maximum_all
        $rainfall-botanic-garden maximum_all
        $rainfall-buangkok maximum_all
        $rainfall-bukit-panjang maximum_all
        $rainfall-bukit-timah maximum_all
        $rainfall-buona-vista maximum_all
        $rainfall-chai-chee maximum_all
        $rainfall-changi maximum_all
        $rainfall-choa-chu-kang-central maximum_all
        $rainfall-choa-chu-kang-south maximum_all
        $rainfall-choa-chu-kang-west maximum_all
        $rainfall-clementi maximum_all
        $rainfall-dhoby-ghaut maximum_all
        $rainfall-east-coast-parkway maximum_all
        $rainfall-jurong-east maximum_all
        $rainfall-jurong-north maximum_all
        $rainfall-jurong-island maximum_all
        $rainfall-jurong-pier maximum_all
        $rainfall-kampong-bahru maximum_all
        $rainfall-kent-ridge maximum_all
        $rainfall-khatib maximum_all
        $rainfall-kranji-reservoir maximum_all
        $rainfall-lim-chu-kang maximum_all
        $rainfall-lower-peirce-reservoir maximum_all
        $rainfall-macritchie-reservoir maximum_all
        $rainfall-mandai maximum_all
        $rainfall-marina-barrage maximum_all
        $rainfall-marine-parade maximum_all
        $rainfall-newton maximum_all
        $rainfall-nicoll-highway maximum_all
        $rainfall-pasir-panjang maximum_all
        $rainfall-pasir-ris-central maximum_all
        $rainfall-pasir-ris-west maximum_all
        $rainfall-paya-lebar maximum_all
        $rainfall-pulau-ubin maximum_all
        $rainfall-punggol maximum_all
        $rainfall-queenstown maximum_all
        $rainfall-seletar maximum_all
        $rainfall-semakau-island maximum_all
        $rainfall-sembawang maximum_all
        $rainfall-sentosa-island maximum_all
        $rainfall-serangoon maximum_all
        $rainfall-serangoon-north maximum_all
        $rainfall-simei maximum_all
        $rainfall-somerset-road maximum_all
        $rainfall-tai-seng maximum_all
        $rainfall-tanjong-katong maximum_all
        $rainfall-tanjong-pagar maximum_all
        $rainfall-tengah maximum_all
        $rainfall-toa-payoh maximum_all
        $rainfall-tuas maximum_all
        $rainfall-tuas-south maximum_all
        $rainfall-tuas-west maximum_all
        $rainfall-ulu-pandan maximum_all
        $rainfall-upper-peirce-reservoir maximum_all
        $rainfall-upper-thomson maximum_all
        $rainfall-whampoa maximum_all
        $rainfall-yishun maximum_all
        
        $rainfall-admiralty minimum_all
        $rainfall-admiralty-west minimum_all
        $rainfall-ang-mo-kio minimum_all
        $rainfall-boon-lay-east minimum_all
        $rainfall-boon-lay-west minimum_all
        $rainfall-botanic-garden minimum_all
        $rainfall-buangkok minimum_all
        $rainfall-bukit-panjang minimum_all
        $rainfall-bukit-timah minimum_all
        $rainfall-buona-vista minimum_all
        $rainfall-chai-chee minimum_all
        $rainfall-changi minimum_all
        $rainfall-choa-chu-kang-central minimum_all
        $rainfall-choa-chu-kang-south minimum_all
        $rainfall-choa-chu-kang-west minimum_all
        $rainfall-clementi minimum_all
        $rainfall-dhoby-ghaut minimum_all
        $rainfall-east-coast-parkway minimum_all
        $rainfall-jurong-east minimum_all
        $rainfall-jurong-north minimum_all
        $rainfall-jurong-island minimum_all
        $rainfall-jurong-pier minimum_all
        $rainfall-kampong-bahru minimum_all
        $rainfall-kent-ridge minimum_all
        $rainfall-khatib minimum_all
        $rainfall-kranji-reservoir minimum_all
        $rainfall-lim-chu-kang minimum_all
        $rainfall-lower-peirce-reservoir minimum_all
        $rainfall-macritchie-reservoir minimum_all
        $rainfall-mandai minimum_all
        $rainfall-marina-barrage minimum_all
        $rainfall-marine-parade minimum_all
        $rainfall-newton minimum_all
        $rainfall-nicoll-highway minimum_all
        $rainfall-pasir-panjang minimum_all
        $rainfall-pasir-ris-central minimum_all
        $rainfall-pasir-ris-west minimum_all
        $rainfall-paya-lebar minimum_all
        $rainfall-pulau-ubin minimum_all
        $rainfall-punggol minimum_all
        $rainfall-queenstown minimum_all
        $rainfall-seletar minimum_all
        $rainfall-semakau-island minimum_all
        $rainfall-sembawang minimum_all
        $rainfall-sentosa-island minimum_all
        $rainfall-serangoon minimum_all
        $rainfall-serangoon-north minimum_all
        $rainfall-simei minimum_all
        $rainfall-somerset-road minimum_all
        $rainfall-tai-seng minimum_all
        $rainfall-tanjong-katong minimum_all
        $rainfall-tanjong-pagar minimum_all
        $rainfall-tengah minimum_all
        $rainfall-toa-payoh minimum_all
        $rainfall-tuas minimum_all
        $rainfall-tuas-south minimum_all
        $rainfall-tuas-west minimum_all
        $rainfall-ulu-pandan minimum_all
        $rainfall-upper-peirce-reservoir minimum_all
        $rainfall-upper-thomson minimum_all
        $rainfall-whampoa minimum_all
        $rainfall-yishun minimum_all
        
        $rainfall-admiralty rainy_day max_consecutive_all
        $rainfall-admiralty-west rainy_day max_consecutive_all
        $rainfall-ang-mo-kio rainy_day max_consecutive_all
        $rainfall-boon-lay-east rainy_day max_consecutive_all
        $rainfall-boon-lay-west rainy_day max_consecutive_all
        $rainfall-botanic-garden rainy_day max_consecutive_all
        $rainfall-buangkok rainy_day max_consecutive_all
        $rainfall-bukit-panjang rainy_day max_consecutive_all
        $rainfall-bukit-timah rainy_day max_consecutive_all
        $rainfall-buona-vista rainy_day max_consecutive_all
        $rainfall-chai-chee rainy_day max_consecutive_all
        $rainfall-changi rainy_day max_consecutive_all
        $rainfall-choa-chu-kang-central rainy_day max_consecutive_all
        $rainfall-choa-chu-kang-south rainy_day max_consecutive_all
        $rainfall-choa-chu-kang-west rainy_day max_consecutive_all
        $rainfall-clementi rainy_day max_consecutive_all
        $rainfall-dhoby-ghaut rainy_day max_consecutive_all
        $rainfall-east-coast-parkway rainy_day max_consecutive_all
        $rainfall-jurong-east rainy_day max_consecutive_all
        $rainfall-jurong-north rainy_day max_consecutive_all
        $rainfall-jurong-island rainy_day max_consecutive_all
        $rainfall-jurong-pier rainy_day max_consecutive_all
        $rainfall-kampong-bahru rainy_day max_consecutive_all
        $rainfall-kent-ridge rainy_day max_consecutive_all
        $rainfall-khatib rainy_day max_consecutive_all
        $rainfall-kranji-reservoir rainy_day max_consecutive_all
        $rainfall-lim-chu-kang rainy_day max_consecutive_all
        $rainfall-lower-peirce-reservoir rainy_day max_consecutive_all
        $rainfall-macritchie-reservoir rainy_day max_consecutive_all
        $rainfall-mandai rainy_day max_consecutive_all
        $rainfall-marina-barrage rainy_day max_consecutive_all
        $rainfall-marine-parade rainy_day max_consecutive_all
        $rainfall-newton rainy_day max_consecutive_all
        $rainfall-nicoll-highway rainy_day max_consecutive_all
        $rainfall-pasir-panjang rainy_day max_consecutive_all
        $rainfall-pasir-ris-central rainy_day max_consecutive_all
        $rainfall-pasir-ris-west rainy_day max_consecutive_all
        $rainfall-paya-lebar rainy_day max_consecutive_all
        $rainfall-pulau-ubin rainy_day max_consecutive_all
        $rainfall-punggol rainy_day max_consecutive_all
        $rainfall-queenstown rainy_day max_consecutive_all
        $rainfall-seletar rainy_day max_consecutive_all
        $rainfall-semakau-island rainy_day max_consecutive_all
        $rainfall-sembawang rainy_day max_consecutive_all
        $rainfall-sentosa-island rainy_day max_consecutive_all
        $rainfall-serangoon rainy_day max_consecutive_all
        $rainfall-serangoon-north rainy_day max_consecutive_all
        $rainfall-simei rainy_day max_consecutive_all
        $rainfall-somerset-road rainy_day max_consecutive_all
        $rainfall-tai-seng rainy_day max_consecutive_all
        $rainfall-tanjong-katong rainy_day max_consecutive_all
        $rainfall-tanjong-pagar rainy_day max_consecutive_all
        $rainfall-tengah rainy_day max_consecutive_all
        $rainfall-toa-payoh rainy_day max_consecutive_all
        $rainfall-tuas rainy_day max_consecutive_all
        $rainfall-tuas-south rainy_day max_consecutive_all
        $rainfall-tuas-west rainy_day max_consecutive_all
        $rainfall-ulu-pandan rainy_day max_consecutive_all
        $rainfall-upper-peirce-reservoir rainy_day max_consecutive_all
        $rainfall-upper-thomson rainy_day max_consecutive_all
        $rainfall-whampoa rainy_day max_consecutive_all
        $rainfall-yishun rainy_day max_consecutive_all
        
        $population-sg upsample_year_to_week
    }} "-" >csv 
;


