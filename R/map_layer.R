map_layer <- function(widget, id,
                      source = NULL,
                      source_layer = NULL,
                      type = c(
                          "background", "fill", "line",
                          "symbol", "raster", "circle",
                          "fill-extrusion", "heatmap", "hillshade"
                      ),
                      paint = list()) {
    type <- match.arg(type)
    args <- list(
        widget         = widget,
        method         = "addLayer",
        id             = id,
        source         = source,
        "source-layer" = source_layer,
        type           = type,
        paint          = paint
    )

    do.call(invoke, args[lengths(args, FALSE) > 0])
}