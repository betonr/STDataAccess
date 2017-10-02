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
            def = function (object, layer, objectId, trajectoryId) {
              standardGeneric("getTrajectory")
            }
)

setMethod (f = "getTrajectory", signature = "Translator",
           definition = function (object, layer, objectId, trajectoryId) {

             #realiza o carregamento dos pacotes
             loadPackages();

             rawData = loadData(object@adapter, layer=layer)

             timeColumn = object@dataSetInfo@timeColumn
             dataColumn = object@dataSetInfo@dataColumn
             objectIdColumn = object@dataSetInfo@objectIdColumn
             trajIdColumn = object@dataSetInfo@trajIdColumn

             filteredData = rawData[rawData[[objectIdColumn]] == objectId,]
             if(!is.null(trajectoryId)){
               filteredData = filteredData[filteredData[[trajIdColumn]] == trajectoryId,]
             }

             if(length(filteredData) == 0){
               stop('trajectory id not found');
             }

             #pegando o crs concatenado
             crs = CRS(filteredData@proj4string@projargs)

             #criando lista com as coordenas
             datxy <- data.frame(x=filteredData$coords.x1,y=filteredData$coords.x2)
             xy <- coordinates(datxy)

             spValues <- SpatialPoints(xy,crs)

             timeValues = xts( 1:length(spValues),as.POSIXct(filteredData[[timeColumn]]))

             IDs = paste("ID",1:length(spValues))
             dataValues = c(1:length(spValues))

             if(dataColumn!="" && !is.null(dataColumn)){
               dataValues = filteredData[[dataColumn]]
             }
             dataValues = data.frame(values = dataValues, ID=IDs)

             stidf <- STIDF(spValues, timeValues, dataValues)
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
           definition = function (object, layer, objectId) {

             #realiza o carregamento dos pacotes
             loadPackages();

             rawData = loadData(object@adapter, layer=layer)

             timeColumn = object@dataSetInfo@timeColumn
             dataColumn = object@dataSetInfo@dataColumn
             objectIdColumn = object@dataSetInfo@objectIdColumn
             trajIdColumn = object@dataSetInfo@trajIdColumn

             filteredData = rawData[rawData[[objectIdColumn]] == objectId,]

             trackList <- c()
             if(!is.null(trajIdColumn) && trajIdColumn!=""){
               if (length(filteredData)>=1){
                 ids = unique(filteredData[[trajIdColumn]])
                 for(i in 1:length(ids)){
                     trajId = ids[[i]][1]
                     track <- getTrajectory(object, layer=layer, objectId=objectId, trajectoryId=trajId)

                     trackList <- c(trackList, track)

                 }
                 return(Tracks(trackList))
               }

             }else{
               track <- getTrajectory(object, layer=layer, objectId=objectId, trajectoryId=NULL);
               trackList <- c(trackList, track);
               return(Tracks(trackList))
             }

           }
)

# method getTrackCollection
setGeneric (name="getTrackCollection",
            def = function (object, layer) {
              standardGeneric("getTrackCollection")
            }
)

setMethod (f = "getTrackCollection", signature = "Translator",
           definition = function (object, layer) {

             #realiza o carregamento dos pacotes
             loadPackages();

             rawData = loadData(object@adapter, layer=layer)

             timeColumn = object@dataSetInfo@timeColumn
             dataColumn = object@dataSetInfo@dataColumn
             objectIdColumn = object@dataSetInfo@objectIdColumn
             trajIdColumn = object@dataSetInfo@trajIdColumn

             tracksList <- c()
             if(!is.null(objectIdColumn) && objectIdColumn!=""){
               if (length(rawData)>=1){
                 ids = unique(rawData[[objectIdColumn]])
                 for(i in 1:length(ids)){
                   objId = ids[[i]][1]
                   tracks <- getTrajectories(object, layer=layer, objectId=objId)

                   tracksList <- c(tracksList, tracks)
                 }

                 return(TracksCollection(tracksList))
               }

             }else{
               stop('objectIdColumn is necessary into dataSetInfo');
             }

           }
)
