#' Immutequality
#'
#' @description This package overloads the \code{`=`} operator with the
#'   immutequality operator. It associates a value with a symbol, which can then
#'   subsequently be treated equal to the value for the remainder of the scope.
#'   This "immutability" is emulated by assigning an active binding to the
#'   symbol. If the value is accessed, it is simply returned by the active
#'   binding, but if a value change is attempted, an error is raised that the
#'   symbol cannot be reused. The immutequality operator can thus be used to
#'   promise that the value associated with a symbol will not change for the
#'   remainder of its scope.
#'
#' @docType package
#' @name immutequality
#' @title Use Equality Assignment for Immutability
#'
#' @author Stefan Milton Bache <stefan@@stefanbache.dk>
NULL

#' Immutequality Operator
#'
#' Assign \code{value} to the symbol \code{x}, which can then subsequently
#' be treated equal to \code{value}. This "immutability" is emulated by
#' assigning an active binding to the symbol \code{x}. If the value is
#' accessed, it is simply returned by the active binding, but if a value
#' change is attempted, an error is raised that the symbol cannot be reused.
#' The immutequality operator can thus be used to promise that the value
#' associated with a symbol will not change for the remainder of its scope.
#'
#' @usage NULL
#' @param x a symbol
#' @param value the associated value
#'
#' @export
#' @examples
#' x = 10
#'
#' print(x)
#' tryCatch(x <- x*2, error = function(e) message(e))
`=` <- function(x, value)
{
  sym <- deparse(substitute(x))

  if (exists(sym, parent.frame(), inherits = FALSE))
    stop(sprintf("Cannot reuse the symbol %s!", sym), call. = FALSE)

  f <- function(.) {
    if (missing(.)) {
      value
    } else {
      stop(sprintf("Cannot reuse the symbol %s!", sym), call. = FALSE)
    }
  }

  makeActiveBinding(sym, f, parent.frame())
}