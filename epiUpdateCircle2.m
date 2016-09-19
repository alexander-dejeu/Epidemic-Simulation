function  [r,theta,u] = epiUpdateCircle2(r,theta,u)
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
x=r.*cos(theta);
y=r.*sin(theta);
ind = find( (zG(:,1)-x).^2+(zG(:,2)-y).^2 < rG^2);
%ind = find(r<rG)
if u==1 && sum(find(uG(ind)==2))&& rand<pSickG
  u = 2;
end

r = r + .02*randn;
%x = max(0,x); x = min(1,x);
%r=mod(r,1);
r=max(0,r); r=min(1,r);

theta = theta + 0.05*randn;%.02*randn;
%y = max(0,y);y = min(1,y);
%theta=mod(theta,2*pi);




