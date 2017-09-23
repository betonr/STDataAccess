FileDataSourceInfo <- setClass(
  "FileDataSourceInfo",

  # Define the slots
  slots = c(
    path="character",
    type="character"
  ),

  prototype = list(
    path="",
    type=""
  )

)
