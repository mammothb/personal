\
\ @author: Arnold Doray
\ @date: 13 Sep 2019
\
\ Sample config.m
\

\ Sizes for the Neural Network
{{ 32 64 128 }} := nn-size

\ The number of inputs 
\ You definitely need to amend this depending on 
\ the number of features you use.
{{ 56 61 66 }} := input-size

\ Max iterations for solver. 
10000 := iters

\ Solver type. 
\ Adam is highly optimized for gradient descent. (default)
\ SGD is Stochasic Gradient Descent. (can be better in some cases) 
"Adam" := solver-type

10 repeats


