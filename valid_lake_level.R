## Author:Yanan Wu
## Date: 7/14/2018

Filte_Valid_data <- function(y){
  tryCatch ({
    total <- list.files(pattern = ".csv")
    df <- read.csv(total[1], stringsAsFactors = F)
    data_length <- c()
    data_list <- df[,y]
    
    yanan <-  colnames(df)[y]
    m <- gregexpr('[0-9]+',yanan)
    result <- regmatches(yanan,m)
    ID <- result[[1]][1]
    
    NA_index <- c(1:length(data_list))[is.na(data_list)]
    NA_index
    o <- 1
    list1 <- c()
    ## for the data do not have NA
    switch(length(NA_index)+1,
           {
             list1[[o]] <- c("start:", 2, "end:", length(data_list)) 
             list1[[o+1]] <- data_list[2:length(data_list)]
           }
           # ,
           # {
           #   list1[[o]] <- c("start:", 3, "end:", length(data_list))  
           #   list1[[o+1]] <- data_list[3:length(data_list)]
           
           
    )
    ## only have one NA
    length_na <- length(NA_index) + 1 
    if(length_na == 2)
    {
      if(NA_index[1] >= 21)
      {
        list1[[o]] <- c("start:", 2, "end:", NA_index[1] - 1)
        data2 <- data_list[2:(NA_index[1] - 1)]
        list1[[o+1]] <- data2
        list1[[o+2]] <- c("start:", NA_index[1] + 1, "end:", 169)
        data3 <- data_list[NA_index[1] + 1:169]
        list1[[o+1]] <- data3
      }else{
        list1[[o]] <- c("start:", NA_index[1] + 1, "end:", length(data_list))  
        list1[[o+1]] <- data_list[(NA_index[1] + 1):length(data_list)]
      }
    }
    data_list[169]
    ## Have many NA, and first NA located after 20 
    if((length(NA_index) > 1) & (NA_index[1] >= 19))
    { 
      #print(c(y, NA_index))
      start <- 2
      end <- NA_index[1] - 1
      a <- c('start:',start,'end:',end)
      data2 <-  data_list[start:end]
      list1[[o]] <- a
      list1[[o+1]] <- data2
      o <- o + 2
      for (i in 1:(length(NA_index)-1))
      {
        minus <- NA_index[i+1] - NA_index[i]
        if (abs(minus) >= 19)
        {
          start <- NA_index[i] + 1
          end <- NA_index[i+1] - 1
          a <- c('start:',start,'end:',end)
          data2 <-  data_list[start:end]
          list1[[o]] <- a
          list1[[o+1]] <- data2
          o <- o+2
        }
      }
      if(NA_index[length(NA_index)] <= 152)
      {
        start <- NA_index[length(NA_index)] + 1
        end <- 169
        a <- c('start:',NA_index[length(NA_index)] + 1,'end:',169)
        data2 <-  data_list[start:end]
        list1[[o]] <- a
        list1[[o+1]] <- data2
        o <- o+2
      }
    }
    
    ##no valid value before NA
    if((length(NA_index)>1) & NA_index[1] < 18)
    { 
      for (i in 1:(length(NA_index)-1))
      {
        minus <- NA_index[i+1] - NA_index[i]
        if (abs(minus) >= 19)
        {
          start <- NA_index[i] + 1
          end <- NA_index[i+1] - 1
          a <- c('start:',start,'end:',end)
          data2 <-  data_list[start:end]
          list1[[o]] <- a
          list1[[o+1]] <- data2
          o <- o+2
        }
      }
    }
    
    for(j in 1:length(list1))
      if(j %% 2 )
      {
        data_length <- c(data_length,as.numeric(list1[[j]][2]),as.numeric(list1[[j]][4]))
      } 
    return(c(length(data_length),data_length,list1,ID))
  },expr = e)
}

