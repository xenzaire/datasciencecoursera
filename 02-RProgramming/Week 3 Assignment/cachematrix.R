####These functions takes an invertible square matrix, inverse it and cache the result.
####This help save time so that one will not have to perform this over and over again.


####makeCacheMatrix takes a square matrix to create a special "vector", gives a list containing a function to:
####1. set the value of the square matrix
####2. get the value of the square matrix
####3. set the value of the inverse of the square matrix
####4. get the value of the inverse of the square matrix

####This function, resets the inverse value i to NULL, everytime a new matrix is assigned.


makeCacheMatrix <- function(x = matrix()) { #Set default value to empty matrix
  i <- NULL
  set <- function (y) {
    x <<- y #assign y to object x that is in parent environment
    i <<- NULL #assign NULL to object inv that is in parent environment
  }
  get <- function () x
  setInvMatrix <- function (inv) i <<- inv
  getInvMatrix <- function () i
  list (set = set,
        get = get,
        setInvMatrix = setInvMatrix,
        getInvMatrix = getInvMatrix)
}


####cacheSolve checks whether there is already a value calculated for the inverse matrix.
####If yes, then it returns the cached value.
####If no, then it calculates the result, set it to list created in makeCacheMatrix and display the new result.

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  i <- x$getInvMatrix()
  if (!is.null(i)) {
    message ("getting the cache data")
    return (i)
  }
  data <- x$get()
  i <- solve(data, ...)
  x$setInvMatrix(i)
  i
}
