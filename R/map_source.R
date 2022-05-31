#' Create a map source
#' @export
#' @rdname map_source
map_source <- function(map, x, ..., id = NULL) {
    UseMethod("map_source", x)
}

#' @export
#' @rdname map_source
map_source.default <- function(map, x, ..., id = NULL) {
    stop(paste(class(x)[1], "objects not supported"))
}

#' @export
#' @rdname map_source
map_source.character <- function(map, x, ..., type = "geojson", id = NULL) {
    invoke(map, "addSource", list(id = id, type = type, data = x))
}

#' @export
#' @rdname map_source
map_source.list <- function(map, x, ..., type = "geojson", id = NULL) {
    invoke(map, "addSource", list(id = id, type = type, data = x))
}

#' @export
#' @rdname map_source
map_source.sf <- function(map, x, ..., id = NULL) {
    # `sf` objects are expected to be implemented in two ways:
    # 1. as a basic implementation converting sf objs to GeoJSON
    # 2. as a vector tile implementation, where sf objects are
    #    converted to vector tiles in memory and served directly
    #    that way. This will allow for very large data to be
    #    served seamlessly.

    geojson <- jsonlite::fromJSON(geojsonsf::sf_geojson(x), FALSE)
    map_source.list(map, geojson, ..., type = "geojson", id = id)
}

#' @export
#' @rdname map_source
map_source.sfc <- function(map, x, ..., id = NULL) {
    stop("sfc objects not implemented")
}

#' @export
#' @rdname map_source
map_source.sfg <- function(map, x, ..., id = NULL) {
    stop("sfg objects not implemented")
}