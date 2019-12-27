\
\ @author: Arnold Doray
\ @date: 13 Sep 2019
\
\ Sample config.m
\

\ Sizes for the Neural Network
{{ 64 128 }} := nn-size

\ The number of inputs 
\ You definitely need to amend this depending on 
\ the number of features you use.
{{ 81 85 }} := input-size
\ {{ 77 78 79 80 81 }} := input-size
\ {{ 77 79 81 83 85 87 }} := input-size

\ Max iterations for solver. 
10000 := iters

\ Solver type. 
\ Adam is highly optimized for gradient descent. (default)
\ SGD is Stochasic Gradient Descent. (can be better in some cases) 
"Adam" := solver-type

20 repeats



