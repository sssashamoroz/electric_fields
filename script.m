clc, clear all;

%Constants
k = 9*10e9;

%User inputs
n_1 = input("Plate A length: ");
n_2 = input("Plate B length: ");
d = input("Distance Between Plates: ");

%Creating field
x = -10:0.5:10;
y = -10:0.5:10;

[X, Y] = meshgrid(x, y);

E_X = zeros([41, 41]);  
E_Y = zeros([41, 41]);

counter_P1 = -n_1/2;
while counter_P1 < n_1/2
    Q_1p = [-d/2, counter_P1]; 
    Q_1c = 0.3*10^(-6); 
    
    %VECTOR R for charge 1
    R1_x = X - Q_1p(1);
    R1_y = Y - Q_1p(2);
    R1= sqrt((R1_x).^2 + (R1_y).^2);

    %Electric field for both components in x, y [i, j]
    E1_x = ((k * Q_1c)./(R1.^3)) .* R1_x;
    E1_y = ((k * Q_1c)./(R1.^3)) .* R1_y;
    
    E_X = E_X + E1_x;
    E_Y = E_Y + E1_y;
    
    counter_P1 = counter_P1 + 0.5;
end 


counter_P2 = -n_2/2;
while counter_P2 < n_2/2
    Q_2p = [d/2, counter_P2]; 
    Q_2c = -0.3*10^(-6); 
    
    %VECTOR R for charge 2
    R2_x = X - Q_2p(1);
    R2_y = Y - Q_2p(2);
    R2 = sqrt((R2_x).^2 + (R2_y).^2);

    %Electric field for both components in x, y [i, j]
    E2_x = ((k * Q_2c)./(R2.^3)) .* R2_x;
    E2_y = ((k * Q_2c)./(R2.^3)) .* R2_y;

    
    E_X = E_X + E2_x;
    E_Y = E_Y + E2_y;
    
    counter_P2 = counter_P2 + 0.5;
end 

U = E_X./sqrt(E_X.^2+E_Y.^2);
V = E_Y./sqrt(E_X.^2+E_Y.^2);

%Graph Field
quiver(X, Y, U, V, 'k');
axis([-10 10 -10 10])

%Graph Rectangles
h=rectangle('Position',[-(d/2)-.25,-n_1/2,.5,n_1]);
set(h,'Facecolor','r','Edgecolor','r');

h=rectangle('Position',[(d/2)-.25,-n_2/2,.5,n_2]);
set(h,'Facecolor','b','Edgecolor','b');