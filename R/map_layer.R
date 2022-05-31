#' Add a layer to a map.
#' @param widget
#' @param id
#' @param popup a `list` with at least the element `$text`.
#'              `$text` must be a string which may contain
#'              string interpolation variables (`${...}`).
#'              For example, if `source` has a property `mag`,
#'              the popup text can be specified as:
#'                  "Magnitude: ${mag}"
#'              to display the `mag` property.
map_layer <- function(widget, id,
                      source = NULL,
                      source_layer = NULL,
                      type = layer_types(),
                      paint = list(),
                      popup = list()) {
    type <- match.arg(type)
    args <- list(
        widget         = widget,
        method         = "addLayer",
        id             = id,
        source         = source,
        "source-layer" = source_layer,
        type           = type,
        paint          = paint,
        popup          = c(list(id = id), popup)
    )

    do.call(invoke, args[lengths(args, FALSE) > 0])
}