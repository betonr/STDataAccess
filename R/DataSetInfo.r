DataSetInfo <- setClass(
  # Set the name for the class
  "DataSetInfo",

  # Define the slots
  slots = c(
    spatialColumn="character",
    timeColumn="character",
    dataColumn="character",
    objectIdColumn="character"
  ),

  prototype=list(
    spatialColumn="geom",
    timeColumn="",
    dataColumn="",
    objectIdColumn=""
  )

)
