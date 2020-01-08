\
\ @author: Arnold Doray
\ @date: 13 Sep 2019
\
\ Sample config.m
\

\ Sizes for the Neural Network
\ {{ 256 }} := nn-size
{{ 128 256 }} := nn-size

\ {{ 0.001 }} := lr
\ {{ 0.25 0.5 }} := gamma-value

\ The number of inputs 
\ You definitely need to amend this depending on 
\ the number of features you use.
{{ 142 146 }} := input-size
\ {{ 199 }} := input-size
\ {{ 203 207 211 215 219 223 }} := input-size
\ {{ 107 }} := input-size

\ Max iterations for solver. 
10000 := iters

\ Solver type. 
\ Adam is highly optimized for gradient descent. (default)
\ SGD is Stochasic Gradient Descent. (can be better in some cases) 
"Adam" := solver-type
10 repeats


