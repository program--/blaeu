paint_background <- function(color = "#000000", opacity = 1, pattern = NULL) {
    .paint("background")
}

paint_fill <- function(antialias = TRUE,
                       color = "#000000",
                       opacity = 1,
                       outline_color = NULL,
                       pattern = NULL,
                       translate = c(0, 0),
                       translate_anchor = c("map", "viewport")) {
    translate_anchor <- match.arg(translate_anchor)
    if (!is.null(outline_color) & identical(antialias, FALSE)) {
        rlang::warn(
            "`outline_color` requires `antialias` to be TRUE"
        )
    }

    .paint("fill")
}

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

paint_heatmap <- function(color,
                          intensity = 1,
                          opacity = 1,
                          radius = 30,
                          weight = 1) {
    .paint("heatmap")
}

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