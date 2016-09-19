function  [x,y,u] = epiUpdate(x,y,u)
% Function for arrayFun in epidemic model.

global zG;
global uG;
global pSickG;
global pCureG;
global pDeadG;
global rG;

% u = 1 => well, susceptible. 
% u = 2 => sick.
% u = 3 => cured.
% u = 4 => dead.

if u == 4, return; end

if u == 2 && rand<pDeadG, 
    u = 4; return;
end

if u == 2 && rand < pCureG,
    u = 3;
end

ind = find( (zG(:,1)-x).^2+(zG(:,2)-y).^2 < rG^2);

if u==1 && sum(find(uG(ind)==2))&& rand<pSickG
  u = 2;
end

x = x + .02*randn;
x = max(0,x);x = min(1,x);

y = y + .02*randn;
y = max(0,y);y = min(1,y);




