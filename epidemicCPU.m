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
pSickG = .008;
pCureG = .004;
pDeadG = .008;
rG = .02;

% Set the population size. 
n = 5000;

% Generate the starting positions and start with
%  everyone well. 
x = rand(n,1);
y = rand(n,1);
u = ones(n,1);

% Now make some of them sick. 
%worldmap world;
%plotm(lat, long)
% Uncomment for smsll infected group near the 
% center. 
%indx = find(abs(x-.5)<.1);
%indy = find(abs(y(indx)-.5)<.1);
%ind = indx(indy);

% Uncomment for randomly placed infected group. 
k = 10;
ind = randperm(n,k);

% Make the designated group sick. 
u(ind) = 2;

% Plot the initial population. 
figure(1); plot(x,y,'green.');hold on;
%ind = find(u==2);
plot(x(ind),y(ind),'red.');hold off;

itmax = 350;

itno = 0; healthy = sum(u==1); 
sick = sum(u==2); cured = 0; dead = 0;

fprintf('\n CPU run: population size %d', n);
fprintf('\n It No, Healthy, Sick, Cured, Dead');
fprintf('\n %6d %6d %6d %6d %6d',itno,healthy,sick,cured,dead);
pause;

aveItTime = 0;



% Compute the spread of the infection. 
for itno = 1:itmax

  % Set tic and toc to exclude plotting & printing.
  t = tic;

  zG = [x y]; uG = u;
  [x,y,u] = arrayfun(@epiUpdate,x,y,u);

  aveItTime = aveItTime + toc(t);

  ind = find(u==1);
  figure(1); clf;
  plot(x(ind),y(ind),'green.');hold on;
  ind = find(u==2);
  plot(x(ind),y(ind),'red.');
  ind = find(u==3);
  plot(x(ind),y(ind),'blue.');axis([0 1 0 1]);
  ind = find(u==4);
  plot(x(ind),y(ind),'black.');axis([0 1 0 1]);
  title(['Iteration ' num2str(itno)]);
  drawnow; hold off;
  %pause(.1);

  healthy = sum(u==1); sick = sum(u==2);
  cured = sum(u==3); dead = sum(u==4);
  fprintf('\n %6d %6d %6d %6d %6d',itno,healthy,sick,cured,dead);

  if sum(u==2)==0, break; end

end

fprintf('\n\n Average time per iteration = %g\n',itno\aveItTime);



