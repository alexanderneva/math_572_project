import numpy as np
def f(x):
    """
    Double
    """
    return 2*x

def cobweb(x_0,n):
    """
    Return cobweb points after n iterations
    """
    points = np.zeros(shape=(n,2))
    points[0,0]=x_0

    
