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

: transform
      
    \ You need to add your features here. 
    \ The example below just extracts mean and sd
    \ as 2 features. 
    
\     A:8:0 MEAN   \ dengue-sg-normalized
\     A:8          \ 8-week ahead forecast.
\     A:0:-8 MEAN  \ y0
    
    B:8:0 MEAN   \ dengue-sg-log
    B:8          \ 8-week ahead forecast.
    B:0:-8 MEAN  \ y0

\     B:-4:-12 MEAN  \ y0

    \ ========== population-sg-normalized ==========
    2:0:-8 MEAN

    \ ========== temperature-avg ==========
\     3:0:-8 MEAN
\     4:0:-8 MEAN
\     5:0:-8 MEAN
\     6:0:-8 MEAN
\ \     7:0:-8 MEAN
\     8:0:-8 MEAN

    3:-5:-8 MEAN
    4:-5:-8 MEAN
    5:-5:-8 MEAN
    6:-5:-8 MEAN
    8:-5:-8 MEAN
    
    3:-9:-12 MEAN
    4:-9:-12 MEAN
    5:-9:-12 MEAN
    6:-9:-12 MEAN
    8:-9:-12 MEAN
    
    3:-13:-16 MEAN
    4:-13:-16 MEAN
    5:-13:-16 MEAN
    6:-13:-16 MEAN
    8:-13:-16 MEAN
    
    3:-17:-20 MEAN
    4:-17:-20 MEAN
    5:-17:-20 MEAN
    6:-17:-20 MEAN
    8:-17:-20 MEAN
    
    3:-17:-20 MEAN 27.8 < IF 1 ELSE 0 THEN
    4:-17:-20 MEAN 27.8 < IF 1 ELSE 0 THEN
    5:-17:-20 MEAN 27.8 < IF 1 ELSE 0 THEN
    6:-17:-20 MEAN 27.8 < IF 1 ELSE 0 THEN
    8:-17:-20 MEAN 27.8 < IF 1 ELSE 0 THEN

\     3:-8:-32 MEAN
\     4:-8:-32 MEAN
\     5:-8:-32 MEAN
\     6:-8:-32 MEAN
\ \     7:-8:-32 MEAN
\     8:-8:-32 MEAN

    \ ========== temperature-max ==========
\     9:0:-8 MEAN
\     10:0:-8 MEAN
\     11:0:-8 MEAN
\     12:0:-8 MEAN
\ \     13:0:-8 MEAN
\     14:0:-8 MEAN

    \ ========== temperature-min ==========
\     15:0:-8 MEAN
\     16:0:-8 MEAN
\     17:0:-8 MEAN
\     18:0:-8 MEAN
\ \     19:0:-8 MEAN
\     20:0:-8 MEAN

    \ ========== rainfall-avg ==========
\     21:0:-8 MEAN
\     22:0:-8 MEAN
\     23:0:-8 MEAN
\     24:0:-8 MEAN
\     25:0:-8 MEAN

    21:-1:-4 MEAN
    22:-1:-4 MEAN
    23:-1:-4 MEAN
    24:-1:-4 MEAN
    25:-1:-4 MEAN
    
    21:-5:-8 MEAN
    22:-5:-8 MEAN
    23:-5:-8 MEAN
    24:-5:-8 MEAN
    25:-5:-8 MEAN

    21:-9:-12 MEAN
    22:-9:-12 MEAN
    23:-9:-12 MEAN
    24:-9:-12 MEAN
    25:-9:-12 MEAN
    
    21:-13:-16 MEAN
    22:-13:-16 MEAN
    23:-13:-16 MEAN
    24:-13:-16 MEAN
    25:-13:-16 MEAN
    
    21:-17:-20 MEAN
    22:-17:-20 MEAN
    23:-17:-20 MEAN
    24:-17:-20 MEAN
    25:-17:-20 MEAN

