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
                      popup_text = character(0)) {
    type <- match.arg(type)
    args <- list(
        widget = widget,
        method = "addLayer",
        id = id,
        source = source,
        "source-layer" = source_layer,
        type = type,
        paint = paint,
        popup = if (length(popup_text) > 0) {
            c(list(id = id), list(text = popup_text))
        }
    )

    do.call(invoke, args[lengths(args, FALSE) > 0])
}