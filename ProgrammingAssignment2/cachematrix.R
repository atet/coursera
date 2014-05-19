## Matrix inversion can be a computationally intensive task.
## There may be some benefit to caching the inverse of a matrix instead of repeatedly computing it.
## The two functions below will cache the inverse of a matrix.

## makeCacheMatrix is a function that creates a matrix object that can cache its inverse.
## It will be assumed that the matrix given is always invertible.
makeCacheMatrix <- function(x = matrix()) {

}

## cacheSolve is a function that computes the inverse of the matrix returned from the makeCacheMatrix function.
## If the inverse has already been calculated, the cached inverse will be returned, otherwise
## the inverse will be calculated.
cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
}
