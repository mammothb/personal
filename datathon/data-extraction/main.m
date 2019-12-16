\
\ @author: Arnold Doray
\ @date: 03 Dec 2019
\
\ Main program to run data extraction.
\

\ Your extraction script to run.  
include multicoldata.m
\ include data.m
\ include counts.m

\ Submits the job for processing. 
\ The script is defined in data.m
: data 
    job@ ['] script add
; 

\ Translates status code into human-readable text.
: code ( n -- "s" ) { n } 
    n 0 = -> "Job Queued" |
    n 1 = -> "Job Completed" | 
    n -1 = -> "Job Not Found" |
    n -2 = -> "Job Error\n" swap concat |.
; 

\ Returns true if a job completed without errors. 
: job-ok? ( -- f )
  job@ status 1 = 
; 

\ Displays the current status. 
: status
  "Status for" . job@ . ":" . 
  job@ status code . 
; 

\ Saves the results of the completed job to a file. 
: save-result  
  job-ok? not -> "Problem with job. Check status." . exit |. 
  result@ false open-writer { out }
  job@ get "" concat out print 
  out close 
; 

\ Stops the named job. 
: stop
  job@ rm 
; 
