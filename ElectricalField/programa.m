%Equipo 7
%Santiago Álvarez Valdivia A01640172
%Paulina Lizet Gutiérrez Amezcua A01639948
%Fernando Cerriteño Magaña A01702790 

function varargout = programa(varargin)
% PROGRAMA MATLAB code for programa.fig
%      PROGRAMA, by itself, creates a new PROGRAMA or raises the existing
%      singleton*.
%
%      H = PROGRAMA returns the handle to a new PROGRAMA or the handle to
%      the existing singleton*.
%
%      PROGRAMA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROGRAMA.M with the given input arguments.
%
%      PROGRAMA('Property','Value',...) creates a new PROGRAMA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before programa_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to programa_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help programa

% Last Modified by GUIDE v2.5 24-Apr-2021 11:57:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @programa_OpeningFcn, ...
                   'gui_OutputFcn',  @programa_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before programa is made visible.
function programa_OpeningFcn(hObject, eventdata, handles, varargin)
global caras;
global ancho;
global v;
global movx;
global Ex1;
global Ey1;
global Ex3;
global Ey3;
global Ex2;
global Ey2;
global Ex4;
global Ey4;
global Ez;
global vertices;
global verticesN;
global X;
global Y;
global Z;
global k;
global q2;
global q1;
global largon;
global largop;
global nglobulos;
global datos;

datos = [];

nglobulos = 0;

movx = 1;

x = -3:0.5:3;
y = -3:0.5:3;
k = 8.98e9;

xp = -movx;
q1 = 1e-6;

xn = movx;
q2 = -1e-6;

v = 0.5;
ancho = 0.2;
largop = 4;
largon = 4;

vertices = [ v -v -v; %v1
            -v -v -v; %v2
            -v  v -v; %v3
             v  v -v; %v4
             v -v  v; %v5
            -v -v  v; %v6
            -v  v  v; %v7
             v  v  v];%v8
         
verticesN = vertices;
         
vertices(:,1) = vertices(:,1)*ancho-movx;
vertices(:,2) = vertices(:,2)*largop;

verticesN(:,1) = verticesN(:,1)*ancho+movx;
verticesN(:,2) = verticesN(:,2)*largon;
         
caras = [ 1 2 6 5;
          2 3 7 6;
          3 4 8 7;
          4 1 5 8;
          5 6 7 8;
          1 2 3 4];

[X,Y] = meshgrid(x,y);

Ex1 = (k*q1*(X-xp))./(((X-xp).^2+(Y-(-largop*v)).^2).^1.5);
Ey1 = (k*q1*(Y-(-largop*v)))./(((X-xp).^2+(Y-(-largop*v)).^2).^1.5);

Ex2 = (k*q2*(X-xn))./(((X-xn).^2+(Y-(0-largon*v)).^2).^1.5);
Ey2 = (k*q2*(Y-(0-largon*v)))./(((X-xn).^2+(Y-(0-largon*v)).^2).^1.5);

Ex3 = (k*q1*(X-xp))./(((X-xp).^2+(Y-(largop*v)).^2).^1.5);
Ey3 = (k*q1*(Y-(largop*v)))./(((X-xp).^2+(Y-(largop*v)).^2).^1.5);

Ex4 = (k*q2*(X-xn))./(((X-xn).^2+(Y-(largon*v)).^2).^1.5);
Ey4 = (k*q2*(Y-(largon*v)))./(((X-xn).^2+(Y-(largon*v)).^2).^1.5);

Ex = Ex1+Ex2+Ex3+Ex4;
Ey = Ey1+Ey2+Ey3+Ey4;

Ez = Ex.*0;
Z = Ex.*0;

quiver3(X,Y,Z,Ex,Ey,Ez);
hold on;
view([-37.815 67.879])

patch('Faces',caras,'Vertices',vertices,'FaceColor','r');
patch('Faces',caras,'Vertices',verticesN,'FaceColor','b');

daspect([1 1 1]);

title("Campo eléctrico");
xlabel("x");
ylabel("y");
zlabel("z");

