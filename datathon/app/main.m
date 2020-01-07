\
\ @author: samuel
\ @date: 7 Dec 2019
\
\ Run model on arbitrary dataset
\


terra/ac
project: P001/lab-7

\ WARNING 1
\ Before running this script, make sure you have deployed the 
\ model first! 

\ WARNING 2 
\ Remember to use the pre.m you used for your model!!! 
\ This will change with models!!!
: data
    "deploy.csv" preprocess
\     "deploy-preprocessed.csv" "p001-dengue-deploy-data" csv>data
    "deploy-preprocessed.csv" "p001-dengue-deploy-data-02" csv>data
;







