\
\ "in" is a sequence, eg, A:4:10. It contains temperature
\ readings from the past week.
\
\ We have a few builtin features you can use: 
\ in MAX -- gives the maximum temp. 
\ in MIN -- gives the minimum temp.
\ in RANGE -- temperature range (MAX - MIN)
\ in MEAN -- average temp. 
\ in SD   -- standard deviation of temp. 
\ in SKEWNESS -- the skewness ie, third moment
\ in KURTOSIS -- the kurtosis it, forth moment.
\ in k MOMENT -- the kth moment.
\ in LENGTH -- the length of the input sequence. Use this 
\              in conjunction with ABOVE and BELOW. 
\
\ These words produce sequences: 
\ in t ABOVE -- Values above the given threshold t
\ in t BELOW -- Values below the given threshold t.
\ in   DIFF -- gives the difference between T(k) and T(k-1). 
\ (!) Be careful using these, they produce sequences, not 
\ values. You should check if they are empty using nil? 
\ 
\ Combinations:
\
\ You can combine features like so: 
\ in DIFF DIFF MEAN -- will give you average second order differential. 
\ in 35 ABOVE LENGTH -- number of values in window above 35C.
\ in DIFF -- the difference of the input values.
\
\ Don't use combinations that give you "features" with varying lengths, 
\ eg:  
\ in DIFF 350 ABOVE \ BAD! 
\ The number of features thus generated will depend on the length of 
\ the sequence returned by ABOVE. The Neural Networks we work with 
\ require a Fixed number of inputs (features). 
\

: map_sum ( seq -- n )
    0 SWAP ['] +. REDUCE
; 

: emw ( seq n -- n ) { xs s }
    2 s 1 +. /. { alpha }
    0 1 ... s TAKE [: alpha SWAP ^ ;] MAP { top }
    top xs ['] *. ZIPWITH map_sum top map_sum /.
; 

: get-gradient ( seq n n -- n ) { xs xmean n }
    xs [: xmean -. ;] MAP 0 1 ... n TAKE [: n 2 /. -. ;] MAP ['] *. ZIPWITH SUM
    xs [: xmean -. ;] MAP xs [: xmean -. ;] MAP ['] *. ZIPWITH SUM /.
; 

: norm_temperature ( seq -- seq )
    [: 25 /. ;] MAP
; 

: norm_weekly ( seq -- seq )
    [: 7 /. ;] MAP
; 

: log_trans ( seq -- seq )
    [: 1 +. LN ;] MAP
; 

: transform
    A:8:0 MEAN   \ dengue-sg-log
\     A:8:0 8 emw   \ dengue-sg-log
    A:8          \ 8-week ahead forecast.
\     A:0:-8 MEAN  \ y0
\     A:0:-4 4 emw   \ dengue-sg-log
    A:0  \ y0
    
    \ ========== dengue-sg-log ========== 6
    A:0:-6
    A:0:-6 A:0:-6 MEAN 7 get-gradient
    
    \ ========== population-sg-log ========== 1
    2:0

    \ ========== temperature-avg ========== 4/16
\     3:-1:-4 norm_temperature MEAN
\     3:-5:-8 norm_temperature MEAN
\     3:-9:-12 norm_temperature MEAN
\     3:-13:-16 norm_temperature MEAN
\     3:-17:-20 norm_temperature MEAN
    
    3:0:-3 norm_temperature MEAN
    3:-4:-7 norm_temperature MEAN
    3:-8:-11 norm_temperature MEAN
    3:-12:-15 norm_temperature MEAN
    3:-16:-19 norm_temperature MEAN

    \ ========== temperature-avg flags ========== 1/4/3
\     3:-17:-20 [: 27.8 > IF 1 ELSE 0 THEN ;] MAP

    \ ========== temperature-hot-days ========== 4/16
\     6:-5:-8 norm_weekly MEAN
\     6:-9:-12 norm_weekly MEAN
\     6:-13:-16 norm_weekly MEAN
\     6:-17:-20 norm_weekly MEAN
    
    6:-4:-7 norm_weekly MEAN
    6:-8:-11 norm_weekly MEAN
    6:-12:-15 norm_weekly MEAN
    6:-16:-19 norm_weekly MEAN

    \ ========== abs-humidity-avg ========== 4/21
\     28:-1:-4 [: 100 /. ;] MAP MEAN
\     28:-5:-8 [: 100 /. ;] MAP MEAN
\     28:-9:-12 [: 100 /. ;] MAP MEAN
\     28:-13:-16 [: 100 /. ;] MAP MEAN
\     28:-17:-20 [: 100 /. ;] MAP MEAN
    
    28:0:-3 [: 100 /. ;] MAP MEAN
    28:-4:-7 [: 100 /. ;] MAP MEAN
    28:-8:-11 [: 100 /. ;] MAP MEAN
    28:-12:-15 [: 100 /. ;] MAP MEAN
    28:-16:-19 [: 100 /. ;] MAP MEAN

    \ ========== rainfall-rainy-days ========== 25/5/100
\     15, 16, 17, 18, 19
    
\     20:-1:-4 norm_weekly MEAN
\     20:-5:-8 norm_weekly MEAN
\     20:-9:-12 norm_weekly MEAN
\     20:-13:-16 norm_weekly MEAN
\     20:-17:-20 norm_weekly MEAN
    20:0:-3 norm_weekly MEAN
    20:-4:-7 norm_weekly MEAN
    20:-8:-11 norm_weekly MEAN
    20:-12:-15 norm_weekly MEAN
    20:-16:-19 norm_weekly MEAN
    
    20:0:-15 [: 6 > -> 1 | OTHERWISE 0 |. ;] MAP

    \ ========== rainfall-avg ========== 25/20
\     14:-1:-4 log_trans MEAN
\     14:-5:-8 log_trans MEAN
\     14:-9:-12 log_trans MEAN
\     14:-13:-16 log_trans MEAN
\     14:-17:-20 log_trans MEAN
    
    14:0:-3 log_trans MEAN
    14:-4:-7 log_trans MEAN
    14:-8:-11 log_trans MEAN
    14:-12:-15 log_trans MEAN
    14:-16:-19 log_trans MEAN

    \ ========== rainfall-avg flags ========== 5/2
\     14:-13:-16 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.
\     14:-9:-12 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE -1 |.
    
    14:-12:-15 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.
    14:-8:-11 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE -1 |.

    \ ========== rainfall-consecutive-days ========== 25/5/100
\     26:-1:-4 norm_weekly MEAN
\     26:-5:-8 norm_weekly MEAN
\     26:-9:-12 norm_weekly MEAN
\     
\     26:-13:-16 3.5 ABOVE LENGTH

    \ ========== hw-season ==========
    29:8:-6
    
\     14:0:-3 14.33 ABOVE LENGTH 0 > -> 1 | OTHERWISE 0 |.
\     14:0:-6 SUM 54 > -> 1 | OTHERWISE 0 |.
\     14:0:-7 SUM 88 > -> 1 | OTHERWISE 0 |.
\     14:0:-8 SUM 105 > -> 1 | OTHERWISE 0 |.
    30:0:-5 [: 46.5 > -> 1 | OTHERWISE 0 |. ;] MAP
;

