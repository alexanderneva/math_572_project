## coding a logistic discretization
import numpy as np
import matplotlib.pyplot as plt


def budworm(r,k,t):
    return r*t*(1-t/k)- t**2/(1+t**2)

def budworm_deriv(r,k,t):
    return r - (2*r/k)*t - 2*t/(1+t**2)**2

def exp_disc(f,n_step,y0):
    points = np.zeros(n_step+1)
    y = y0
    step = 0
    while step <= n_step:
        points[step]=y
        y = y*np.exp(f(y)/y)
        step += 1
    return points


def logistic_continuous(r,K,y0,t):
    C = y0/(K-y0)
    y = C*K / (C + np.exp(-r*t))
    return y


def logistic(r,K,n_step,y0,a,b):
    h = (b-a)/n_step
    rho = 1 + h*r
    k = K*rho/(h*r)
    y = y0
    t = a
    points = np.zeros([2,n_step])
    points[0,0] = t
    points[1,0] = y0
    for i in range(n_step):
        y = rho*y*(1-y/k)
        t += h
        points[0,i]=t
        points[1,i]=y
    return points

#t,y=logistic(3.2,10,100,0.5,0,2)
#y_c = logistic_continuous(3.2,10,0.5,t)
#
#                              
#plt.plot(t,y,label = 'discretized')
#plt.plot(t,y_c, label = 'continuous')
#plt.grid()
#plt.legend()
#plt.show()

def newton(f,f_prime,n_steps,t0):
    points = np.zeros(n_steps)
    t = t0
    for step in range(n_steps):
        points[step]=t
        f_0 = f(t0)
        f_p_0 = f_prime(t)
        coeff = f_0/f_p_0
        t -= coeff
    return points

r = -1
steps = newton(lambda t : budworm(r,2,t),lambda t : budworm_deriv(r,2,t),10,1.2)
print(steps)
#plt.plot(steps)
#f = lambda x : x/(1+x**2 )
t = np.linspace(0,2)
#plt.plot(np.log(exp_disc(f,100,0.5)))
plt.plot(t,budworm(r,2,t))
#plt.plot(t,budworm_deriv(0.5,2,t),label='derivative')
#plt.legend()
plt.grid()
plt.show()