% Choose default command line output for programa
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes programa wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = programa_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)

    global caras;
    global ancho;
    global v;
    global movx;
    global Ex1;
    global Ey1;
    global Ex3;
    global Ey3;
    
    global Ex2;
    global Ey2;
    global Ex4;
    global Ey4;
    
    global Ez;
    global vertices;
    global verticesN;
    global X;
    global Y;
    global Z;
    global k;
    global q2;
    global largon;

    xn = movx;
    
    largon = round(get(handles.slider1,'Value'));
    verticesN = [ v -v -v; %v1
                -v -v -v; %v2
                -v  v -v; %v3
                 v  v -v; %v4
                 v -v  v; %v5
                -v -v  v; %v6
                -v  v  v; %v7
                 v  v  v];%v8

    verticesN(:,1) = verticesN(:,1)*ancho+movx;
    verticesN(:,2) = verticesN(:,2)*largon;

    Ex2 = (k*q2*(X-xn))./(((X-xn).^2+(Y+(largon*v)).^2).^1.5);
    Ey2 = (k*q2*(Y+(largon*v)))./(((X-xn).^2+(Y+(largon*v)).^2).^1.5);

    Ex4 = (k*q2*(X-xn))./(((X-xn).^2+(Y-(largon*v)).^2).^1.5);
    Ey4 = (k*q2*(Y-(largon*v)))./(((X-xn).^2+(Y-(largon*v)).^2).^1.5);

    Ex = Ex1+Ex2+Ex3+Ex4;
    Ey = Ey1+Ey2+Ey3+Ey4;

    cla;
    quiver3(X,Y,Z,Ex,Ey,Ez);
    hold on;
    view([-37.815 67.879])
    
    patch('Faces',caras,'Vertices',vertices,'FaceColor','r');
    patch('Faces',caras,'Vertices',verticesN,'FaceColor','b');

    daspect([1 1 1]);

    title("Campo eléctrico");
    xlabel("x");
    ylabel("y");
    zlabel("z");

    hold off;
    

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
    global caras;
    global ancho;
    global v;
    global movx;
    global Ex1;
    global Ey1;
    global Ex3;
    global Ey3;
    global Ex2;
    global Ey2;
    global Ex4;
    global Ey4;
    global Ez;
    global vertices;
    global verticesN;
    global X;
    global Y;
    global Z;
    global k;
    global q1;
    global largop;

    xp = -movx;

    largop = round(get(handles.slider2,'Value'));
    vertices = [ v -v -v; %v1
                -v -v -v; %v2
                -v  v -v; %v3
                 v  v -v; %v4
                 v -v  v; %v5
                -v -v  v; %v6
                -v  v  v; %v7
                 v  v  v];%v8

    vertices(:,1) = vertices(:,1)*ancho-movx;
    vertices(:,2) = vertices(:,2)*largop;

    Ex1 = (k*q1*(X-xp))./(((X-xp).^2+(Y+(largop*v)).^2).^1.5);
    Ey1 = (k*q1*(Y+(largop*v)))./(((X-xp).^2+(Y+(largop*v)).^2).^1.5);

    Ex3 = (k*q1*(X-xp))./(((X-xp).^2+(Y-(largop*v)).^2).^1.5);
    Ey3 = (k*q1*(Y-(largop*v)))./(((X-xp).^2+(Y-(largop*v)).^2).^1.5);

    Ex = Ex1+Ex2+Ex3+Ex4;
    Ey = Ey1+Ey2+Ey3+Ey4;

    cla;
    quiver3(X,Y,Z,Ex,Ey,Ez);
    hold on;
    view([-37.815 67.879])

    patch('Faces',caras,'Vertices',vertices,'FaceColor','r');
    patch('Faces',caras,'Vertices',verticesN,'FaceColor','b');

    daspect([1 1 1]);

    title("Campo eléctrico");
    xlabel("x");
    ylabel("y");
    zlabel("z");

    hold off;



% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
cla;

global caras;
global ancho;
global v;
global movx;
global Ex1;
global Ey1;
global Ex3;
global Ey3;
global Ex2;
global Ey2;
global Ex4;
global Ey4;
global Ez;
global X;
global Y;
global Z;
global k;
global q2;
global q1;
global largon;
global largop;
global vertices;
global verticesN;

movx = get(handles.slider3,'Value');

x = -3:0.5:3;
y = -3:0.5:3;

xp = -movx;
q1 = 1e-6;

xn = movx;
q2 = -1e-6;

v = 0.5;

vertices = [ v -v -v; %v1
            -v -v -v; %v2
            -v  v -v; %v3
             v  v -v; %v4
             v -v  v; %v5
            -v -v  v; %v6
            -v  v  v; %v7
             v  v  v];%v8
         
verticesN = vertices;
         
vertices(:,1) = vertices(:,1)*ancho-movx;
vertices(:,2) = vertices(:,2)*largop;

verticesN(:,1) = verticesN(:,1)*ancho+movx;
verticesN(:,2) = verticesN(:,2)*largon;

         
caras = [ 1 2 6 5;
          2 3 7 6;
          3 4 8 7;
          4 1 5 8;
          5 6 7 8;
          1 2 3 4];

[X,Y] = meshgrid(x,y);

Ex1 = (k*q1*(X-xp))./(((X-xp).^2+(Y-(-largop*v)).^2).^1.5);
Ey1 = (k*q1*(Y-(-largop*v)))./(((X-xp).^2+(Y-(-largop*v)).^2).^1.5);

Ex2 = (k*q2*(X-xn))./(((X-xn).^2+(Y-(0-largon*v)).^2).^1.5);
Ey2 = (k*q2*(Y-(0-largon*v)))./(((X-xn).^2+(Y-(0-largon*v)).^2).^1.5);

Ex3 = (k*q1*(X-xp))./(((X-xp).^2+(Y-(largop*v)).^2).^1.5);
Ey3 = (k*q1*(Y-(largop*v)))./(((X-xp).^2+(Y-(largop*v)).^2).^1.5);

Ex4 = (k*q2*(X-xn))./(((X-xn).^2+(Y-(largon*v)).^2).^1.5);
Ey4 = (k*q2*(Y-(largon*v)))./(((X-xn).^2+(Y-(largon*v)).^2).^1.5);

