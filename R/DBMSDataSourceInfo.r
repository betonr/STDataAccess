DBMSDataSourceInfo <- setClass(
  "DBMSDataSourceInfo",

  # Define the slots
  slots = c(
    host="character",
    port="numeric",
    username="character",
    password="character",
    dbname="character",
    encoding="character"
  ),

  prototype=list(
    host="localhost",
    port=5432,
    username= NA_character_,
    password= NA_character_,
    dbname= NA_character_,
    encoding="CP1252",
    type="postgis"
  ),

  # validate the slots
  validity = function(object) {

    if (object@dbname == ""){
      return("If source type is DBMS, you must provide a database name (dbname)")
    }
    if (object@username == ""){
      return("If source type is DBMS, you must provide a database username (username)")
    }
    if (object@password == ""){
      return("If source type is DBMS, you must provide a database password (password)")
    }

    return(TRUE)
  },

  # inherit class DataSourceInfo
  contains = "DataSourceInfo"

)
