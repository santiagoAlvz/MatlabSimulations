% Santiago Álvarez Valdivia A01640172
% César H. Hernández A01636734
% Diego Rosas A01634154

%Variables de entorno
my0 = pi*4e-7; %Permeabilidad del vacío
I1 = 12;
a1 = 0.1;
r2 = 20.3;
R = ((r2*2*pi)*4.9e-7)/(pi*10^2); %Suponiendo el anillo tenga un grosor de 20mm
m1 = 1;

t = 0:0.01:1.4;
g = -9.81;
poi = 0.10;

%Definición de funciones diferenciales dv/dt y dx/dt
func1 = @(x,v) -9.81-(9.*x.^2.*my0.^2.*I1.^2.*a1.^6.*pi.^2.*r2.^2.*v)./(m1*4*R*(a1.^2+x.^2).^5);
func2 = @(t,v) v;

%Crea un vector x, para almacenar las posiciones
x = zeros(length(t),1);
x(1) = poi;

%Crea un vector v, para almacenar las velocidades
v = zeros(length(t),1);
[vx,vv] = rk4(func1,func2,t,x,v,0.01);
corriente = (3*a1.^4*I1*pi*my0.*vx.*vv)./(2*(a1^2+vx.^2).^(5/2))/R;
aceleracion = diff(vv)./t(2);

%Graficación Posición
subplot(2,2,1);
plot(t,vx);
hold on;
grid on;
title("Posición de la cabina");
plot(t,poi+(g*t.^2)/2);
xlabel("tiempo(s)");
ylabel("Posición (m)");
ylim([-.1 .1])
yline(0);

[valor0,pos] = min(abs(vx));
xline(t(pos),"r");
legend(["Frenado" "Caida normal"]);

%Graficación Velocidad
subplot(2,2,2);
plot(t,vv);
hold on;
grid on;
title("Velocidad de la cabina");
xlabel("tiempo(s)");
ylabel("Velocidad (m/s)");
yline(0);
%ylim([-0.1 0.1]); 
xline(t(pos),"r","Llegada al piso");

%Graficación Aceleración
subplot(2,2,3);
plot(t(1:length(t)-1),aceleracion);
hold on;
grid on;
title("Aceleración de la cabina");
xlabel("tiempo(s)");
ylabel("Aceleración (m/s²)");
yline(0);
xline(t(pos),"r","Llegada al piso");

%Graficación Corriente
subplot(2,2,4);
plot(t,corriente);
hold on;
grid on;
title("Corriente inducida en el anillo");
xlabel("tiempo(s)");
ylabel("Corriente (A)");
yline(0);
xline(t(pos),"r","Llegada al piso");


function [x,v] = rk4(f_1,f_2,t,x,v,h)
%Ejecuta el método RK4 para los parámetros proporcionados
    for i=1:(length(x)-1) %Para cada elemento a calcular
        %Calcula la siguiente posición, con la velocidad actual
        k_1 = f_2(t(i),v(i));
        k_2 = f_2(t(i)+h/2,v(i)+h*k_1/2);
        k_3 = f_2(t(i)+h/2,v(i)+h*k_2/2);
        k_4 = f_2(t(i)+h,v(i)+h*k_3);
        x(i+1) = x(i)+(k_1+2*k_2+2*k_3+k_4)*h/6;
        
        %Calcula la siguiente velocidad, con la posición y velocidad
        %actuales
        k_1 = f_1(x(i),v(i));
        k_2 = f_1(x(i)+h/2,v(i)+h*k_1/2);
        k_3 = f_1(x(i)+h/2,v(i)+h*k_2/2);
        k_4 = f_1(x(i)+h,v(i)+h*k_3);
        v(i+1) = v(i)+(k_1+2*k_2+2*k_3+k_4)*h/6;        
    end
    
end
