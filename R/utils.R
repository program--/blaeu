#' MapLibre GL Source/Layer Types
#' @export
#' @keywords helper
#' @rdname utils
layer_types <- function() {
    c(
        "background", "fill", "line", "symbol",
        "raster", "circle", "fill-extrusion", "heatmap",
        "hillshade"
    )
}

#' @export
#' @keywords helper
#' @rdname utils
source_types <- function() {
    c(
        "geojson", "vector", "raster",
        "raster-dem", "image", "video",
        "pmtiles"
    )
}
