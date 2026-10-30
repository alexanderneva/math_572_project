import numpy as np
import matplotlib.pyplot as plt
from models import model_1

A = np.array([[0,1],[1,0]])


def vector_field(A):
    """
    Generate vector field of system governed by matrix A
    """
    _,x =np.linalg.eig(A)
    v_1,v_2 = np.real(x[:,0]),np.real(x[:,1])
    I = np.linspace(-1,1)
    J = np.linspace(-1,1)
    U,V = np.meshgrid(I,J)
    X,Y = model_1(U,V,1.5,0.5)
    length = np.hypot(X,Y)
    plt.quiver(I,J,X/length,Y/length,angles='xy')
    plt.axhline(0,c='red',alpha=0.25)
    plt.title(f'Vector field for system \n {A}')
    plt.tight_layout()
    plt.show()

vector_field(A)
