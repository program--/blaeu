#' Create a MaplibreGL map widget
#' @param style A style object or URL to style json
#' @param width Width
#' @param height Height
#' @param element_id HTML Element ID
#' @param ... Additional options passed to maplibregl constructor
#' @importFrom htmlwidgets createWidget
#' @export
map <- function(style = openstreetmap(), width = NULL, height = NULL, element_id = NULL, ...) {
    widget_data <- list(
        props = list(style = style, ...),
        calls = list()
    )

    # The `calls` element represents a list of methods defined in Typescript
    # that are called by the underlying MaplibreGL Map object.
    # These call functions need to be defined in the `methods.ts` file

    htmlwidgets::createWidget(
        name      = "map",
        x         = widget_data,
        width     = width,
        height    = height,
        package   = "blaeu",
        elementId = element_id
    )
}

#' Shiny bindings
#' @inheritParams htmlwidgets::shinyWidgetOutput
#' @importFrom htmlwidgets shinyWidgetOutput
#' @export
#' @rdname shiny
mapOutput <- function(outputId, width = "100%", height = "400px") {
    htmlwidgets::shinyWidgetOutput(
        outputId,
        "map",
        width,
        height,
        package = "blaeu"
    )
}

#' @inheritParams htmlwidgets::shinyRenderWidget
#' @importFrom htmlwidgets shinyRenderWidget
#' @export
#' @rdname shiny
renderMap <- function(expr, env = parent.frame(), quoted = FALSE) {
    if (!quoted) {
        expr <- substitute(expr)
    }

    htmlwidgets::shinyRenderWidget(expr, mapOutput, env, quoted = TRUE)
}
