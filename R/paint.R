# nolint start
#' Add paint rules to a layer style.
#' @param color
#' @param opacity
#' @param pattern
#' @param antialias
#' @param outline_color
#' @param translate
#' @param translate_anchor
#' @param blur
#' @param dasharray
#' @param gap_width
#' @param gradient
#' @param offset
#' @param width
#' @param icon_color
#' @param icon_halo_blur
#' @param icon_halo_color
#' @param icon_halo_width
#' @param icon_opacity
#' @param icon_translate
#' @param icon_translate_anchor
#' @param text_color
#' @param text_halo_blur
#' @param text_halo_color
#' @param text_halo_width
#' @param text_opacity
#' @param text_translate
#' @param text_translate_anchor
#' @param brightness_max
#' @param brightness_min
#' @param contrast
#' @param fade_duration
#' @param hue_rotate
#' @param resampling
#' @param saturation
#' @param pitch_alignment
#' @param pitch_scale
#' @param radius
#' @param stroke_color
#' @param stroke_opacity
#' @param stroke_width
#' @param base
#' @param height
#' @param vertical_gradient
#' @param intensity
#' @param weight
#' @param accent_color
#' @param exaggeration
#' @param highlight_color
#' @param illumination_anchor
#' @param illumination_direction
#' @param shadow_color
#' @details
#' For specific parameter descriptions, see the
#' [MapLibre GL style specification](https://maplibre.org/maplibre-gl-js-docs/style-spec/layers/).
#' All paint defaults are the same defaults from the MapLibre GL style specification.
#'
#' ### Expressions
#' [Expressions](https://maplibre.org/maplibre-gl-js-docs/style-spec/expressions/)
#' are supported via nested lists, in the same manner that Javascript arrays are used.
#' @rdname paint
#' @export
# nolint end
paint_background <- function(color = "#000000", opacity = 1, pattern = NULL) {
    .paint("background")
}

#' @rdname paint
#' @export
paint_fill <- function(antialias = TRUE,
                       color = "#000000",
                       opacity = 1,
                       outline_color = NULL,
                       pattern = NULL,
                       translate = c(0, 0),
                       translate_anchor = c("map", "viewport")) {
    translate_anchor <- match.arg(translate_anchor)
    if (!is.null(outline_color) && identical(antialias, FALSE)) {
        warning(
            "`outline_color` requires `antialias` to be TRUE"
        )
    }

    .paint("fill")
}

#' @rdname paint
#' @export
paint_line <- function(blur = 0,
                       color = "#000000",
                       dasharray = NULL,
                       gap_width = 0,
                       gradient = NULL,
                       offset = 0,
                       opacity = 1,
                       pattern = NULL,
                       translate = c(0, 0),
                       translate_anchor = c("map", "viewport"),
                       width = 1) {
    translate_anchor <- match.arg(translate_anchor)
    .paint("line")
}

#' @rdname paint
#' @export
paint_symbol <- function(icon_color = "#000000",
                         icon_halo_blur = 0,
                         icon_halo_color = "#000000",
                         icon_halo_width = 0,
                         icon_opacity = 1,
                         icon_translate = c(0, 0),
                         icon_translate_anchor = c("map", "viewport"),
                         text_color = "#000000",
                         text_halo_blur = 0,
                         text_halo_color = "#000000",
                         text_halo_width = 0,
                         text_opacity = 1,
                         text_translate = c(0, 0),
                         text_translate_anchor = c("map", "viewport")) {
    icon_translate_anchor <- match.arg(icon_translate_anchor)
    text_translate_anchor <- match.arg(text_translate_anchor)
    .paint("")
}

#' @rdname paint
#' @export
paint_raster <- function(brightness_max = 1,
                         brightness_min = 0,
                         contrast = 0,
                         fade_duration = 300,
                         hue_rotate = 0,
                         opacity = 1,
                         resampling = c("linear", "nearest"),
                         saturation = 0) {
    resampling <- match.arg(resampling)
    .paint("raster")
}

#' @rdname paint
#' @export
paint_circle <- function(blur = 0,
                         color = "#000000",
                         opacity = 1,
                         pitch_alignment = c("map", "viewport"),
                         pitch_scale = c("map", "viewport"),
                         radius = 5,
                         stroke_color = "#000000",
                         stroke_opacity = 1,
                         stroke_width = 0,
                         translate = c(0, 0),
                         translate_anchor = c("map", "viewport")) {
    pitch_alignment <- match.arg(pitch_alignment)
    pitch_scale <- match.arg(pitch_scale)
    translate_anchor <- match.arg(translate_anchor)
    .paint("circle")
}

#' @rdname paint
#' @export
paint_fill_extrusion <- function(base = 0,
                                 color = "#000000",
                                 height = 0,
                                 opacity = 1,
                                 pattern = NULL,
                                 translate = c(0, 0),
                                 translate_anchor = c("map", "viewport"),
                                 vertical_gradient = TRUE) {
    translate_anchor <- match.arg(translate_anchor)
    .paint("fill-extrusion")
}

#' @rdname paint
#' @export
paint_heatmap <- function(color,
                          intensity = 1,
                          opacity = 1,
                          radius = 30,
                          weight = 1) {
    .paint("heatmap")
}

#' @rdname paint
#' @export
paint_hillshade <- function(accent_color = "#000000",
                            exaggeration = 0.5,
                            highlight_color = "#FFFFFF",
                            illumination_anchor = c("map", "viewport"),
                            illumination_direction = 335,
                            shadow_color = "#000000") {
    illumination_anchor <- match.arg(illumination_anchor)
    .paint("hillshade")
}

.paint <- function(prefix = "", .envir = parent.frame()) {
    paint <- as.list(.envir)
    names(paint) <- paste0(prefix, "-", gsub("_", "-", names(paint)))
    paint[lengths(paint) > 0]
}
