terra/data
terra/stats

job: P001/lab-4/multicol
result: test-multicol.csv

: , { db } 
  $dengue-sg db ['] average aggregate
; 

: human-times ( # -- # ) 
  [: 0 "dd/MMM/yyyy" format-time ;] apply-t
;

: script  
    "0" %n
    {{ 
        $dengue-sg human-times .hash
\         $dengue-sg
\         $rainfall-changi
\         $rainfall-mandai
\         $temperature-changi
    }} "-" >csv 
;