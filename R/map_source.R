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
map_source.character <- function(map, x, ..., type = source_types(), id = NULL) {
    type <- match.arg(type)

    if (type == "pmtiles") {
        if (!grepl("pmtiles://", x)) {
            x <- paste0("pmtiles://", x)
        }

        if (!grepl("/\\{z\\}/\\{x\\}/\\{y\\}", x)) {
            x <- paste0(
                x,
                if (substr(x, nchar(x), nchar(x)) != "/") "/",
                "{z}/{x}/{y}"
            )
        }

        invoke(map, "addSource", list(id = id, type = "vector", tiles = x, ...))
    } else {
        invoke(map, "addSource", list(id = id, type = type, data = x, ...))
    }
}

#' @export
#' @rdname map_source
map_source.list <- function(map, x, ..., type = source_types(), id = NULL) {
    type <- match.arg(type)
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
    invoke(
        map,
        "addSource",
        list(id = id, type = "geojson", data = x, sf = TRUE, ...)
    )
}

#' @export
#' @rdname map_source
map_source.sfc <- function(map, x, ..., id = NULL) {
    stop("sfc objects not implemented")
}

#' @export
#' @rdname map_source
map_source.sfg <- function(map, x, ..., id = NULL) {
    stop("`sfg` objects are not supported. Convert to an `sfc` or `sf` object first.")
}
