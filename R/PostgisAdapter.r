PostgisAdapter <- setClass(
  "PostgisAdapter"
)

#method loadPostgisData
setGeneric (name = "loadPostgisData",
            def = function(object, layer) {
              standardGeneric("loadPostgisData")
            }
)

setMethod(f = "loadPostgisData", signature = "PostgisAdapter",
          definition = function(object, layer) {
            dsn <- paste ("PG:",
                          "dbname=",object@dataSourceInfo@dbname,
                          "host=",object@dataSourceInfo@host,
                          "port=",object@dataSourceInfo@port,
                          "user=",object@dataSourceInfo@username,
                          "password=",object@dataSourceInfo@password
            )
            print(dsn)
            return(readOGR(dsn, layer))
          }
)
