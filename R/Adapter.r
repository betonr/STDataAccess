Adapter <- setClass(
  "Adapter",
  slots = c(dataSourceInfo = "DataSourceInfo"),
  contains = c("KmlAdapter", "PostgisAdapter")
)

# method setDataSourceInfo
setGeneric (name="setDataSourceInfo",
            def = function (object, dataSourceInfo) {
              standardGeneric("setDataSourceInfo")
            }
)

setMethod (f = "setDataSourceInfo", signature = "Adapter",
           definition = function (object, dataSourceInfo) {
             object@dataSourceInfo <- dataSourceInfo
             validObject(object)
             validObject(object@dataSourceInfo)
             return(object)
           }
)

#method loadData
setGeneric (name = "loadData",
            def = function(object, layer) {
              standardGeneric("loadData")
            }
)

setMethod(f = "loadData", signature = "Adapter",
          definition = function(object, layer) {

            object_class = class(object@dataSourceInfo)

            if (object_class[1] == "FileDataSourceInfo"
                && object@dataSourceInfo@type == "kml"){
              return (loadKmlData(object, layer))
            }

            if (object_class[1] == "DBMSDataSourceInfo"
                && object@dataSourceInfo@type == "postgis"){
              return(loadPostgisData(object))
            }
          }
)
