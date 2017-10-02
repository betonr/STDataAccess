# ST_DataAccess

## base environment:

 - datasourceinfo <- DBMSDataSourceInfo(username="postgres", password="postgres", dbname="db_argos")
 - datasetinfo <- DataSetInfo(spatialColumn="obs_loc", timeColumn="obs_date", dataColumn="temper", objectIdColumn="plataform", trajIdColumn="argos_id")
 - adapter <- setDataSourceInfo(Adapter(), datasourceinfo)
 - translator <- Translator(adapter = adapter, dataSetInfo = datasetinfo)

## functions:
 - TRAJECTORY:
   - track <- getTrajectory(translator, "argo_profiles_geom", 1901204, 45737)
   - tracks <- getTrajectories(translator, "argo_profiles_geom", 1901204)
   - tracksCollection <- getTrackCollections(translator, layer="argo_profiles_geom")

 - COVERAGE: 
 
 - TIME SERIES:
