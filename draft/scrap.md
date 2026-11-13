We apply the Gram-Schmidt process to find $\tilde{v_2}$. First
\begin{equation*}
  ||v_1||^2 = v_1\cdot v_1 = \frac{a+b}{b}.
\end{equation*}
Let $\tilde{v_1}=v_1/||v_1||= \left(\sqrt{\frac{a}{a+b}},\sqrt{\frac{b}{a+b}}\right)$.
Then $\tilde{v_2}\perp\tilde{v_1}$ is given by
\begin{align*}
  \tilde{v_2}&= v_2 - (v_2\cdot\tilde{v_1})\tilde{v_1}\\
	     &= \left(1,-\sqrt{\frac{b}{a}}\right)-\left(\sqrt{\frac{a}{a+b}}-\frac{b}{\sqrt{a}\sqrt{a+b}}\right)\left(\sqrt{\frac{a}{a+b}},\sqrt{\frac{b}{a+b}}\right) \\ 
	     &= \left(1,-\sqrt{\frac{b}{a}}\right)-\left(\frac{a-b}{\sqrt{a}\sqrt{a+b}}\right)\left(\sqrt{\frac{a}{a+b}},\sqrt{\frac{b}{a+b}}\right) \\
	     &= \left(1,-\sqrt{\frac{b}{a}}\right)-\left(\frac{a-b}{a+b}\right)\left(1,\sqrt{\frac{b}{a}}\right) \\
	     &= \left(\frac{2b}{a+b},-\sqrt{\frac{b}{a}}\frac{2a}{a+b}\right)
\end{align*}
The norm of $\tilde{v_2}$ is 
\begin{align*}
  ||\tilde{v_2}||^2&=\tilde{v_2}\cdot\tilde{v_2}\\
		   &= \frac{4b^2}{(a+b)^2}+\frac{b}{a}\frac{4a^2}{(a+b)^2}\\
		   &=\frac{4b}{(a+b)^2}(a+b)= \frac{4b}{a+b}
\end{align*}
Our normalized eigenvectors are given by
\begin{align*}
  \xi_1&:= v_1/||v_1|| = \left(\sqrt{\frac{a}{a+b}},\sqrt{\frac{b}{b+a}}\right)\\
  \xi_2&:=\frac{1}{2} \sqrt{\frac{a+b}{b}}\left(\frac{2b}{a+b},-\sqrt{\frac{b}{a}}\frac{2a}{a+b}\right)=\left(\sqrt{\frac{b}{a+b}},-\sqrt{\frac{a}{a+b}}\right).
\end{align*}
We can form the orthonormal matrix of eigenvectors $P$ defined by 
\begin{equation*}
  P:= \begin{bmatrix}
    \xi_1 & \xi_2
    \end{bmatrix}=\begin{bmatrix}
  \sqrt{\frac{a}{a+b}} & \sqrt{\frac{b}{a+b}}\\
\sqrt{\frac{b}{a+b}} & -\sqrt{\frac{a}{a+b}}\end{bmatrix}
\end{equation*}
Observe also that 
\begin{align*}
  P^2 = \begin{bmatrix}
  \sqrt{\frac{a}{a+b}} & \sqrt{\frac{b}{a+b}}\\
  \sqrt{\frac{b}{a+b}} & -\sqrt{\frac{a}{a+b}}\end{bmatrix}\begin{bmatrix}
\sqrt{\frac{a}{a+b}} & \sqrt{\frac{b}{a+b}}\\
\sqrt{\frac{b}{a+b}} & -\sqrt{\frac{a}{a+b}}\end{bmatrix}=I
\end{align*}
and $P^T=P$. 
