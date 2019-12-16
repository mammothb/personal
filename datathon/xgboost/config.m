\
\ @author: Arnold Doray
\ @date: 13 Sep 2019
\
\ Sample config
\

"reg:squarederror" := objective
5 := max_depth
5 := num_round
{{ 0.1 0.3 0.6 1.0 }} := learning_rate

"dengue/train/xgb" := train-data
"dengue/test/xgb" := test-data

