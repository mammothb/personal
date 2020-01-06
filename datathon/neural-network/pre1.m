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
    A:8:5 MEAN   \ dengue-sg-log
\     A:8:4 4 emw   \ dengue-sg-log
    A:8          \ 8-week ahead forecast.
\     A:0:-8 MEAN  \ y0
\     A:0:-4 4 emw   \ dengue-sg-log
    A:0  \ y0
    
    \ ========== dengue-sg-log ========== 6
    A:0:-4
    A:0:-4 A:0:-4 MEAN 5 get-gradient
\     A:-5:-20
\     A:0:-6 A:0:-6 MEAN 7 get-gradient
    
    \ ========== population-sg-log ========== 1
    2:0

    \ ========== temperature-avg ========== 4/16
\     3:-5:-8 MEAN
\     3:-9:-12 MEAN
\     3:-13:-16 MEAN
\     3:-17:-20 MEAN

    3:-5:-8 norm_temperature MEAN
    3:-9:-12 norm_temperature MEAN
    3:-13:-16 norm_temperature MEAN
    3:-17:-20 norm_temperature MEAN

    3:-1:-4 norm_temperature MEAN
    3:0 norm_temperature MEAN
    
\     3:-5:-8 norm_temperature
\     3:-9:-12 norm_temperature
\     3:-13:-16 norm_temperature
\     3:-17:-20 norm_temperature
\     
\     3:-1:-4 norm_temperature
\     3:0 norm_temperature

    \ ========== temperature-avg flags ========== 1/4/3
\     3:-17:-20 [: DUP 27.8 > IF 27.8 -. ELSE DROP 0 THEN ;] MAP
    3:-17:-20 [: 27.8 > IF 1 ELSE 0 THEN ;] MAP

    \ ========== temperature-hot-days ========== 4/16
\     4:-5:-8 MEAN 7 /. 0.5 > IF 1 ELSE 0 THEN
\     4:-9:-12 MEAN 7 /. 0.5 > IF 1 ELSE 0 THEN
\     4:-13:-16 MEAN 7 /. 0.5 > IF 1 ELSE 0 THEN
\     4:-17:-20 MEAN 7 /. 0.5 > IF 1 ELSE 0 THEN

\     4:-5:-8 norm_weekly
\     4:-9:-12 norm_weekly
\     4:-13:-16 norm_weekly
\     4:-17:-20 norm_weekly

    4:-5:-8 norm_weekly MEAN
    4:-9:-12 norm_weekly MEAN
    4:-13:-16 norm_weekly MEAN
    4:-17:-20 norm_weekly MEAN
    
\     4:-1:-4 norm_weekly MEAN

    \ ========== abs-humidity-avg ========== 4/21
    24:0:-8 [: 100 /. ;] MAP
    24:-9:-16 [: 100 /. ;] MAP

    \ ========== rainfall-rainy-days ========== 25/5/100
    11:-1:-4 norm_weekly MEAN
    12:-1:-4 norm_weekly MEAN
    13:-1:-4 norm_weekly MEAN
    14:-1:-4 norm_weekly MEAN
    15:-1:-4 norm_weekly MEAN
    
    11:-5:-8 norm_weekly MEAN
    12:-5:-8 norm_weekly MEAN
    13:-5:-8 norm_weekly MEAN
    14:-5:-8 norm_weekly MEAN
    15:-5:-8 norm_weekly MEAN

    11:-9:-12 norm_weekly MEAN
    12:-9:-12 norm_weekly MEAN
    13:-9:-12 norm_weekly MEAN
    14:-9:-12 norm_weekly MEAN
    15:-9:-12 norm_weekly MEAN

    11:-13:-16 norm_weekly MEAN
    12:-13:-16 norm_weekly MEAN
    13:-13:-16 norm_weekly MEAN
    14:-13:-16 norm_weekly MEAN
    15:-13:-16 norm_weekly MEAN

    11:-17:-20 norm_weekly MEAN
    12:-17:-20 norm_weekly MEAN
    13:-17:-20 norm_weekly MEAN
    14:-17:-20 norm_weekly MEAN
    15:-17:-20 norm_weekly MEAN
    
\     11:0 MEAN 7 /.
\     12:0 MEAN 7 /.
\     13:0 MEAN 7 /.
\     14:0 MEAN 7 /.
\     15:0 MEAN 7 /.

    \ ========== rainfall-avg ========== 25/20
