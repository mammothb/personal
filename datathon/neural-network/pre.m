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

: get-gradient ( n n n -- n ) { mean sd n }
    mean sd 2 *. +. mean sd 2 *. -. -. n /.
; 

: transform
\     A:8:0 MEAN   \ dengue-sg-normalized
\     A:8          \ 8-week ahead forecast.
\     A:0:-8 MEAN  \ y0
    
    B:8:5 MEAN   \ dengue-sg-log
    B:8          \ 8-week ahead forecast.
    B:0:-8 MEAN  \ y0

    \ ========== temperature-avg ========== 4/16
    \ 3, 4, 5, 6, 7, 8
\     9:-5:-8 MEAN
\     9:-9:-12 MEAN
\     9:-13:-16 MEAN
\     9:-17:-20 MEAN
    9:-5:-8
    9:-9:-12
    9:-13:-16
    9:-17:-20
    
    \ ========== temperature-avg flags ========== 1
    9:-17:-20 MEAN 27.8 < IF 1 ELSE 0 THEN

    \ ========== temperature-max ==========
\     9, 10, 11, 12, 13, 14

    \ ========== temperature-min ==========
\     15, 16, 17, 18, 19, 20

    \ ========== rainfall-avg ========== 25
    24:-1:-4 MEAN
    25:-1:-4 MEAN
    26:-1:-4 MEAN
    27:-1:-4 MEAN
    28:-1:-4 MEAN

    24:-5:-8 MEAN
    25:-5:-8 MEAN
    26:-5:-8 MEAN
    27:-5:-8 MEAN
    28:-5:-8 MEAN

    24:-9:-12 MEAN
    25:-9:-12 MEAN
    26:-9:-12 MEAN
    27:-9:-12 MEAN
    28:-9:-12 MEAN

    24:-13:-16 MEAN
    25:-13:-16 MEAN
    26:-13:-16 MEAN
    27:-13:-16 MEAN
    28:-13:-16 MEAN

    24:-17:-20 MEAN
    25:-17:-20 MEAN
    26:-17:-20 MEAN
    27:-17:-20 MEAN
    28:-17:-20 MEAN

    \ ========== rainfall-avg flags ========== 5
    24:-13:-16 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.
    25:-13:-16 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.
    26:-13:-16 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.
    27:-13:-16 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.
    28:-13:-16 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.

\     21:-17:-20 MEAN 10.7 > IF 1 ELSE 0 THEN
\     22:-17:-20 MEAN 10.7 > IF 1 ELSE 0 THEN
\     23:-17:-20 MEAN 10.7 > IF 1 ELSE 0 THEN
\     24:-17:-20 MEAN 10.7 > IF 1 ELSE 0 THEN
\     25:-17:-20 MEAN 10.7 > IF 1 ELSE 0 THEN
    
\     29:-13:-16 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.
    
    \ ========== population-sg-normalized ========== 1
    2:-1:-20 MEAN
    
    \ ========== dengue-sg-log ========== 6
    B:-1:-6
\     B:-1:-6 MEAN B:-1:-6 SD 5 get-gradient B:-1:-6 MEAN B:-1:-3 MEAN -. 0 > IF 1 ELSE -1 THEN *.

    \ ========== rainfall-max ==========
\     26, 27, 28, 29, 30

    \ ========== rainfall-min ==========
\     31, 32, 33, 34, 35

    \ ========== rainfall-consecutive ========== 15
    42:-1:-4 MEAN
    43:-1:-4 MEAN
    44:-1:-4 MEAN
    45:-1:-4 MEAN
    46:-1:-4 MEAN

    42:-5:-8 MEAN
    43:-5:-8 MEAN
    44:-5:-8 MEAN
    45:-5:-8 MEAN
    46:-5:-8 MEAN

    42:-9:-12 MEAN
    43:-9:-12 MEAN
    44:-9:-12 MEAN
    45:-9:-12 MEAN
    46:-9:-12 MEAN
    
\     47:-1:-4 MEAN
\     47:-5:-8 MEAN
\     47:-9:-12 MEAN

    \ ========== absolute-humidity-avg ========== 4
\     43:-1:-4
\     43:-5:-8

    \ ========== temperature-sg-max/min-diff ========== 2
    49:-5:-20 0 ABOVE LENGTH
    50:-5:-20 0 ABOVE LENGTH
    
    52:-1:-4
\     52:-5:-8

    \ ========== temperature-sg-max ========== 4
\     16:-5:-8 MEAN
\     16:-9:-12 MEAN
\     16:-13:-16 MEAN
\     16:-17:-20 MEAN
    
    \ ========== temperature-sg-min ========== 4
\     23:-5:-8 MEAN
\     23:-9:-12 MEAN
\     23:-13:-16 MEAN
\     23:-17:-20 MEAN

    \ ========== relative-humidity-avg ==========
\     42
;


