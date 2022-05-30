# nolint start
.stamen_attr <- list(
    default = paste(
        'Map tiles by <a href="http://stamen.com">Stamen Design</a>,',
        'under <a href="http://creativecommons.org/licenses/by/3.0">CC BY 3.0</a>.',
        'Data by <a href="http://openstreetmap.org">OpenStreetMap</a>,',
        'under <a href="http://www.openstreetmap.org/copyright">ODbL</a>.'
    ),
    watercolor = paste(
        'Map tiles by <a href="http://stamen.com">Stamen Design</a>,',
        'under <a href="http://creativecommons.org/licenses/by/3.0">CC BY 3.0</a>.',
        'Data by <a href="http://openstreetmap.org">OpenStreetMap</a>,',
        'under <a href="http://creativecommons.org/licenses/by/3.0">CC BY SA</a>.'
    )
)
# nolint end

stamen <- function(theme = c("watercolor", "terrain", "toner")) {
    theme <- match.arg(theme)

    x <- structure(
        sprintf(
            "https://stamen-tiles-%s.a.ssl.fastly.net/%s/{z}/{x}/{y}.png",
            letters[1:4],
            theme
        ),
        attribution = ifelse(
            theme == "watercolor",
            .stamen_attr$watercolor,
            .stamen_attr$default
        )
    )

    .raster_to_style("stamen", x)
}

openstreetmap <- function() {
    x <- structure(
        sprintf(
            "https://%s.tile.openstreetmap.org/{z}/{x}/{y}.png",
            letters[1:3]
        ),
        attribution = paste0(
            "© ",
            '<a href="https://www.openstreetmap.org/copyright">',
            "OpenStreetMap",
            "</a>",
            " contributors"
        )
    )

    .raster_to_style("osm", x)
}

carto <- function(theme = c("dark-matter", "voyager", "positron")) {
    theme <- match.arg(theme)

    # Attribution is within the style data
    sprintf(
        "https://basemaps.cartocdn.com/gl/%s-gl-style/style.json",
        theme
    )
}

.raster_to_style <- function(layer_id, tiles) {
    src <- list(
        type        = "raster",
        tiles       = as.vector(tiles),
        tileSize    = 256,
        attribution = attributes(tiles)$attribution
    )

    lyr <- list(
        id      = layer_id,
        type    = "raster",
        source  = "raster-tiles",
        minzoom = 0,
        maxzoom = 22
    )

    list(
        version = 8,
        sources = list("raster-tiles" = src),
        layers  = list(lyr)
    )
}