\     5:-1:-4 MEAN
\     6:-1:-4 MEAN
\     7:-1:-4 MEAN
\     8:-1:-4 MEAN
\     9:-1:-4 MEAN
\ 
\     5:-5:-8 MEAN
\     6:-5:-8 MEAN
\     7:-5:-8 MEAN
\     8:-5:-8 MEAN
\     9:-5:-8 MEAN
\ 
\     5:-9:-12 MEAN
\     6:-9:-12 MEAN
\     7:-9:-12 MEAN
\     8:-9:-12 MEAN
\     9:-9:-12 MEAN
\ 
\ \     5:-13:-16 MEAN
\ \     6:-13:-16 MEAN
\ \     7:-13:-16 MEAN
\ \     8:-13:-16 MEAN
\ \     9:-13:-16 MEAN
\ \ 
\ \     5:-17:-20 MEAN
\ \     6:-17:-20 MEAN
\ \     7:-17:-20 MEAN
\ \     8:-17:-20 MEAN
\ \     9:-17:-20 MEAN

\     5:-1:-4 [: 1 +. LN ;] MAP MEAN
\     6:-1:-4 [: 1 +. LN ;] MAP MEAN
\     7:-1:-4 [: 1 +. LN ;] MAP MEAN
\     8:-1:-4 [: 1 +. LN ;] MAP MEAN
\     9:-1:-4 [: 1 +. LN ;] MAP MEAN
\ 
\     5:-5:-8 [: 1 +. LN ;] MAP MEAN
\     6:-5:-8 [: 1 +. LN ;] MAP MEAN
\     7:-5:-8 [: 1 +. LN ;] MAP MEAN
\     8:-5:-8 [: 1 +. LN ;] MAP MEAN
\     9:-5:-8 [: 1 +. LN ;] MAP MEAN
\ 
\     5:-9:-12 [: 1 +. LN ;] MAP MEAN
\     6:-9:-12 [: 1 +. LN ;] MAP MEAN
\     7:-9:-12 [: 1 +. LN ;] MAP MEAN
\     8:-9:-12 [: 1 +. LN ;] MAP MEAN
\     9:-9:-12 [: 1 +. LN ;] MAP MEAN
\ 
\     5:-13:-16 [: 1 +. LN ;] MAP MEAN
\     6:-13:-16 [: 1 +. LN ;] MAP MEAN
\     7:-13:-16 [: 1 +. LN ;] MAP MEAN
\     8:-13:-16 [: 1 +. LN ;] MAP MEAN
\     9:-13:-16 [: 1 +. LN ;] MAP MEAN
\ 
\ \     5:-17:-20 [: 1 +. LN ;] MAP MEAN
\ \     6:-17:-20 [: 1 +. LN ;] MAP MEAN
\ \     7:-17:-20 [: 1 +. LN ;] MAP MEAN
\ \     8:-17:-20 [: 1 +. LN ;] MAP MEAN
\ \     9:-17:-20 [: 1 +. LN ;] MAP MEAN

    5:-1:-4 log_trans
    6:-1:-4 log_trans
    7:-1:-4 log_trans
    8:-1:-4 log_trans
    9:-1:-4 log_trans

    5:-5:-8 log_trans
    6:-5:-8 log_trans
    7:-5:-8 log_trans
    8:-5:-8 log_trans
    9:-5:-8 log_trans

\     5:-9:-12 [: 1 +. LN ;] MAP
\     6:-9:-12 [: 1 +. LN ;] MAP
\     7:-9:-12 [: 1 +. LN ;] MAP
\     8:-9:-12 [: 1 +. LN ;] MAP
\     9:-9:-12 [: 1 +. LN ;] MAP
\
\     5:-13:-16 [: 1 +. LN ;] MAP
\     6:-13:-16 [: 1 +. LN ;] MAP
\     7:-13:-16 [: 1 +. LN ;] MAP
\     8:-13:-16 [: 1 +. LN ;] MAP
\     9:-13:-16 [: 1 +. LN ;] MAP
\
\     5:-17:-20 [: 1 +. LN ;] MAP
\     6:-17:-20 [: 1 +. LN ;] MAP
\     7:-17:-20 [: 1 +. LN ;] MAP
\     8:-17:-20 [: 1 +. LN ;] MAP
\     9:-17:-20 [: 1 +. LN ;] MAP

    5:-9:-12 log_trans MEAN
    6:-9:-12 log_trans MEAN
    7:-9:-12 log_trans MEAN
    8:-9:-12 log_trans MEAN
    9:-9:-12 log_trans MEAN

    5:-13:-16 log_trans MEAN
    6:-13:-16 log_trans MEAN
    7:-13:-16 log_trans MEAN
    8:-13:-16 log_trans MEAN
    9:-13:-16 log_trans MEAN

