DataSourceInfo <- setClass(

  # Set the name for the class
  "DataSourceInfo",

  # Define the attributes
  slots = c(
    type = "character"
  ),

  validity = function(object) {

    if (object@type == ""){
      return("If source type is file type, you must provide the file type (e.g. kml)")
    }

    return(TRUE)
  }
)
