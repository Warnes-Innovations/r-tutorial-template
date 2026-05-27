fun <- function(x)
{
  y <- x^2
  retval <- list(x=x, y=y, xy=x+y)
  class(retval) <- 'myobject'
  return(retval)
}
