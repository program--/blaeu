# nolint start
#' Create a map source
#' @param map A blaeu `map` object.
#' @param x A data source, see details.
#' @param ... Additional options passed to JS, see details.
#' @param id ID for the source
#' @param type Type of source, see [blaeu::source_types].
#' @details
#' ### Data Sources
#' - URLs
#' - GeoJSON Strings
#' - GeoJSON Lists
#' - `sf` Objects
#'
#' #### Planned Data Sources
#' - `sfc` Objects
#' - `terra::SpatVector`
#' - `terra::SpatRaster`
#'
#' ### Additional Options
#' Argument  | Type        | Description
#' --------- | ----------- | -----------
#' **tiles** | `logical`   | Should `x` be considered a list of XYZ tiles?
#'
#'
#' @seealso [blaeu::map]
#' @export
#' @rdname map_source
# nolint end
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
map_source.character <- function(map, x, ..., tiles = FALSE, type = source_types(), id = NULL) {
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
    } else if (tiles) {
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
