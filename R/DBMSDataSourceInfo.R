DBMSDataSourceInfo <- setClass(
  "DBMSDataSourceInfo",

  # Define the slots
  slots = c(
    host="character",
    port="numeric",
    user="character",
    password="character",
    dbname="character",
    encoding="character",
    dbtype="character"
  ),

  prototype=list(
    host="localhost",
    port=5432,
    user="",
    password="",
    dbname="",
    encoding="CP1252",
    type="postgis"
  )

)
