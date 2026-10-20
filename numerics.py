import numpy as np
from models import model_1
import matplotlib.pyplot as plt

def taylor_system_1(f,initial,t0,t1,n_step):
    """
    Second order approximation for model_1
    """
    h = (t1-t0)/n_step
    t = t0
    x, y, a, b = initial
    points = np.zeros([3,n_step])
    for i in range(n_step):
        points[0,i] = x
        points[1,i] = y
        points[2,i] = t
        x_p,y_p = f(x,y,a,b)
        x_pp = a*y_p
        y_pp = b*x_p
        x = h*(x_p + 0.5*h*x_pp)
        y = h*(y_p + 0.5*h*y_pp)
        t += h
    return points

def test_1():
    """
    Test and plot model_1
    """
#    initial = np.array([10,1,1,0])
    pas = np.arange(-0.75,0.75,0.25)
    bs = np.arange(-0.75,0.75,0.25)
    m_1 = np.arange(-1,1,0.25)
    m_2 = np.arange(-1,1,0.25)
    for a in pas:
        for b in bs:
            for x_0 in m_1:
                for y_0 in m_2:
                    initial = np.array([x_0,y_0,a,b])
                    x,y,t = taylor_system_1(model_1,initial,0,1,100)
                    plt.plot(t,x,label='expenditure 1')
                    plt.plot(t,y,label='expenditure 2')
                    plt.legend()
                    plt.tight_layout()
                    plt.savefig(f'figures/mutual_fear{np.round(x_0,2)}_{np.round(y_0,2)}_{np.round(a,2)}_{np.round(b,2)}.jpg',dpi=150)
                    plt.show()
                    plt.close()



test_1() 
