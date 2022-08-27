function vehiclePlot(x,u,T)
    if nargin < 2
    T=0:0.01:1;
x=repmat([1;2;0],1,length(T));
u=repmat([0;0],1,length(T));
u(1,:)=0*cos(T);
x(1,:)=0*sin(T);
x(2,:)=0*cos(T);
x(3,:)=T;

    end
    close all


figure(1)
intorno=10;in=intorno;
set(gcf,'name','car parking','Menu','none','NumberT','off')
set(gca,'xlim',[-in in],'ylim',[-in in],'DataAspectRatio',[1 1 1])
grid on
box on
% plot target configuration with light colors
handles = car_plot([0 0 0 0]', [0 0]');
fcolor  = get(handles,'facecolor');
ecolor  = get(handles,'edgecolor');
fcolor  = cellfun(@(x) (x+3)/4,fcolor,'UniformOutput',false);
ecolor  = cellfun(@(x) (x+3)/4,ecolor,'UniformOutput',false);
set(handles, {'facecolor','edgecolor'}, [fcolor ecolor])


line_handle = line([0 0],[0 0],'color','b','linewidth',2);
plotFn = @(x) set(line_handle,'Xdata',x(1,:),'Ydata',x(2,:));


% animate the resulting trajectory
handles = [];
plotFn(x)
for i=1:100:length(x(1,:))

   set(0,'currentfigure',1);
   delete(handles)
   handles = car_plot(x(:,i), u(:,i));
   set(gca,'xlim',[-in+x(1,i) in+x(1,i)],'ylim',[-in+x(2,i) in+x(2,i)],'DataAspectRatio',[1 1 1])
   title(["Car at t =",num2str(T(i)),"seconds"])
   drawnow  
end


% ======== graphics functions ========
function h = car_plot(x,u)

body        = [0.9 2.1 0.3];           % body = [width length curvature]
bodycolor   = 0.5*[1 1 1];
headlights  = [0.25 0.1 .1 body(1)/2]; % headlights [width length curvature x]
lightcolor  = [1 1 0];
wheel       = [0.15 0.4 .06 1.1*body(1) -1.1 .9];  % wheels = [width length curvature x yb yf]
wheelcolor  = 'k';

h = [];

% make wheels
for front = 1:2
   for right = [-1 1]
      h(end+1) = rrect(wheel,wheelcolor)'; %#ok<AGROW>
      if front == 2
         twist(h(end),0,0,u(1))
      end
      twist(h(end),right*wheel(4),wheel(4+front))
   end
end


% make body
h(end+1) = rrect(body,bodycolor);

% make window (hard coded)
h(end+1) = patch([-.8 .8 .7 -.7],.6+.3*[1 1 -1 -1],'w');

% headlights
h(end+1) = rrect(headlights(1:3),lightcolor);
twist(h(end),headlights(4),body(2)-headlights(2))
h(end+1) = rrect(headlights(1:3),lightcolor);
twist(h(end),-headlights(4),body(2)-headlights(2))

% put rear wheels at (0,0)
twist(h,0,0)

% align to x-axis
twist(h,0,0,-pi/2)

% make origin (hard coded)
ol = 0.1;
ow = 0.01;
h(end+1) = patch(ol*[-1 1 1 -1],ow*[1 1 -1 -1],'k');
h(end+1) = patch(ow*[1 1 -1 -1],ol*[-1 1 1 -1],'k');

twist(h,x(1),x(2),x(3))

function twist(obj,x,y,theta)
% a planar twist: rotate object by theta, then translate by (x,y)
i = 1i;
if nargin == 3
   theta = 0;
end
for h = obj
   Z = get(h,'xdata') + i*get(h,'ydata');
   Z = Z * exp(i*theta);
   Z = Z + (x + i*y);
   set(h,'xdata',real(Z),'ydata',imag(Z));
end

function h = rrect(wlc, color)
% draw a rounded rectangle (using complex numbers and a kronecker sum :-)

N        = 25; % number of points per corner

width    = wlc(1);
length   = wlc(2);
curve    = wlc(3);

a        = linspace(0,2*pi,4*N);
circle   = curve*exp(1i*a);
width    = width-curve;
length   = length-curve;
rect1    = diag(width*[1 -1 -1 1] + 1i*length *[1 1 -1 -1]);
rectN    = sum(kron(rect1, ones(1,N)), 1) ;
rr       = circle + rectN;
rr       = [rr rr(1)]; % close the curve

h        = patch(real(rr),imag(rr),color);