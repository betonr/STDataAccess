loadPackages <- function() {
  if (!require("rgdal", quietly = TRUE)) {
    stop('The package rgdal was not installed')
  }
  if (!require("xts", quietly = TRUE)) {
    stop('The package xts was not installed')
  }
  if (!require("trajectories", quietly = TRUE)) {
    stop('The package trajectories was not installed')
  }
  if (!require("spacetime", quietly = TRUE)) {
    stop('The package spacetime was not installed')
  }
}
