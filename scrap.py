import numpy as np
import matplotlib.pyplot as plt
from numpy._core.umath import arctanh

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


pay = payment(r,12,10,y0)

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

#plt.plot(x,int_factor(np.log(1000),x))
#plt.show()

def exponential(A,n):
    """
    Return the matrix exponential of matrix A to n terms
    """
    sum = 0
    k = 0
    while k <= n :
        sum += (1/factorial(k))*A**k
        k += 1
    return sum

a = -3.
b = 1.
x_0 = 1.
y_0 = 4.
initial = np.array([x_0,y_0])
#A = np.abs(a*y_0**2-b*x_0**2)
M = np.array([[0,a],[b,0]])
#P= np.array([[np.sqrt(a/(a+b)),np.sqrt(b/(a+b))],
#             [np.sqrt(b/(a+b)),-np.sqrt(a/(a+b))]])
P = np.array([[np.sqrt(a/(a+b)),np.sqrt(a/(a+b))],[np.sqrt(b/(a+b)),-np.sqrt(b/(a+b))]])
print("v_1 norm ", np.linalg.norm(P[:,0]))
print("v_2 norm ", np.linalg.norm(P[:,1]))
c = np.linalg.inv(P)@np.array([x_0,y_0])
B = np.array([[-b,0],[0,a]])
print("Transformed form", P@B@np.linalg.inv(P))
print("Sqrt ab ",-np.sqrt(a*b), "a - b", a-b)
print(P@P)
print(P@M)
print("P@M@P", np.linalg.inv(P)@M@P)
sol = lambda t : (c[0]*P[:,0] + c[1]*P[:,1])*np.cosh(np.sqrt(a*b)*t)[...,np.newaxis] + (c[0]*P[:,0] - c[1]*P[:,1])*np.sinh(np.sqrt(a*b)*t)[...,np.newaxis]

sol_2 = lambda t : c[0]*P[:,0]*np.exp(np.sqrt(a*b)*t)[...,np.newaxis] + c[1]*P[:,1]*np.exp(-np.sqrt(a*b)*t)[...,np.newaxis]

sol_3 = lambda t : (initial@P[:,0])*P[:,0]*np.exp(np.sqrt(a*b)*t)[...,np.newaxis]+(initial@P[:,1])*P[:,1]*np.exp(-np.sqrt(a*b)*t)[...,np.newaxis]
#phi = np.arctanh(np.sqrt(a/b)*(x_0/y_0))
#sol_1 = lambda t : np.sqrt(A/b)*np.sinh(np.sqrt(a*b)*t+phi)
#sol_2 = lambda t : np.sqrt(A/a)*np.cosh(np.sqrt(a*b)*t+phi)
t = np.linspace(0,1)
U,V = P[:,0],P[:,1]
fig, ax = plt.subplots(2)
ax[0].plot(sol(t)[:,0],sol(t)[:,1],label='sol_1')
ax[0].plot(sol_2(t)[:,0],sol_2(t)[:,1],label='sol_2')
ax[0].plot(sol_3(t)[:,0],sol_3(t)[:,1],label='sol_3')
ax[0].legend()
ax[1].plot(t,sol(t)[:,0],label='nation 1')
ax[1].plot(t,sol(t)[:,1],label='nation 2')
ax[1].legend()
plt.show()

Q = np.array([[0,a],[-b,0]])
M = np.array([[0,a],[b,0]])
v_1 = np.array([a/np.sqrt(a*b),1])
v_2 = np.array([1,-b/np.sqrt(a*b)])
#print(v_2.T@Q@v_2- v_1.T@Q@v_1,np.sqrt(a*b)*v_2)




