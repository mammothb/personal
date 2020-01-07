\
\ @author: Arnold Doray
\ @date: 13 Dec 2019
\
\ A brief description of this program.
\

terra/ac/deploy
terra/apps

include styles.m

: to-csv ( # -- "s" ) { h } 
  "x,y\n" h #keys [: { k } 
     k concat "," concat k h #@ concat "\n" concat  
  ;] reduce 
; 

\ retrieves a hash of predictions. 
: get-predictions ( "s" "s" -- # ) { model database }
  \  <username for model> <model name> <username for dataset> <dataset name> predict
  \ WARNING: Change to your own usernames. 
\   "liyier90" "p001-xgb" "liyier90" "p001-dengue-deploy-data" predict
    "liyier90" model "liyier90" database predict
; 

\ Creates a prediction data link 
: get-predictions-01 ( -- )
   \internal
   "convergence-nn" "p001-dengue-deploy-data" get-predictions to-csv .
; \text 

\ Creates a prediction data link 
: get-predictions-02 ( -- )
   \internal
   "convergence-nn-02" "p001-dengue-deploy-data-02" get-predictions to-csv .
; \text

: dengue-graph ( "s" -- widget ) { model }
    \\ graph/aspect 0.6
    \\ graph/width 50%
    model graph \ needs data in CSV format through a link. 
        {{ "x" "y" }} series!
        "green" fill!
        "green" stroke!
; 

: common
    {{
        "Home" "dengue" link
        "Predictions" "predictions" link
    }} header fixed
    {{
        "IoT Datathon 3.0"
        " "
        " "
        "Team: Convergence"
    }} footer fixed
; 

: model-selector >> predictions
    \\ dash/spacing 20px
    {{
        "Model 1" button submit #model1
        "Model 2" button submit #model2
    }} dash
;

\ Your dengue App. 
: dengue
    common
    {{
        "Dengue Forecasting"
        "A neural network based dengue forecast system" label
    }} splash
; \html 

: predictions
    "get-predictions-01" VAR prediction-index
    common
    @model1? -> "get-predictions-01" prediction-index! |
    @model2? -> "get-predictions-02" prediction-index! |.
    
    {{
        model-selector
        "Forecast:"
        prediction-index@ dengue-graph
    }} splash
    
; \html





