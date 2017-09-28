FileDataSourceInfo <- setClass(
  "FileDataSourceInfo",

  # Define the slots
  slots = c(
    path="character"
  ),

  prototype = list(
    path= NA_character_
  ),

  # validate the slots
  validity = function(object) {

    if (object@path == ""){
      return("If source type is File, you must provide a file path (path)")
    }

    return(TRUE)
  },

  # inherit class DataSourceInfo
  contains = "DataSourceInfo"

)
