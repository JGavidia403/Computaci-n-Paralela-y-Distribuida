#cython: language_level=3
cimport cython 
import numpy as np
cimport numpy as np
from cython.parallel import prange


cdef extern from "math.h":
        double exp(double x) nogil

def rbf_network(np.ndarray[np.float_t, ndim=2] X, np.ndarray[np.float_t, ndim=1]  beta, int theta):

    cdef int N = X.shape[0] 
    cdef int D = X.shape[1]
    ## tipo de dato (cython) ndarray para matrices numpy
    ## tipo de datos del array np.float_t 
    cdef np.ndarray[np.float_t, ndim=1] Y 
    Y= np.zeros(N)
    cdef int i
    cdef int j 
    cdef float r

    for i in range(N):
        for j in range(N):
            r = 0
            for d in range(D):
                r += (X[j, d] - X[i, d]) ** 2
            r = r**0.5
            Y[i] += beta[j] * exp(-(r * theta)**2)

    return Y

