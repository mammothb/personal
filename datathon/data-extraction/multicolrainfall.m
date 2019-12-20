terra/data
terra/stats

job: P001/lab-4/multicol
result: multicolrainfall.csv

\ Converts times to dd/MMM/yyyy
: human-times ( # -- # ) 
  [: 0 "dd/MMM/yyyy" format-time ;] apply-t
; 

\ Convert rainfall to boolean
: rainy_day ( # -- # )
    [: 0 > -> 1 exit | 0 ;] apply
; 

: sum_all { db } 
    $dengue-sg db ['] sum aggregate
; 

: max_consecutive ( seq -- n )
	0 REF { count }
	[: 
		1 = IF 1 count +! ELSE 0 count ! THEN
		count @
	;] MAP maximum
; 

: max_consecutive_all { db }
    $dengue-sg db ['] max_consecutive aggregate
; 

: script  
    "0.0" %n
    {{
        $dengue-sg human-times
        $dengue-sg
        $rainfall-admiralty sum_all
        $rainfall-admiralty rainy_day sum_all
        $rainfall-admiralty rainy_day max_consecutive_all
        $rainfall-changi sum_all
        $rainfall-changi rainy_day sum_all
        $rainfall-changi rainy_day max_consecutive_all
    }} "-" >csv 
; 

\ : mapf ( seq xt -- seq ) ~ { f }
\ 	[: f >R ;] MAP
\ \ 	['] R> FILTER
\     ['] R>
\ ; 
\ 
\ : positive-negative ( n -- n ) 
\ 	0 > IF 1 ELSE -1 THEN 
\ ; 
\ 
\ : changes ( seq -- seq ) 
\ 	DUP TAIL SWAP ['] - ZIPWITH
\ 	['] positive-negative MAP
\ ; 
\ 
\ : freq-ori ( n -- xt )
\ 	0 REF { count }
\ 	0 REF { state }
\ 	[: 
\ 		DUP state @ = 
\ 		SWAP state !
\ 		DUP
\ \ 		IF state @ count +! 0
\ \ 		ELSE count @ state @ count ! THEN
\ \ 		DUP 0 = IF false ELSE true THEN
\ 	;]
\ ; 
\ 
\ 
\ {{ 1 1 -1 -1 -1 1 1 -1 -1 }} freq-ori map .list . cr
\ "end" . cr
\ {{ 0 1 0 0 1 1 1 0 0 0 1 1 1 }} max_consecutive . cr
\ "end" . cr
\ {{ 0 1 0 0 1 1 1 1 0 0 0 1 1 0 }} max_consecutive . cr
\ "end" . cr
\ {{ 1 1 0 0 1 1 1 0 0 0 1 1 1 1 }} max_consecutive . cr
\ "end" . cr
