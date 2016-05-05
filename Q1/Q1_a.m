%% Creating an array to represent the maze
clc; clear;
Maze=zeros(12,16);

% Numbering is from the bottom left.
Maze(1,1:5)=1; Maze(1,8:10)=1;
Maze(1:8,5)=1; Maze(1:3,10)=1; Maze(3,10:12)=1;
Maze(2,14:15)=1; Maze(3,15)=1; 
Maze(5,8:11)=1; Maze(5:11,8)=1; Maze(11,5:8)=1; Maze(10,3:5)=1;Maze(7:10,3)=1; 
Maze(12,1:2)=1;
Maze(5:10,14)=1; Maze(7,10:14)=1; Maze(7:9,10)=1; Maze(10:11,11)=1;


Start=[1,6];
Goal=[4,16];

%% Implementing Depth First Search for North-East-South-West
forbiddenZone=Maze;
global found finalpath;

found=0;
path=[];
keepgoing_a(Start,forbiddenZone,Goal,path);

%% Plotting the maze

[X,Y]=meshgrid(1:16,1:12);
X=X(:);
Y=Y(:);
Z=Maze(:);

figure(1)
scatter(X,Y,20,Z);
colormap winter
hold on;
%% Plotting the solution

linInd=sub2ind(size(Maze),finalpath(:,1),finalpath(:,2));

path=zeros(size(Maze));

for i=1:length(linInd);
    path(linInd)=1-path(linInd);
end

[row_0,col_0]=find(path==0);
linInd_0=sub2ind(size(Maze),row_0,col_0);

[~,ia,~]=intersect(linInd,linInd_0);
linInd(ia)=[];

% Creating lines between consecutive points
count=1;
for i=1:length(linInd)-1
    [x,y]=ind2sub(size(Maze),linInd(i));
    [x_,y_]=ind2sub(size(Maze),linInd(i+1));
    text(y_,x_,num2str(count));
    count=count+1;
    plot([y,y_],[x,x_],'black','LineWidth',2.0);
end
text(Goal(2),Goal(1),num2str(count));
plot([Goal(2),y_],[Goal(1),x_],'black','LineWidth',2.0)
[row,col]=find(path==1);
title(['Number of steps: ',num2str(count)]);
xlim([0 17])
ylim([0 13])
xlabel('Green: Obstacle, Blue: Free Path, Black: Shortest Path')
% scatter(col,row,'red')
