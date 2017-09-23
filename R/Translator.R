setGeneric(name = "Translator",
           def = function(datasourceinfo, datasetinfo){
             standardGeneric("Translator")
           }
)

setMethod(f="Translator",
          signature = c("DBMSDataSourceInfo","DataSetInfo"),
          definition = function(datasourceinfo, datasetinfo){

            return(data.frame(datasourceinfo,datasetinfo))
          })

setMethod(f="Translator",
          signature = c("FileDataSourceInfo","DataSetInfo"),
          definition = function(datasourceinfo, datasetinfo){

            return(data.frame(datasourceinfo,datasetinfo))
          })

