# Immutequality: Emulate Immutability With Equality Operator

This is a small "though experiment" to make `R` emulate the
difference between `=` ("is"), and `<-` ("becomes") as
distinguished e.g. in `F#`. In other words `=` makes a 
"promise" that `x = 10` means that `x` won't change for 
the remainder of the defining scope.

## Example
```{r}

library(immutequality)
## or, more silently and explicitely:
# import::from(immutequality, "=") 

x = 10

print(x)

# Will raise an error!
x <- x*2

# This also
assign("x", 20)

# .. and this too
x = 20
```