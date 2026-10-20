import numpy as np
import matplotlib.pyplot as plt

def factorial(n):

    if n == 1:
        return 1
    elif n==0:
        return 1
    else:
        return n*factorial(n-1)


def interest(r,freq,pay_freq,t,y0,k):
    w = (1+r/freq)**freq
    y = y0*w**t + pay_freq*k*(1-w**t)/(1-w)
    return y

def payment(r,pay_freq,n_year,y0):
    n = n_year*pay_freq
    r = r/pay_freq
    w = 1 + r
    y = y0*(1-w)/(1-w**n) * w**n
    inter = y*n-y0
    return y,inter

r = 0.09
t = 30
freq = 1
pay_freq = 12
k = -1000
y0 = 1e5

print(interest(r,freq,pay_freq,t,y0,k))

pay = payment(r,12,10,y0)
print("Payment ", pay)

t = np.arange(0,30)

#for t in np.arange(1,30):
#    pay,inter = payment(r,pay_freq,t,y0)
#    print(inter)
#    plt.plot(t,pay)
#    plt.plot(t,inter)
#plt.show()


def ivp_sol(y0,y1,x):
    A = np.sqrt(y1**2-y0**2)
    phi = np.atanh(y0/y1)
    y = A*np.sinh(x+phi)
    return y

def ivp_sol_2(y0,y1,x):
    A = np.sqrt(y1**2+y0**2)
    C1 = ((2+np.sqrt(3))*y0-2*y1)/(1+np.sqrt(3))
    C2 = (2*y1-y0)/(1+np.sqrt(3))
    phi = np.atan(C2/C1)
    y = np.exp(-0.5*x)*A*np.cos(x-phi)
    return y

def int_factor(mu,x):
    ans = 0
    for i in range(5+1):
        ans+=factorial(5)/factorial(5-i)*x**(i)/mu**(i)
    ans = -1*np.exp(-mu*x)*ans
    return ans

print(int_factor(np.log(2),1))



x=np.linspace(-1,1)
#plt.plot(x,ivp_sol_2(1,1,x))
#plt.show()

plt.plot(x,int_factor(np.log(1000),x))
plt.show()

