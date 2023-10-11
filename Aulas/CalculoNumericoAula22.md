## Cálculo Numérico (Aula 22) - Integração Numérica

**MainQuadExample1.m**
```
clc; clear; close all;

f = @(x) exp(-x.^2); a = 0.0; b = 1.0;

I_L    = (b-a)*f(a)
I_R    = (b-a)*f(b)
I_M    = (b-a)*f(0.5*(a+b))
I_T    = (b-a)*(f(a)+f(b))/2
I_S    = (b-a)*(f(a)+4*f(0.5*(a+b))+f(b))/6
I_true = quad(f,a,b)

error_L = abs(I_L-I_true)/abs(I_true)
error_R = abs(I_R-I_true)/abs(I_true)
error_M = abs(I_M-I_true)/abs(I_true)
error_T = abs(I_T-I_true)/abs(I_true)
error_S = abs(I_S-I_true)/abs(I_true)

xtrue = -2:0.01:2; 
ytrue = f(xtrue);
x     = a:0.01:b; y = f(x); N = length(x);
yL    = f(a)*ones(N,1); 
yR    = f(b)*ones(N,1); 
yM    = f(0.5*(a+b))*ones(N,1);
coefs = polyfit([a b],[f(a) f(b)],1);
yT    = polyval(coefs,x);
coefs = polyfit([a (a+b)/2 b],[f(a) f((a+b)/2) f(b)],2);
yS    = polyval(coefs,x);

figure(1)
area(x,y,'FaceColor',[0.9 0.9 0.9],'EdgeColor',[1 1 1]);
hold on
plot(xtrue,ytrue ,'LineWidth',2,'Color','b');
plot(x,yL,'LineWidth',2,'Color',[255,179, 71]/255);
plot(x,yR,'LineWidth',2,'Color',[254,254, 34]/255);
plot(x,yM,'LineWidth',2,'Color',[250,128,114]/255);
plot(x,yT,'LineWidth',2,'Color',[224,176,255]/255);
plot(x,yS,'LineWidth',2,'Color',[206,255,  0]/255);
hold off
set(gca,'FontSize',18); xlim([-2 2]); ylim([0 1.2]);
```

**MainQuadExample2.m**
```
clc; clear; close all;

f = @(x) x.^3 + 2*x.^2 + 3*x + 4; a = 0.0; b = 1.0;

I_L    = (b-a)*f(a)
I_R    = (b-a)*f(b)
I_M    = (b-a)*f(0.5*(a+b))
I_T    = (b-a)*(f(a)+f(b))/2
I_S    = (b-a)*(f(a)+4*f(0.5*(a+b))+f(b))/6
I_true = quad(f,a,b)

error_L = abs(I_L-I_true)/abs(I_true)
error_R = abs(I_R-I_true)/abs(I_true)
error_M = abs(I_M-I_true)/abs(I_true)
error_T = abs(I_T-I_true)/abs(I_true)
error_S = abs(I_S-I_true)/abs(I_true)

xtrue = -2:0.01:2; 
ytrue = f(xtrue);
x     = a:0.01:b; 
y     = f(x); 
N     = length(x);
yL    = f(a)*ones(N,1); 
yR    = f(b)*ones(N,1); 
yM    = f(0.5*(a+b))*ones(N,1);
coefs = polyfit([a b],[f(a) f(b)],1); 
yT    = polyval(coefs,x);
coefs = polyfit([a (a+b)/2 b],[f(a) f((a+b)/2) f(b)],2);
yS    = polyval(coefs,x);

figure(1)
area(x,y,'FaceColor',[0.9 0.9 0.9],'EdgeColor',[1 1 1]);
hold on
plot(xtrue,ytrue ,'LineWidth',2,'Color','b');
plot(x,yL,'LineWidth',2,'Color',[255,179, 71]/255);
plot(x,yR,'LineWidth',2,'Color',[254,254, 34]/255);
plot(x,yM,'LineWidth',2,'Color',[250,128,114]/255);
plot(x,yT,'LineWidth',2,'Color',[224,176,255]/255);
plot(x,yS,'LineWidth',2,'Color',[206,255,  0]/255);
hold off
set(gca,'FontSize',18); xlim([-2 2]); ylim([0 15]);
```

**QuadMid.m**
```
function I = QuadMid(f,a,b,N)
	dx = (b-a)/N;
	I = 0.0;
    for n=1:N
        xm = a + (n-0.5)*dx;
    	I = I + f(xm);
    end
    I = dx*I;
end
```

**QuadTrap.m**
```
function I = QuadTrap(f,a,b,N)
	dx = (b-a)/N;
	I = 0.0;
    for n=1:N
		x0 = a + (n-1)*dx;
		x1 = a +     n*dx;
    	I = I + f(x0)+f(x1);
    end
    I = 0.5*dx*I;
end
```

**QuadSimp.m**
```
function I = QuadSimp(f,a,b,N)
	if mod(N,2) ~= 0
    	error('N deve ser par');
	end
	dx = (b-a)/N;
	I = 0.0;
    for n=1:N/2
		x0 = a + (2*n-2)*dx;
		x1 = a + (2*n-1)*dx;
		x2 = a + 2*n*dx;
    	I = I + f(x0) + 4*f(x1) + f(x2);
    end
    I = (dx/3)*I;
end
```

**MainQuadExample3.m**
```
clc; clear; close all;

f = @(x) cos(2*x);
a = -1; 
b = 4; 
N = 20;

I_M    =  QuadMid(f,a,b,N)
I_T    = QuadTrap(f,a,b,N)
I_S    = QuadSimp(f,a,b,N)
I_true = quad(f,a,b)

error_M = abs(I_M-I_true)/abs(I_true)
error_T = abs(I_T-I_true)/abs(I_true)
error_S = abs(I_S-I_true)/abs(I_true)
```
