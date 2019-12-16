\
\ @author: Arnold Doray
\ @date: 13 Sep 2019
\
\ Sample config.m
\

\ Sizes for the Neural Network
{{ 32 128 512 1024 }} := nn-size

\ The number of inputs 
\ You definitely need to amend this depending on 
\ the number of features you use.
30 := input-size

\ Max iterations for solver. 
10000 := iters

\ Solver type. 
\ Adam is highly optimized for gradient descent. (default)
\ SGD is Stochasic Gradient Descent. (can be better in some cases) 
"Adam" := solver-type

5 repeats

