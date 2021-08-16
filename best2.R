Best2 <- function(state, outcome) {
        ## Read outcome data
        
        csv<-read.csv("C:/Users/USER/Desktop/hospital/outcome-of-care-measures.csv"
                       ,header = TRUE,
                      stringsAsFactors = FALSE,sep = ",")        
        ## Check that state and outcome are valid
        
        if (!(state %in% csv$State)) {
                result <- "invalid state"
        }
        else if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
                result <- "invalid outcome"
        }
        else{
                keys <- c("heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)
                outcomeKey <- keys[outcome]
                
                ## Return hospital name in that state with lowest 30-day death rate
                
                dataPerState <- split(csv, csv$State)
                dataOurState <- dataPerState[[state]]
                sorted_State <- dataOurState[ order(dataOurState["Hospital.Name"]), ]
                dataOutcome <- suppressWarnings(as.numeric(sorted_State[, outcomeKey]))
                good <- complete.cases(dataOutcome)
                dataOutcome <- dataOutcome[good]
                dataOurState <- sorted_State[good,]
                minimum <- min(dataOutcome)
                index <- match(minimum, dataOutcome)
                result <- dataOurState[index, 2]
        }
        result
}
