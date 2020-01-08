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
    A:8:0 8 emw   \ dengue-sg-log
    A:8          \ 8-week ahead forecast.
\     A:8:0 MEAN  \ dengue-sg-log
\     A:8          \ 8-week ahead forecast.
\     A:0:-8 MEAN  \ y0
    A:0:-4 4 emw   \ dengue-sg-log
\     A:0:-8 MEAN  \ y0
\     A:0:-8 8 emw  \ y0
    
    \ ========== dengue-sg-log ========== 8
    A:0:-6
    A:0:-6 A:0:-6 MEAN 7 get-gradient
    
    \ ========== population-sg-log ========== 1
    2:0

    \ ========== temperature-avg ========== 16
    3:-1:-4 norm_temperature MEAN
    3:-5:-8 norm_temperature MEAN
    3:-9:-12 norm_temperature MEAN
    3:-13:-16 norm_temperature MEAN
    3:-17:-20 norm_temperature MEAN

    \ ========== temperature-avg flags ========== 1/4/3
    3:-17:-20 [: 27.8 > IF 1 ELSE 0 THEN ;] MAP

    \ ========== abs-humidity-avg ========== 4/21
    28:-1:-4 [: 100 /. ;] MAP

    \ ========== rainfall-rainy-days ========== 25/5/100
    15:-1:-4 norm_weekly
    16:-1:-4 norm_weekly
    17:-1:-4 norm_weekly
    18:-1:-4 norm_weekly
    19:-1:-4 norm_weekly
    
    15:-5:-8 norm_weekly
    16:-5:-8 norm_weekly
    17:-5:-8 norm_weekly
    18:-5:-8 norm_weekly
    19:-5:-8 norm_weekly
    
    15:-9:-12 norm_weekly
    16:-9:-12 norm_weekly
    17:-9:-12 norm_weekly
    18:-9:-12 norm_weekly
    19:-9:-12 norm_weekly
    
    20:0:-8 [: 6 > -> 1 | OTHERWISE 0 |. ;] MAP

    \ ========== rainfall-avg ========== 25/20
    9:-1:-4 log_trans MEAN
    10:-1:-4 log_trans MEAN
    11:-1:-4 log_trans MEAN
    12:-1:-4 log_trans MEAN
    13:-1:-4 log_trans MEAN
    
    9:-5:-8 log_trans MEAN
    10:-5:-8 log_trans MEAN
    11:-5:-8 log_trans MEAN
    12:-5:-8 log_trans MEAN
    13:-5:-8 log_trans MEAN
    
    9:-9:-12 log_trans MEAN
    10:-9:-12 log_trans MEAN
    11:-9:-12 log_trans MEAN
    12:-9:-12 log_trans MEAN
    13:-9:-12 log_trans MEAN
    
    9:-13:-16 log_trans MEAN
    10:-13:-16 log_trans MEAN
    11:-13:-16 log_trans MEAN
    12:-13:-16 log_trans MEAN
    13:-13:-16 log_trans MEAN
    
    9:-17:-20 log_trans MEAN
    10:-17:-20 log_trans MEAN
    11:-17:-20 log_trans MEAN
    12:-17:-20 log_trans MEAN
    13:-17:-20 log_trans MEAN

    \ ========== rainfall-avg flags ========== 5/2
    9:-13:-16 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.
    10:-13:-16 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.
    11:-13:-16 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.
    12:-13:-16 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.
    13:-13:-16 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.

    9:-9:-12 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE -1 |.
    10:-9:-12 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE -1 |.
    11:-9:-12 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE -1 |.
    12:-9:-12 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE -1 |.
    13:-9:-12 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE -1 |.

    \ ========== rainfall-consecutive-days ========== 25/5/100
    21:-1:-4 norm_weekly MEAN
    22:-1:-4 norm_weekly MEAN
    23:-1:-4 norm_weekly MEAN
    24:-1:-4 norm_weekly MEAN
    25:-1:-4 norm_weekly MEAN

    \ ========== hw-season ==========
    29:8:-6
;