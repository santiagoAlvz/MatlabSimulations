%Simula la trayectoria de un material sólido arrojado desde un volcán
%Autores: Santiago Álvarez Valdivia, Ruy Guzman Camacho,
% Carlos Antonio Solano Vega, Lucio Emmanuel Becerril Bueno, José Pablo Naime Garcia 

%Parámetros de entrada
angulo = deg2rad(input("Angulo de disparo: "))
v0 = input("Velocidad inicial: ");
h0 = input("Altura del volcán: ");
Cdrag = input("Resistencia del aire: ");

%Se realizan los cálculos correspondientes
g = 9.81;
densidadA = 1.2;
densidadP = 70;
masa = 1;
cambioT = 0.01;

volumen = masa/densidadP;
radio = 0.1505;
areaP = radio ^2 * pi;
b = .5 * densidadA * Cdrag * areaP;

t = -1 * cambioT;

v0x = v0 * cos(angulo);
v0y = v0 * sin(angulo);

y = h0 - v0y * cambioT - g * cambioT^2;
x = 0 - v0x * cambioT;

ylista = [y,h0];
xlista = [x,0];

i  = 2;

y = 0;

velocidadesx = [0];
velocidadesy = [0];

%Se calculan la posición y la velocidad a cada instante
while (y >= 0 )
    velocidadesx(end+1) = (xlista(i) - xlista(i-1))/cambioT;
    velocidadesy(end+1) = (ylista(i) - ylista(i-1))/cambioT;
    
    x = (2* xlista(i) - xlista(i-1)) - (velocidadesx(end))^2 * (b/masa)* cambioT^2;
    y = (2* ylista(i) - ylista(i-1)) - (velocidadesy(end))^2 * (b/masa)* cambioT^2 - g * cambioT^2;

    xlista(end + 1) = x;
    ylista(end + 1) = y;

    t = t + cambioT;
    i = i + 1;
end

%Se 
ha = subplot(1,3,3);

pos = get(ha,'Position');
un = get(ha,'Units');
velocidadesx(end+1) = 0;
velocidadesy(end+1) = 0;
tiempos = -cambioT:cambioT:t+cambioT*2;

ht = uitable('Units',un,'Data',[tiempos',xlista',ylista',velocidadesx',velocidadesy'], 'Position',pos,'ColumnName',{'Tiempo','x','y','Velocidad x','Velocidad y'},'RowName',{});

subplot(1,3,[1,2])
x2 = -pi:0.1:pi;
y2 = cos(x2)*(h0/2)+(h0/2);
plot(x2,y2);

xlabel('Distancia (m)');
ylabel('Altura (m)');
title("Trayectoria del proyectil de un volcán");

hold on

xlim([-pi xlista(end)+5]);
ylim([0 max(ylista)+5]);
comet(xlista,ylista);

disp("Tiempo de vuelo: " + t)
disp("Alcance: " + xlista(end))
disp("Altura maxima: " + max(ylista))