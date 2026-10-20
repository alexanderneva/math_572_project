import numpy as np

def model_1(x,y,a,b):
    """
    Mutual fear model
    x : expenditure of nation 1
    y : expenditure of nation 2
    a : rate nation 1 buys in proportion to nation 2
    b : rate nation 2 buys in proportion to nation 1
    """
    x_p = a*y
    y_p = b*x
    return x_p, y_p
