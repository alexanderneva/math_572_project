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
        x_pp = 0
        y_pp = 0
        x += h*(x_p + 0.5*h*x_pp)
        y += h*(y_p + 0.5*h*y_pp)
        t += h
    return points

def test_1():
    """
    Test and plot model_1
    """
#    initial = np.array([10,1,1,0])
    pas = np.arange(0.25,1.25,0.25)
    bs = np.arange(0.25,1.25,0.25)
    m_1 = np.arange(-0.5,1,0.5)
    m_2 = np.arange(-0.5,1,0.5)
    for a in pas:
        for b in bs:
            for x_0 in m_1:
                for y_0 in m_2:
                    if x_0==0 and y_0==0:
                        pass
                    initial = np.array([x_0,y_0,a,b])
                    x,y,t = taylor_system_1(model_1,initial,0,0.1,100)
                    print('x',x)
                    print('y',y)
                    fig, ax =plt.subplots(1,2,figsize=(13,8))
                    ax[0].plot(x,y,label='Relational Spending')
                    ax[0].set_xlabel('x')
                    ax[0].set_ylabel('y')
                    ax[0].set_title(f'mutual fear \n x_0 = {np.round(x_0,2)} y_0 = {np.round(y_0,2)} \n a = {np.round(a,2)} b = {np.round(b,2)}')
                    ax[0].legend()
                    ax[1].plot(t,x,label='Nation 1 spending')
                    ax[1].plot(t,y,label='Nation 2 spending')
                    ax[1].set_xlabel('Time')
                    ax[1].set_ylabel('Spending')
                    ax[1].set_title(f'Spending over Time \n x_0 = {np.round(x_0,2)} y_0 = {np.round(y_0,2)} \n a = {np.round(a,2)} b = {np.round(b,2)}')
                    ax[1].legend()
                    plt.tight_layout()
#                    plt.show()

                    plt.savefig(f'figures/mutual_fear{np.round(x_0,2)}_{np.round(y_0,2)}_{np.round(a,2)}_{np.round(b,2)}.jpg',dpi=150)

                    plt.close()



test_1() 
