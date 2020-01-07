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

\ : map_sum ( seq -- n )
\     0 SWAP ['] +. REDUCE
\ ;

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
    A:8          \ 8-week ahead forecast.
\     A:0:-4 MEAN  \ y0
    A:0:-8 MEAN  \ y0
    
    \ ========== dengue-sg-log ========== 7/8
    A:0:-4
\     A:-5:-20
\     A:0:-6 A:0:-6 MEAN 7 get-gradient
    A:0:-4 A:0:-4 MEAN 5 get-gradient
    
    \ ========== population-sg-log ========== 1/20
\     1:-1:-20 MEAN
    1:0

    \ ========== temperature-avg ========== 4/16
\ \     2:-5:-8 MEAN
\ \     2:-9:-12 MEAN
\ \     2:-13:-16 MEAN
\ \     2:-17:-20 MEAN

\     2:-5:-8 norm_temperature MEAN
\     2:-9:-12 norm_temperature MEAN
\     2:-13:-16 norm_temperature MEAN
\     2:-17:-20 norm_temperature MEAN

\     2:-1:-4 norm_temperature MEAN
\     2:0 norm_temperature MEAN

    2:-5:-8 norm_temperature
    2:-9:-12 norm_temperature
    2:-13:-16 norm_temperature
    2:-17:-20 norm_temperature
    
    2:-1:-4 norm_temperature
    2:0 norm_temperature

    \ ========== temperature-avg flags ========== 1/4
\     2:-17:-20 [: DUP 27.8 > IF 27.8 -. ELSE DROP 0 THEN ;] MAP
    2:-17:-20 [: 27.8 > IF 1 ELSE 0 THEN ;] MAP

    \ ========== temperature-hot-days ========== 4/16
\     3:-5:-8 MEAN 7 /.
\     3:-9:-12 MEAN 7 /.
\     3:-13:-16 MEAN 7 /.
\     3:-17:-20 MEAN 7 /.

\     3:-5:-8 MEAN 7 /. 0.5 > IF 1 ELSE 0 THEN
\     3:-9:-12 MEAN 7 /. 0.5 > IF 1 ELSE 0 THEN
\     3:-13:-16 MEAN 7 /. 0.5 > IF 1 ELSE 0 THEN
\     3:-17:-20 MEAN 7 /. 0.5 > IF 1 ELSE 0 THEN

\     3:-5:-8 norm_weekly
\     3:-9:-12 norm_weekly
\     3:-13:-16 norm_weekly
\     3:-17:-20 norm_weekly

    3:-5:-8 norm_weekly MEAN
    3:-9:-12 norm_weekly MEAN
    3:-13:-16 norm_weekly MEAN
    3:-17:-20 norm_weekly MEAN
    
\     3:-1:-4 norm_weekly MEAN

\     \ ========== abs-humidity-avg ========== 4/21
\ \     23:-17:-20 [: 100 /. ;] MAP
\ \     23:-1:-4 [: 100 /. ;] MAP
\ \     23:-5:-16 [: 100 /. ;] MAP
    23:0:-8 [: 100 /. ;] MAP
    23:-9:-16 [: 100 /. ;] MAP

    \ ========== rainfall-rainy-days ========== 25/5/100
    10:-17:-20 MEAN 7 /.
    11:-17:-20 MEAN 7 /.
    12:-17:-20 MEAN 7 /.
    13:-17:-20 MEAN 7 /.
    14:-17:-20 MEAN 7 /.

    10:-13:-16 MEAN 7 /.
    11:-13:-16 MEAN 7 /.
    12:-13:-16 MEAN 7 /.
    13:-13:-16 MEAN 7 /.
    14:-13:-16 MEAN 7 /.

    10:-9:-12 MEAN 7 /.
    11:-9:-12 MEAN 7 /.
    12:-9:-12 MEAN 7 /.
    13:-9:-12 MEAN 7 /.
    14:-9:-12 MEAN 7 /.

    10:-5:-8 MEAN 7 /.
    11:-5:-8 MEAN 7 /.
    12:-5:-8 MEAN 7 /.
    13:-5:-8 MEAN 7 /.
    14:-5:-8 MEAN 7 /.

    10:-1:-4 MEAN 7 /.
    11:-1:-4 MEAN 7 /.
    12:-1:-4 MEAN 7 /.
    13:-1:-4 MEAN 7 /.
    14:-1:-4 MEAN 7 /.

\     15:-1:-4 MEAN 7 /.
\     15:-5:-8 MEAN 7 /.
\     15:-9:-12 MEAN 7 /.
\     15:-13:-16 MEAN 7 /.
\     15:-17:-20 MEAN 7 /.

\     10:-1:-20 [: 7 /. ;] MAP
\     11:-1:-20 [: 7 /. ;] MAP
\     12:-1:-20 [: 7 /. ;] MAP
\     13:-1:-20 [: 7 /. ;] MAP
\     14:-1:-20 [: 7 /. ;] MAP
    
\     10:0 MEAN 7 /.
\     11:0 MEAN 7 /.
\     12:0 MEAN 7 /.
\     13:0 MEAN 7 /.
\     14:0 MEAN 7 /.

    \ ========== rainfall-avg ========== 25/20
\     4:-1:-4 MEAN
\     5:-1:-4 MEAN
\     6:-1:-4 MEAN
\     7:-1:-4 MEAN
\     8:-1:-4 MEAN
\ 
\     4:-5:-8 MEAN
\     5:-5:-8 MEAN
\     6:-5:-8 MEAN
\     7:-5:-8 MEAN
\     8:-5:-8 MEAN
\ 
\     4:-9:-12 MEAN
\     5:-9:-12 MEAN
\     6:-9:-12 MEAN
\     7:-9:-12 MEAN
\     8:-9:-12 MEAN
\ 
\ \     4:-13:-16 MEAN
\ \     5:-13:-16 MEAN
\ \     6:-13:-16 MEAN
\ \     7:-13:-16 MEAN
\ \     8:-13:-16 MEAN
\ \ 
\ \     4:-17:-20 MEAN
\ \     5:-17:-20 MEAN
\ \     6:-17:-20 MEAN
\ \     7:-17:-20 MEAN
\ \     8:-17:-20 MEAN

\     4:-1:-4 [: 1 +. LN ;] MAP MEAN
\     5:-1:-4 [: 1 +. LN ;] MAP MEAN
\     6:-1:-4 [: 1 +. LN ;] MAP MEAN
\     7:-1:-4 [: 1 +. LN ;] MAP MEAN
\     8:-1:-4 [: 1 +. LN ;] MAP MEAN
\ 
\     4:-5:-8 [: 1 +. LN ;] MAP MEAN
\     5:-5:-8 [: 1 +. LN ;] MAP MEAN
\     6:-5:-8 [: 1 +. LN ;] MAP MEAN
\     7:-5:-8 [: 1 +. LN ;] MAP MEAN
\     8:-5:-8 [: 1 +. LN ;] MAP MEAN
\ 
\     4:-9:-12 [: 1 +. LN ;] MAP MEAN
\     5:-9:-12 [: 1 +. LN ;] MAP MEAN
\     6:-9:-12 [: 1 +. LN ;] MAP MEAN
\     7:-9:-12 [: 1 +. LN ;] MAP MEAN
\     8:-9:-12 [: 1 +. LN ;] MAP MEAN
\ 
\     4:-13:-16 [: 1 +. LN ;] MAP MEAN
\     5:-13:-16 [: 1 +. LN ;] MAP MEAN
\     6:-13:-16 [: 1 +. LN ;] MAP MEAN
\     7:-13:-16 [: 1 +. LN ;] MAP MEAN
\     8:-13:-16 [: 1 +. LN ;] MAP MEAN
\ 
\ \     4:-17:-20 [: 1 +. LN ;] MAP MEAN
\ \     5:-17:-20 [: 1 +. LN ;] MAP MEAN
\ \     6:-17:-20 [: 1 +. LN ;] MAP MEAN
\ \     7:-17:-20 [: 1 +. LN ;] MAP MEAN
\ \     8:-17:-20 [: 1 +. LN ;] MAP MEAN

    4:-1:-4 log_trans
    5:-1:-4 log_trans
    6:-1:-4 log_trans
    7:-1:-4 log_trans
    8:-1:-4 log_trans

    4:-5:-8 log_trans
    5:-5:-8 log_trans
    6:-5:-8 log_trans
    7:-5:-8 log_trans
    8:-5:-8 log_trans

\     4:-9:-12 [: 1 +. LN ;] MAP
\     5:-9:-12 [: 1 +. LN ;] MAP
\     6:-9:-12 [: 1 +. LN ;] MAP
\     7:-9:-12 [: 1 +. LN ;] MAP
\     8:-9:-12 [: 1 +. LN ;] MAP
\
\     4:-13:-16 [: 1 +. LN ;] MAP
\     5:-13:-16 [: 1 +. LN ;] MAP
\     6:-13:-16 [: 1 +. LN ;] MAP
\     7:-13:-16 [: 1 +. LN ;] MAP
\     8:-13:-16 [: 1 +. LN ;] MAP
\
\     4:-17:-20 [: 1 +. LN ;] MAP
\     5:-17:-20 [: 1 +. LN ;] MAP
\     6:-17:-20 [: 1 +. LN ;] MAP
\     7:-17:-20 [: 1 +. LN ;] MAP
\     8:-17:-20 [: 1 +. LN ;] MAP

    4:-9:-12 log_trans MEAN
    5:-9:-12 log_trans MEAN
    6:-9:-12 log_trans MEAN
    7:-9:-12 log_trans MEAN
    8:-9:-12 log_trans MEAN

    4:-13:-16 log_trans MEAN
    5:-13:-16 log_trans MEAN
    6:-13:-16 log_trans MEAN
    7:-13:-16 log_trans MEAN
    8:-13:-16 log_trans MEAN

\     9:-1:-4 log_trans
\     9:-5:-8 log_trans
\     9:-9:-12 log_trans
\     9:-13:-16 log_trans
\     9:-17:-20 log_trans

\     9:-1:-4 log_trans MEAN
\     9:-5:-8 log_trans MEAN
\     9:-9:-12 log_trans MEAN
\     9:-13:-16 log_trans MEAN
    9:-17:-20 log_trans MEAN

    \ ========== rainfall-avg flags ========== 5/2
    
    4:-13:-16 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.
    5:-13:-16 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.
    6:-13:-16 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.
    7:-13:-16 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.
    8:-13:-16 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.

    4:-9:-12 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE -1 |.
    5:-9:-12 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE -1 |.
    6:-9:-12 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE -1 |.
    7:-9:-12 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE -1 |.
    8:-9:-12 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE -1 |.

\     9:-13:-16 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.
\     9:-9:-12 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE -1 |.
\     9:-9:-12 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.
\     9:-5:-8 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE -1 |.
\ 
    \ ========== rainfall-consecutive-days ========== 25/5/100
\     16:-1:-4 MEAN 7 /.
\     17:-1:-4 MEAN 7 /.
\     18:-1:-4 MEAN 7 /.
\     19:-1:-4 MEAN 7 /.
\     20:-1:-4 MEAN 7 /.
\
\     16:-5:-8 MEAN 7 /.
\     17:-5:-8 MEAN 7 /.
\     18:-5:-8 MEAN 7 /.
\     19:-5:-8 MEAN 7 /.
\     20:-5:-8 MEAN 7 /.
\
\     16:-9:-12 MEAN 7 /.
\     17:-9:-12 MEAN 7 /.
\     18:-9:-12 MEAN 7 /.
\     19:-9:-12 MEAN 7 /.
\     20:-9:-12 MEAN 7 /.

    16:-1:-4 norm_weekly
    17:-1:-4 norm_weekly
    18:-1:-4 norm_weekly
    19:-1:-4 norm_weekly
    20:-1:-4 norm_weekly

    16:-5:-8 norm_weekly
    17:-5:-8 norm_weekly
    18:-5:-8 norm_weekly
    19:-5:-8 norm_weekly
    20:-5:-8 norm_weekly

    16:-9:-12 norm_weekly
    17:-9:-12 norm_weekly
    18:-9:-12 norm_weekly
    19:-9:-12 norm_weekly
    20:-9:-12 norm_weekly
    
    \ ========== temperature-sg-max ==========
    25:-17:-20 0 ABOVE LENGTH 4 /.
    25:-13:-16 0 ABOVE LENGTH 4 /.
\     25:-9:-12 0 ABOVE LENGTH 4 /.
\     25:-5:-8 0 ABOVE LENGTH 4 /.

    24:-17:-20 0 ABOVE LENGTH 4 /.
    24:-13:-16 0 ABOVE LENGTH 4 /.
\     24:-9:-12 0 ABOVE LENGTH 4 /.
\     24:-5:-8 0 ABOVE LENGTH 4 /.
;