\     10:-1:-4 log_trans
\     10:-5:-8 log_trans
\     10:-9:-12 log_trans
\     10:-13:-16 log_trans
\     10:-17:-20 log_trans

\     10:-1:-4 log_trans MEAN
\     10:-5:-8 log_trans MEAN
\     10:-9:-12 log_trans MEAN
\     10:-13:-16 log_trans MEAN
    10:-17:-20 log_trans MEAN

    \ ========== rainfall-avg flags ========== 5/2
    5:-13:-16 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.
    6:-13:-16 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.
    7:-13:-16 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.
    8:-13:-16 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.
    9:-13:-16 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.

    5:-9:-12 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE -1 |.
    6:-9:-12 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE -1 |.
    7:-9:-12 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE -1 |.
    8:-9:-12 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE -1 |.
    9:-9:-12 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE -1 |.

\     10:-13:-16 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.
\     10:-9:-12 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE -1 |.
\     10:-9:-12 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.
\     10:-5:-8 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE -1 |.
\ 
    \ ========== rainfall-consecutive-days ========== 25/5/100
\     17:-1:-4 MEAN 7 /.
\     18:-1:-4 MEAN 7 /.
\     19:-1:-4 MEAN 7 /.
\     20:-1:-4 MEAN 7 /.
\     21:-1:-4 MEAN 7 /.
\
\     17:-5:-8 MEAN 7 /.
\     18:-5:-8 MEAN 7 /.
\     19:-5:-8 MEAN 7 /.
\     20:-5:-8 MEAN 7 /.
\     21:-5:-8 MEAN 7 /.
\
\     17:-9:-12 MEAN 7 /.
\     18:-9:-12 MEAN 7 /.
\     19:-9:-12 MEAN 7 /.
\     20:-9:-12 MEAN 7 /.
\     21:-9:-12 MEAN 7 /.

    17:-1:-4 norm_weekly
    18:-1:-4 norm_weekly
    19:-1:-4 norm_weekly
    20:-1:-4 norm_weekly
    21:-1:-4 norm_weekly

    17:-5:-8 norm_weekly
    18:-5:-8 norm_weekly
    19:-5:-8 norm_weekly
    20:-5:-8 norm_weekly
    21:-5:-8 norm_weekly

    17:-9:-12 norm_weekly
    18:-9:-12 norm_weekly
    19:-9:-12 norm_weekly
    20:-9:-12 norm_weekly
    21:-9:-12 norm_weekly
    
    22:-13:-16 3.5 ABOVE LENGTH

    \ ========== hw-season ==========
    27:0:-8

    \ ========== hw-trend ==========
    28:0:-8
    
\     \ ========== temperature-sg-max ==========
\     26:-17:-20 0 ABOVE LENGTH 4 /.
\     26:-13:-16 0 ABOVE LENGTH 4 /.
\ \     26:-9:-12 0 ABOVE LENGTH 4 /.
\ \     26:-5:-8 0 ABOVE LENGTH 4 /.
\ 
\     25:-17:-20 0 ABOVE LENGTH 4 /.
\     25:-13:-16 0 ABOVE LENGTH 4 /.
\ \     25:-9:-12 0 ABOVE LENGTH 4 /.
\ \     25:-5:-8 0 ABOVE LENGTH 4 /.

\     4:-1:-4 norm_weekly MEAN

\     17:-13:-16 3.5 ABOVE LENGTH
\     18:-13:-16 3.5 ABOVE LENGTH
\     19:-13:-16 3.5 ABOVE LENGTH
\     20:-13:-16 3.5 ABOVE LENGTH
\     21:-13:-16 3.5 ABOVE LENGTH
\ 
\     17:-17:-20 3.5 ABOVE LENGTH
\     18:-17:-20 3.5 ABOVE LENGTH
\     19:-17:-20 3.5 ABOVE LENGTH
\     20:-17:-20 3.5 ABOVE LENGTH
\     21:-17:-20 3.5 ABOVE LENGTH
;
