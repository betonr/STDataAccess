DataSetInfo <- setClass(
  "DataSetInfo",

  # Define the slots
  slots = c(
    spatialColumn="character",
    timeColumn="character",
    dataColumn="character",
    objectIdColumn="character"
  ),

  prototype=list(
    host="geom",
    port="",
    user="",
    password=""
  )

)
