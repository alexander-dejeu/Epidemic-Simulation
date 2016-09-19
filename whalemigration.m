% This version uses zG = nx2 instead of complex zG. 

% This version runs on a CPU. Global variables, which 
% MATLAB supports on CPUs, are used to pass variable 
% values to the grid updating routine. 

global zG;
global uG;
global pSickG; % Probablity of getting sick.
global pCureG; % Probablity of being cured. 
global pDeadG; % Probablity of dying. 
global rG; % Infectiousness distance. 

% Set the parameters for the epidemic.
pSickG = .9;
pCureG = .2;
pDeadG = .2;
rG = .02;

% Set the population size. 
n = 10000;

% Generate the starting positions and start with
%  everyone well. 
r = rand(n,1);
theta = 2*pi*rand(n,1);
u = ones(n,1);

%for the second circle
r1 = rand(n,1);
theta1 = 2*pi*rand(n,1);
u1 = ones(n,1);
% Now make some of them sick. 

% Uncomment for small infected group near the 
% center. 
ind = find(r<.1);
%ind=indx;
%indy = find(abs(y(indx)-.5)<.1);
%ind = indx(indy);
%u(ind) = 2;
% Uncomment for randomly placed infected group. 
% k = 5;
% ind = randperm(n,k);

% Make the designated group sick. 
u(ind) = 2;

% Plot the initial population. 
figure(1); plot(r(ind).*cos(theta(ind))-2,r(ind).*sin(theta(ind))-2,'green.');hold on;
ind = find(u==2);
plot(r(ind).*cos(theta(ind)),r(ind).*sin(theta(ind)),'red.');hold off;

itmax = 150;

itno = 0; healthy = sum(u==1); 
sick = sum(u==2); cured = 0; dead = 0;

fprintf('\n CPU run: population size %d', n);
fprintf('\n It No, Healthy, Sick, Cured, Dead');
fprintf('\n %6d %6d %6d %6d %6d',itno,healthy,sick,cured,dead);
pause;

aveItTime = 0;