Ex = Ex1+Ex2+Ex3+Ex4;
Ey = Ey1+Ey2+Ey3+Ey4;

Ez = Ex.*0;
Z = Ex.*0;

quiver3(X,Y,Z,Ex,Ey,Ez);
hold on;
view([-37.815 67.879])

patch('Faces',caras,'Vertices',vertices,'FaceColor','r');
patch('Faces',caras,'Vertices',verticesN,'FaceColor','b');

daspect([1 1 1]);

title("Campo eléctrico");
xlabel("x");
ylabel("y");
zlabel("z");


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
    global nglobulos;
    global movx;
    global largon;
    global largop;
    global q1;
    global q2;
    global data;
    global datos;
    global k;
    
    set(handles.slider1,'Enable','off');
    set(handles.slider2,'Enable','off');
    set(handles.slider3,'Enable','off');
    
    k = 8.98e9;
    
    v = (movx-0.5)*10;
    PosX = randi([-v,v])/10;
    
    PosY = randi([-3*10,3*10])/10;
    
    radio = 0.3;
    [x,y,z] = sphere(10);
    x = x*radio;
    y = y*radio;
    z = z*radio;
    
    carga = 1.6e-9;
    
    hold on;
    view([-37.815 67.879])
    surf(x+PosX,y+PosY,z,'FaceColor',[0.5 0.5 0.5],'LineStyle','None', ...
    'FaceAlpha',0.5);
    
    %Punto 1
    distancias = [0.1 0.2 0.3];
    
    radio = distancias(randi([1,length(distancias)]));
    x = PosX-radio;
    y = PosY;
    z = 0;
    
    Ex1 = (k*q1*(x+movx))./(((x+movx).^2+(y-(-largop*v)).^2).^1.5);
    Ey1 = (k*q1*(y-(-largop*v)))./(((x+movx).^2+(y-(-largop*v)).^2).^1.5);

    Ex2 = (k*q2*(x-movx))./(((x-movx).^2+(y-(0-largon*v)).^2).^1.5);
    Ey2 = (k*q2*(y+(largon*v)))./(((x-movx).^2+(y-(0-largon*v)).^2).^1.5);

    Ex3 = (k*q1*(x+movx))./(((x+movx).^2+(y-(largop*v)).^2).^1.5);
    Ey3 = (k*q1*(y-(largop*v)))./(((x+movx).^2+(y-(largop*v)).^2).^1.5);

    Ex4 = (k*q2*(x-movx))./(((x-movx).^2+(y-(largon*v)).^2).^1.5);
    Ey4 = (k*q2*(y-(largon*v)))./(((x-movx).^2+(y-(largon*v)).^2).^1.5);

    Ex11 = Ex1+Ex2+Ex3+Ex4;
    Ey11 = Ey1+Ey2+Ey3+Ey4;
    
    [px,py,pz] = sphere(6);
    px = px*0.1;
    py = py*0.1;
    pz = pz*0.1;
    surf(px+x,py+y,pz,'FaceColor','b','LineStyle','None');
    
    
    %Punto 2
    x = PosX+radio;
    y = PosY;
    z = 0;
    
    Ex1 = (k*q1*(x+movx))./(((x+movx).^2+(y-(-largop*v)).^2).^1.5);
    Ey1 = (k*q1*(y-(-largop*v)))./(((x+movx).^2+(y-(-largop*v)).^2).^1.5);

    Ex2 = (k*q2*(x-movx))./(((x-movx).^2+(y-(0-largon*v)).^2).^1.5);
    Ey2 = (k*q2*(y+(largon*v)))./(((x-movx).^2+(y-(0-largon*v)).^2).^1.5);

    Ex3 = (k*q1*(x+movx))./(((x+movx).^2+(y-(largop*v)).^2).^1.5);
    Ey3 = (k*q1*(y-(largop*v)))./(((x+movx).^2+(y-(largop*v)).^2).^1.5);

    Ex4 = (k*q2*(x-movx))./(((x-movx).^2+(y-(largon*v)).^2).^1.5);
    Ey4 = (k*q2*(y-(largon*v)))./(((x-movx).^2+(y-(largon*v)).^2).^1.5);

    Ex22 = Ex1+Ex2+Ex3+Ex4;
    Ey22 = Ey1+Ey2+Ey3+Ey4;
    
    [px,py,pz] = sphere(6);
    px = px*0.1;
    py = py*0.1;
    pz = pz*0.1;
    surf(px+x,py+y,pz,'FaceColor','b','LineStyle','None');
    
    Et = sqrt((Ex11-Ex22)^2+(Ey11-Ey22)^2);
    Ft = Et*carga;
    disp(Ft)
    
    if(9.3563e-9 < Ft)
        fila = {radio,PosX,PosY,Et,Ft,'S'};
    else
        fila = {radio,PosX,PosY,Et,Ft,'N'};
    end
    
    datos = vertcat(datos,fila);
    set(handles.uitable,'data',datos);
    
    nglobulos = nglobulos + 1;
    
    if (nglobulos == 5)
        set(handles.pushbutton1,'Enable','off');
    end
