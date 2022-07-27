#' MapLibre GL Source Types
#' @export
source_types <- function() {
    c(
        "geojson", "vector", "raster",
        "raster-dem", "image", "video",
        "pmtiles"
    )
}