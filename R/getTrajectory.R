setGeneric(name = "getTrajectory",
           def = function(object, layer, objId){
             standardGeneric("getTrajectory")
           }
          )

setMethod(f="getTrajectory",
          signature = c("object","character", "numeric"),
          definition = function(object, layer, objId){

            #load the packages necessary
            loadPackages();

            #load the data of database
            dados <- loadData(object@datasourceinfo, layer);

            return(dados);
          })

