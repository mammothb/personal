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
    A:8:0 MEAN
    A:8          \ 8-week ahead forecast.
    A:0:-8 MEAN  \ y0 

    2:0:-8 MEAN
    3:0:-8 MEAN
    4:0:-8 MEAN
    5:0:-8 MEAN
    6:0:-8 MEAN
    7:0:-8 MEAN
    8:0:-8 MEAN
    9:0:-8 MEAN
    10:0:-8 MEAN
    11:0:-8 MEAN
    12:0:-8 MEAN
    13:0:-8 MEAN
    14:0:-8 MEAN
    15:0:-8 MEAN
    16:0:-8 MEAN
    17:0:-8 MEAN
    18:0:-8 MEAN
    19:0:-8 MEAN
    20:0:-8 MEAN
    21:0:-8 MEAN
    22:0:-8 MEAN
    23:0:-8 MEAN
    24:0:-8 MEAN
    25:0:-8 MEAN
    26:0:-8 MEAN
    27:0:-8 MEAN
    28:0:-8 MEAN
    29:0:-8 MEAN
    30:0:-8 MEAN
    31:0:-8 MEAN
;