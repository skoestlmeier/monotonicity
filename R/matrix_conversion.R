# converting input data into matrix

matrix_conversion <- function(data) {

      if(is(data,"matrix")){

        return(data)

      }else if(is(data,"data.frame")){

        data <- as.matrix(data)
        return(data)

      }else if(is(data,"ts")){

        return(data)

      }else if(is(data,"xts")){

        return(data)

      }else if(is(data,"zoo")){

        return(data)

      }else{
        stop("Cannot convert input data to class 'matrix'")

      }


}
