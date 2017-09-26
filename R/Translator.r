Translator <- setClass(
  "Translator",

  # Define the attributes
  slots = c(
    adapter = "Adapter",
    dataSetInfo = "DataSetInfo"
  )

)

# method getTrajectory
setGeneric (name="getTrajectory",
            def = function (object, layer, objectId) {
              standardGeneric("getTrajectory")
            }
)

setMethod (f = "getTrajectory", signature = "Translator",
           definition = function (object, layer, objectId) {

             #realiza o carregamento dos pacotes
             loadPackages();

             rawData = loadData(object@adapter, layer=layer)

             spatialColumn = object@dataSetInfo@spatialColumn
             timeColumn = object@dataSetInfo@timeColumn
             dataColumn = object@dataSetInfo@dataColumn
             objectIdColumn = object@dataSetInfo@objectIdColumn

             filteredData = rawData[rawData[[objectIdColumn]] == objectId,]
             if(length(filteredData) == 0){
               stop('object id not found');
             }

             #pegando o crs concatenado
             crs = CRS(filteredData@proj4string@projargs)

             #criando lista com as coordenas
             datxy <- data.frame(x=filteredData$coords.x1,y=filteredData$coords.x2)
             xy <- coordinates(datxy)

             spValues <- SpatialPoints(xy,crs)

             timeValues = xts( 1:length(spValues),as.POSIXct(filteredData[[timeColumn]]))

             IDs = paste("ID",1:length(spValues))
             dataValues = filteredData[[dataColumn]]
             dataValues = data.frame(values = dataValues, ID=IDs)

             stidf <- STIDF (spValues, timeValues, dataValues)

             track <- Track(stidf)

             return (track)
           }
)

# method getTrajectories
setGeneric (name="getTrajectories",
            def = function (object, layer, objectId) {
              standardGeneric("getTrajectories")
            }
)

setMethod (f = "getTrajectories", signature = "Translator",
           definition = function (object, layer) {

             #realiza o carregamento dos pacotes
             loadPackages();

             rawData = loadData(object@adapter, layer=layer)

             trackList <- list()
             tracksList <- list()

             if(length(rawData)>=1 && rawData!="Fail"){

             }

           }
)

# method getCoverage
setGeneric (name="getCoverage",
            def = function (object, layer, timeframe) {
              standardGeneric("getCoverage")
            }
)

setMethod (f = "getCoverage", signature = "Translator",
           definition = function (object, layer, timeframe) {

             #realiza o carregamento dos pacotes
             loadPackages();

             rawData = loadData(object@adapter, layer = layer)

             spatialColumn = object@dataSetInfo@spatialColumn
             timeColumn = object@dataSetInfo@timeColumn
             dataColumn = object@dataSetInfo@dataColumn

             filteredData = rawData[rawData[[timeColumn]] == timeframe,]

             spValues <- SpatialPoints(filteredData@coords)

             timeValues = xts( 1:length(spValues),as.POSIXct(filteredData[[timeColumn]]))

             IDs = paste("ID",1:length(spValues))
             dataValues = filteredData[[dataColumn]]
             dataValues = data.frame(values = dataValues, ID=IDs)

             stidf <- STIDF (spValues, timeValues, dataValues)

             return (stidf)
           }
)
