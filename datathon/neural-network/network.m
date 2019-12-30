\
\ @author: Arnold Doray
\ @date: 13 Sep 2019
\
\ Sample network
\

use timeseries

\ : perceptron ( n -- layer )
\     innerproduct relu
\ ; 
\ 
\ : perceptrons ( l seq -- layer )
\     ['] perceptron reduce
\ ; 

: shrink ( n -- n )
    2 * 3 /
; 

: double-layer-network ( l -- l )
  {{ 
     ${nn-size} 
     ${nn-size 2 /}
  }} perceptron
; 

: triple-layer-network ( l -- l )
    {{
        ${nn-size}
        ${nn-size} shrink
        ${nn-size} shrink shrink
    }} perceptron
; 

: quad-layer-network ( l -- l )
    {{
        ${nn-size}
        ${nn-size} shrink
        ${nn-size} shrink shrink
        ${nn-size} shrink shrink shrink
    }} perceptron
; 

: penta-layer-network ( l -- l )
    {{
        ${nn-size}
        ${nn-size} shrink
        ${nn-size} shrink shrink
        ${nn-size} shrink shrink shrink
        ${nn-size} shrink shrink shrink shrink
    }} perceptron
; 

: network ( l -- l )
    named temps 
        quad-layer-network
        1 innerproduct
    end-named
; 

: train ( -- l )
  4 5 ... ${input-size} take { input-indices }
  "dengue/train/nn" csv train
    input-indices := xs
    3 := y0
    1 := y
  "dengue/test/nn" csv test
    input-indices := xs
    3 := y0
    2 := y
    
   network '$y0 + 
   '$y euclidean >> loss
; 

: deploy ( -- ) 

  4 5 ... ${input-size} take { input-indices }
  "${deploy-source}" csv
    input-indices := xs
    3 := y0
    1 .batch_size
    false .load_once
 
  network '$y0 + >> prediction 

; 

: solver 
  %s solver_mode "CPU"
  %s max_iter ${iters}
  %s type "${solver-type}"
  %s early_stop 25 20
  %s base_lr 0.0003
  
\   %s early_stop 100 80
\   %s base_lr 0.001
  %s gamma 0.25
\   %s stepsize 100000
\   %s momentum 0.9
  %s momentum2 0.999
  %s delta 0.00000001
; 






