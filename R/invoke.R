#' Add a method invocation to a widget object
#' @param widget an HTMLWidget
#' @param method Method name
#' @param ... Arguments passed to the method in Javascript
#' @return `widget` with the method invocations appended
#' @details
#' All `method` names are found in the `typescript/lib/methods.ts` file.
invoke <- function(widget, method, ...) {
    pos <- length(widget$x$calls) + 1
    arg <- list(...)
    widget$x$calls[[pos]] <- list(
        methodName = method,
        args = arg[lengths(arg, FALSE) > 0]
    )
    widget
}