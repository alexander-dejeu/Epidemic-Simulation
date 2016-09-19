% This version uses zG = nx2 instead of complex zG. 

% This version runs on a CPU. Global variables, which 
% MATLAB supports on CPUs, are used to pass variable 
% values to the grid updating routine. 

%global zG;
global uG;
global pSickG; % Probablity of getting sick.
global pCureG; % Probablity of being cured. 
global pDeadG; % Probablity of dying. 
global rG; % Infectiousness distance. 
global foodleftG; 

% Set the population size. 
n = 1000; 

% Set the parameters for the epidemic.
pSickG = .9;
pCureG = .2;
pDeadG = .2;
rG = .02;
foodleftG = 50*ones(n,1);



% Generate the starting positions and start with
%  everyone well. 
r = rand(n,1);
theta = 2*pi*rand(n,1);

u = ones(n,1);
fleft = foodleftG;
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
figure(1); plot(r(ind).*cos(theta(ind)),r(ind).*sin(theta(ind)),'green.');hold on;
ind = find(u==2);
plot(r(ind).*cos(theta(ind)),r(ind).*sin(theta(ind)),'red.');hold off;

itmax = 150;
avgfood = mean(fleft);
itno = 0; healthy = sum(u==1); 
sick = sum(u==2); cured = 0; dead = 0;

fprintf('\n CPU run: population size %d', n);
fprintf('\n It No, Healthy, Sick, Cured, Dead, Average Food');
fprintf('\n %6d %6d %6d %6d %6d %6d',itno,healthy,sick,cured,dead,avgfood);
pause;

aveItTime = 0;

% Compute the spread of the infection. 
for itno = 1:itmax

  % Set tic and toc to exclude plotting & printing.
  t = tic;

  zG = [r.*cos(theta) r.*sin(theta)]; uG = u; 
  yG=zG(:,2);
  [r,theta,u, fleft] = arrayfun(@epiUpdateCircle,r,theta,u,fleft,yG);
    
  aveItTime = aveItTime + toc(t);

  ind = find(u==1);
  figure(1); clf;
  plot(r(ind).*cos(theta(ind)),r(ind).*sin(theta(ind)),'green.');hold on;
  ind = find(u==2);
  plot(r(ind).*cos(theta(ind)),r(ind).*sin(theta(ind)),'red.');
  ind = find(u==3);
  plot(r(ind).*cos(theta(ind)),r(ind).*sin(theta(ind)),'blue.');%axis([0 1.1 0 1.1]);
  ind = find(u==4);
  plot(r(ind).*cos(theta(ind)),r(ind).*sin(theta(ind)),'black.');%axis([0 1.1 0 1.1]);
  title(['Iteration ' num2str(itno)]);
  drawnow; hold off;
  %pause(.1);
foodleftG=fleft;
  healthy = sum(u==1); sick = sum(u==2);
  cured = sum(u==3); dead = sum(u==4);
  avgfood = round(mean(fleft));
  fprintf('\n %6d %6d %6d %6d %6d %6d',itno,healthy,sick,cured,dead,avgfood);

  if sum(u==2)==0, break; end

end

fprintf('\n\n Average time per iteration = %g\n',itno\aveItTime);



