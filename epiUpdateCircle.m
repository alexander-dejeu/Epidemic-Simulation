function  [r,theta,u, fleft] = epiUpdateCircle(r,theta,u,fleft,yG)
% Function for arrayFun in epidemic model.

%global zG;
global uG;
global pSickG;
global pCureG;
global pDeadG;
global rG;
global foodleftG;

% u = 1 => well, susceptible. 
% u = 2 => sick. hungry
% u = 3 => cured. fed
% u = 4 => dead.
%coor1 = find(zG(:,2));

%fprintf('%6d \n',coor1);
% (u == 2) & 
%coor2 = zG(2)
%yG
%fprintf('\n %2f',coor1);
if  (yG > 0.5),
    %fprintf('This is printing');
    %fprintf('does this hu == 1 && ( zG(:,2) > 0.7 )p')
   u = 3;
   fleft = 50;

end
% if  ((u == 1) & zG(2) > 0.263),
%     %fprintf('does this hu == 1 && ( zG(:,2) > 0.7 )p')
%    u = 3;
%    fleft = 50;
% 
% end
if u == 4, return; end
if u == 3, 
    %fprintf('This is printing');
    return; 
end
if u == 2 && fleft<=0%rand<pDeadG, 
    u = 4; return;
end

%if u == 2 && rand < pCureG,
%    u = 3;
%end
% r = rand(1,1);
% theta = 2*pi*rand(1,1);

%ind = find( (zG(:,1)-x).^2+(zG(:,2)-y).^2 < rG^2);
%ind = find(r<rG)
if u==1 && fleft<10%sum(find(uG(ind)==2))&& rand<pSickG
  u = 2;
end

r = r + .2*randn;
%x = max(0,x); x = min(1,x);
%r=mod(r,1);
r=max(0,r); r=min(1,r);
fleft=fleft-1;

theta = theta + 0.05*randn;%.02*randn;

% x=r.*cos(theta);
% y=r.*sin(theta);
%y = max(0,y);y = min(1,y);
%theta=mod(theta,2*pi);




