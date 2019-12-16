\
\ @author: Arnold Doray
\ @date: 13 Sep 2019
\
\ Main for XGB
\

terra/ac
project: P001-lab3
alg: xgb

\ Step 1: preprocess raw inputs using configuration from
\         pre.m and saves to <filename>-preprocessed.csv
\         Edit pre.m to add other features you wish to include.
\ Syntax: <filename> preprocess
\
\         csv>data -- saves the preprocessed train & test
\         data files onto Autocaffe Server.
\ Syntax: <file to save> <filename on server> csv>data
: data
    \ you need to create train.csv and test.csv
    \ using data access!
    "test.csv" preprocess
    "train.csv" preprocess
    "train-preprocessed.csv" "dengue/train/xgb" csv>data
    "test-preprocessed.csv" "dengue/test/xgb" csv>data
;

\ Step 2: train -- cleans up old models and 
\         trains the new networks.

\ Step 3: losses -- examine the training & test losses for 
\         this network. Also includes a plot of 
\         Train & Test losses.
\ Syntax for TRAIN-LOSS : <config#> train-loss 
\ Syntax for TEST-LOSS  : <config#> test-loss
\ Syntax for PLOT-LOSSES : <config-start#> <config-end#> plot-losses
: losses
\     best-config@ train-loss . cr
\     best-config@ test-loss  . cr
    1 nconfigs plot-losses cr
    all-config
;

\ Step 4: Evaluate -- select configs to run evaluation on.
\         Expands configurations in config-eval.m
: evaluate
    {{ best-config@ }} evaluate ;

\ Step 5: Predictions
\ To get prediction values: <config#> <eval#> eval-outputs
: plot-predictions
    best-config@ { n }
    n plot-train-predictions cr
    n plot-test-predictions cr
\     n plot-train-scatter cr
\     n plot-test-scatter cr
;

\ <model name> <config#> deploy-model
\ Eg. "my-model" 1 deploy-model
: deploy-model 
  "p001-xgb" best-config@ deploy-model
;

