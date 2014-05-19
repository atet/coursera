## AK 20140519
## github: atet
## NOTE: I am submitting this early, but seeing how this is a public repos, anyone can see it right away.
## If you need help, you can use this as a guide to understanding the problem, but please do not just copy/paste this code.
## R has a steep learning curve, but you will get it with time and experience, I have faith in you.
#####################################################################################################

## Matrix inversion can be a computationally intensive task.
## There may be some benefit to caching the inverse of a matrix instead of repeatedly computing it.
## The two functions below will cache the inverse of a matrix in a special "matrix" object.

## makeCacheMatrix is a function that creates a special "matrix" object that can cache its inverse.
## It will be assumed that the matrix given is always invertible.
## NOTE: This special "matrix" is really a list of functions that will manipulate the global matrix object x.
makeCacheMatrix <- function(global_matrix = matrix()) {
  ## Upon creation of this special "matrix" object, we will initially set the global_matrix_inverse as NULL, i.e. no inverse has been calculated yet.
  global_matrix_inverse <- NULL
  ## This is the setter function that will set the global object x as 
  set_matrix         <- function(new_matrix) {
    ## Set the global object global_matrix as new_matrix being passed in
    global_matrix         <<- new_matrix
    ## Set the global object global_matrix_inverse as NULL
    global_matrix_inverse <<- NULL
  }
  ## This is getter function that will get (i.e. return) the global_matrix object
  get_matrix         <- function(){
    return(global_matrix)
  } 
  set_matrix_inverse <- function(matrix_inverse){
    global_matrix_inverse <<- matrix_inverse
  } 
  get_matrix_inverse <- function(){
    return(global_matrix_inverse)
  } 
  ## Make a list of the four function objects above and return this list
  return(list(
    set_matrix         = set_matrix,
    get_matrix         = get_matrix,
    set_matrix_inverse = set_matrix_inverse,
    get_matrix_inverse = get_matrix_inverse
  ))
}

## cacheSolve is a function that computes the inverse of the matrix returned from the makeCacheMatrix function.
## If the inverse has already been calculated, the cached inverse will be returned, otherwise
## the inverse will be calculated.
cacheSolve <- function(special_matrix_object, ...) {
  ## Return a matrix that is the inverse of 'x'...
  ## Let's see if there is already and inverse cached (i.e. calculated) for the special_matrix_object.
  matrix_inverse <- special_matrix_object$get_matrix_inverse()
  if(!is.null(matrix_inverse)) {
    ## This will run if there is an inverse already cached and return what is already there.
    message("getting cached data")
    return(matrix_inverse)
  }else{
    ## This will run if there is no inverse cached, will calculate the inverse then cache it.
    temporary_matrix_copy <- special_matrix_object$get_matrix()
    matrix_inverse        <- solve(temporary_matrix_copy, ...)
    special_matrix_object$set_matrix_inverse(matrix_inverse)
    return(matrix_inverse)
  }
}

## Testing the functions
if(FALSE){
  ## Example of using above funtions, using example for solve()
  hilbert <- function(n) { i <- 1:n; 1 / outer(i - 1, i, "+") }
  h8      <- hilbert(8); h8
  #[,1]      [,2]      [,3]       [,4]       [,5]       [,6]       [,7]       [,8]
  #[1,] 1.0000000 0.5000000 0.3333333 0.25000000 0.20000000 0.16666667 0.14285714 0.12500000
  #[2,] 0.5000000 0.3333333 0.2500000 0.20000000 0.16666667 0.14285714 0.12500000 0.11111111
  #[3,] 0.3333333 0.2500000 0.2000000 0.16666667 0.14285714 0.12500000 0.11111111 0.10000000
  #[4,] 0.2500000 0.2000000 0.1666667 0.14285714 0.12500000 0.11111111 0.10000000 0.09090909
  #[5,] 0.2000000 0.1666667 0.1428571 0.12500000 0.11111111 0.10000000 0.09090909 0.08333333
  #[6,] 0.1666667 0.1428571 0.1250000 0.11111111 0.10000000 0.09090909 0.08333333 0.07692308
  #[7,] 0.1428571 0.1250000 0.1111111 0.10000000 0.09090909 0.08333333 0.07692308 0.07142857
  #[8,] 0.1250000 0.1111111 0.1000000 0.09090909 0.08333333 0.07692308 0.07142857 0.06666667
  
  sh8     <- solve(h8); sh8
  #[,1]      [,2]       [,3]       [,4]        [,5]        [,6]        [,7]       [,8]
  #[1,]      64     -2016      20160     -92400      221760     -288288      192192     -51480
  #[2,]   -2016     84672    -952560    4656960   -11642400    15567552   -10594584    2882880
  #[3,]   20160   -952560   11430720  -58212000   149688000  -204324119   141261119  -38918880
  #[4,]  -92400   4656960  -58212000  304919999  -800414996  1109908794  -776936155  216215998
  #[5,]  221760 -11642400  149688000 -800414996  2134439987 -2996753738  2118916783 -594593995
  #[6,] -288288  15567552 -204324119 1109908793 -2996753738  4249941661 -3030050996  856215352
  #[7,]  192192 -10594584  141261119 -776936154  2118916782 -3030050996  2175421226 -618377753
  #[8,]  -51480   2882880  -38918880  216215998  -594593995   856215351  -618377753  176679358
  
  h8 ## Matrix from above
  special_h8 <- makeCacheMatrix(h8)
  special_h8$get_matrix()
  special_h8$get_matrix_inverse() ## Should be nothing returned since global_matrix_inverse is initially NULL
  cacheSolve(special_h8)          ## Determine inverse of special matrix and store it
  special_h8$get_matrix_inverse() ## Now will print out the cached matrix
}