\     21:-13:-16 MEAN 21.4 > IF 1 ELSE 0 THEN
\     22:-13:-16 MEAN 21.4 > IF 1 ELSE 0 THEN
\     23:-13:-16 MEAN 21.4 > IF 1 ELSE 0 THEN
\     24:-13:-16 MEAN 21.4 > IF 1 ELSE 0 THEN
\     25:-13:-16 MEAN 21.4 > IF 1 ELSE 0 THEN
    
    21:-13:-16 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.
    22:-13:-16 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.
    23:-13:-16 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.
    24:-13:-16 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.
    25:-13:-16 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.
    
    21:-9:-12 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.
    22:-9:-12 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.
    23:-9:-12 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.
    24:-9:-12 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.
    25:-9:-12 MEAN DUP 10.7 < -> DROP 1 | 21.4 > -> 1 | OTHERWISE 0 |.
    
    21:-5:-8 MEAN 10.7 < IF 1 ELSE 0 THEN
    22:-5:-8 MEAN 10.7 < IF 1 ELSE 0 THEN
    23:-5:-8 MEAN 10.7 < IF 1 ELSE 0 THEN
    24:-5:-8 MEAN 10.7 < IF 1 ELSE 0 THEN
    25:-5:-8 MEAN 10.7 < IF 1 ELSE 0 THEN

\     21:-17:-20 MEAN 21.4 > IF 1 ELSE 0 THEN
\     22:-17:-20 MEAN 21.4 > IF 1 ELSE 0 THEN
\     23:-17:-20 MEAN 21.4 > IF 1 ELSE 0 THEN
\     24:-17:-20 MEAN 21.4 > IF 1 ELSE 0 THEN
\     25:-17:-20 MEAN 21.4 > IF 1 ELSE 0 THEN
    
\     21:-5:-8 MEAN 10.7 < IF 1 ELSE 0 THEN
\     22:-5:-8 MEAN 10.7 < IF 1 ELSE 0 THEN
\     23:-5:-8 MEAN 10.7 < IF 1 ELSE 0 THEN
\     24:-5:-8 MEAN 10.7 < IF 1 ELSE 0 THEN
\     25:-5:-8 MEAN 10.7 < IF 1 ELSE 0 THEN
\ 
\     21:-9:-12 MEAN 10.7 < IF 1 ELSE 0 THEN
\     22:-9:-12 MEAN 10.7 < IF 1 ELSE 0 THEN
\     23:-9:-12 MEAN 10.7 < IF 1 ELSE 0 THEN
\     24:-9:-12 MEAN 10.7 < IF 1 ELSE 0 THEN
\     25:-9:-12 MEAN 10.7 < IF 1 ELSE 0 THEN

\     21:-8:-28 MEAN
\     22:-8:-28 MEAN
\     23:-8:-28 MEAN
\     24:-8:-28 MEAN
\     25:-8:-28 MEAN

    \ ========== rainfall-max ==========
\     26:0:-8 MEAN
\     27:0:-8 MEAN
\     28:0:-8 MEAN
\     29:0:-8 MEAN
\     30:0:-8 MEAN

    \ ========== rainfall-min ==========
\     31:0:-8 MEAN
\     32:0:-8 MEAN
\     33:0:-8 MEAN
\     34:0:-8 MEAN
\     35:0:-8 MEAN

    \ ========== rainfall-consecutive ==========
\     36:0:-8 MEAN
\     37:0:-8 MEAN
\     38:0:-8 MEAN
\     39:0:-8 MEAN
\     40:0:-8 MEAN
\     36:-8:-28 MEAN
\     37:-8:-28 MEAN
\     38:-8:-28 MEAN
\     39:-8:-28 MEAN
\     40:-8:-28 MEAN

\     36:-13:-16 MEAN
\     37:-13:-16 MEAN
\     38:-13:-16 MEAN
\     39:-13:-16 MEAN
\     40:-13:-16 MEAN
    
\     36:-17:-20 MEAN
\     37:-17:-20 MEAN
\     38:-17:-20 MEAN
\     39:-17:-20 MEAN
\     40:-17:-20 MEAN
;



