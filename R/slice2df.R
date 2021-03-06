#' Retreiving Population Distribution at Given Time
#' @export
#' @description Summarises the Input Data Frame by Area and an Optional Grouping Variable
#' @usage slice2df(x, var1, var2)
#'        
#' @param x a data.frame object
#' @param var1 a character vector of length 1, indicating the name of the column 
#'           in 'x' that contains area codes or names. This argument must be 
#'           provided.
#' @param var2 an optional character vector of length 1, indicating the name of a
#'           grouping variable
#' @return A data.frame that is suitable for the functions in the seg package
#' @details The result of the slice function shows where people exist at a given 
#' time in the form of \code{data.frame}, and each person is displayed in one row. 
#' \code{slice2df} is used when you want to aggregate these results the way you want.
#'
#' Specifically, \code{slice2df} is a function indicating how many people exist 
#' for each space unit through \code{x} given as a result of the \code{slice} 
#' function, and additional classification can be performed by demographic 
#' characteristics through \code{var2}.
#'
#' In other words, the result of \code{slice2df} is \code{data.frame} indicating 
#' how many populations exist in each area at a specific time, and this is 
#' a form that can be used directly in a function that measures spatial 
#' segregation inside a \code{seg} package.
#' 
#' However, \code{slice2df} should be noted that when the spatial unit of the 
#' data of the initially given \code{ASpace} class is measured in points or very 
#' small spatial unit, the number of all regions may appear as one.
#' @author Seong-Yun Hong (syhong@khu.ac.kr)
#' @examples
#' # load data
#' data(slicedata)
#' 
#' # run slice function to create suitable data.frame
#' result1 <- slice(slicedata, at = 800)
#' result2 <- slice(slicedata, at = 1400)
#' result3 <- slice(slicedata, at = 2000)
#' 
#' # converting the result
#' slice2df(result1, "location")
#' slice2df(result2, "location")
#' slice2df(result3, "location")
#' 
#' @seealso seg, dissim                     
slice2df <- function(x, var1, var2) {
  Area <- x[,var1]
  
  # ----------------------------------------------------------------------------
  # If there are no optional grouping variables:
  # ----------------------------------------------------------------------------
  if (missing(var2)) {
    output <- data.frame(table(Area))
    names(output) <- c("Area", "count")
  } 
  
  # ----------------------------------------------------------------------------
  # If there is an optional grouping variable:
  # ----------------------------------------------------------------------------
  else {
    by <- x[,var2]
    tmp.tb <- table(Area, by)
    tmp.df <- data.frame(rbind(tmp.tb))
    colnames(tmp.df) <- colnames(tmp.tb)
    
    output <- cbind(Area = rownames(tmp.df), tmp.df)
    rownames(output) <- 1:nrow(output)
  }
  
  return(output)
}

