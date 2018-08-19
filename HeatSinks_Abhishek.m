MATLAB Program: Experimental Investigation of Convective Heat Transfer Using Different Fins


A.	Calculating the heat transfer coefficient:
Input Parameters: Heat Power (Q), Area of Base (Ab), Temperature difference (dT), Constants (a & b)

B.	Calculating Nusselt number:
Input Parameters: Thermal Conductivity (k), Hydraulic Diameter (D)

clc;
clear all;
Q=input('Enter value of Q=');
Ab=input('Enter value of Ab=');
b=input('Enter value of b=');
a=input('Enter value of a=');
dT=input('Enter value of dT=');
k=input('Enter value of k=');
D=input('Enter value of D=');
h1=input('Enter initial guess=');
acc=input('Enter value of accuracy=');
f=inline('Q-((h1*Ab)+((h1^0.5)*tanh(a*h1^0.5)*b))*dT')
df=inline('-(((Ab)+(a/2*sech(a*(h1^0.5))*sech(a*(h1^0.5)))+(b/2*tanh(a*(h1^0.5))/((h1^0.5))))*dT)')
ddf=inline('(((a*a*sech(a*(h1^0.5))*sech(a*(h1^0.5))*tanh(a*(h1^0.5)))/(2*(h1^0.5)))-((a*(h1^0.5)*sech(a*(h1^0.5))*sech(a*(h1^0.5))-tanh(a*(h1^0.5)))/(2*(h1^1.5)))*(b/2))*dT') 
f(Ab,Q,a,b,dT,h1)
df(Ab,a,b,dT,h1)
ddf(a,b,dT,h1)
z=(f(Ab,Q,a,b,dT,h1)*ddf(a,b,dT,h1))/(df(Ab,a,b,dT,h1)*df(Ab,a,b,dT,h1))
while(abs(z)>1)
    h1=input('Enter new initial guess=');
    z=(f(Ab,Q,a,b,dT,h1)*ddf(a,b,dT,h1))/(df(Ab,a,b,dT,h1)*df(Ab,a,b,dT,h1))
end
h2=h1-(f(Ab,Q,a,b,dT,h1)/df(Ab,a,b,dT,h1))
n=1;
while(abs(h2-h1)>acc)
    n=n+1;
    h1=h2
    j=f(Ab,Q,a,b,dT,h1);
    k=df(Ab,a,b,dT,h1);
    h2=h1-(j/k);  
end
Nu=(h2*D)/k;
fprintf('\nAns=%f',h2);
fprintf('\nAns=%f',n);
fprintf('\nAns=%f',Nu);
