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

GoalInd=sub2ind(size(Maze),Goal(1),Goal(2));
%% Implementing Depth First Search for West-East-South-North
forbiddenZone=Maze;
global found;
found=0;
path=[];
thisPosition=Start;
waiting=[];
stack=sub2ind(size(Maze),Start(1),Start(2));

backPointerBook=zeros(12*16,1);
backPointerBook(sub2ind(size(Maze),Start(1),Start(2)))=NaN;
nextBackPointerStack=[];

thisBackPointerStack=NaN;


%% Beginning the BFS
while(1)
    clc
    waiting=[];
    nextBackPointerStack=[];
    % Go North
    northPosition=[thisPosition(1)+1,thisPosition(2)];
    % Go East
    eastPosition=[thisPosition(1),thisPosition(2)+1];
    % Go South
    southPosition=[thisPosition(1)-1,thisPosition(2)];
    % Go West
    westPosition=[thisPosition(1),thisPosition(2)-1];
    
    if isvalid(northPosition)
        northInd=sub2ind(size(Maze),northPosition(1),northPosition(2));
        if ~isrepeated(northInd,stack)
            if ~isforbidden(northInd,forbiddenZone)
                waiting=cat(2,waiting,northInd);
            end
        end
    end
    
    if isvalid(eastPosition) 
        eastInd=sub2ind(size(Maze),eastPosition(1),eastPosition(2));
        if ~isrepeated(eastInd,stack)
            if ~isforbidden(eastInd,forbiddenZone)
                waiting=cat(2,waiting,eastInd);
            end
        end
    end
    
    if isvalid(southPosition)
        southInd=sub2ind(size(Maze),southPosition(1),southPosition(2));
        if ~isrepeated(southInd,stack)
            if ~isforbidden(southInd,forbiddenZone)
                waiting=cat(2,waiting,southInd);
            end
        end
    end
    
    if isvalid(westPosition)
        westInd=sub2ind(size(Maze),westPosition(1),westPosition(2));
        if ~isrepeated(westInd,stack)
            if ~isforbidden(westInd,forbiddenZone)
                waiting=cat(2,waiting,westInd);
            end
        end
    end
    
    nextBackPointer=sub2ind(size(Maze),thisPosition(1),thisPosition(2));
    nextBackPointer=repmat(nextBackPointer,[1,length(waiting)]);
    nextBackPointerStack=cat(2,nextBackPointerStack,nextBackPointer);
    
    % Pop the first element
    popped=stack(1);
    stack(1)=[];
  
    
    % Assigning backpointers
    backPointerBook(popped)= thisBackPointerStack(1);
     
    thisBackPointerStack(1)=[];
    
    %  Making this point forbidden
    forbiddenZone(popped)=1;
    
    % Checking if the popped element is the Goal
    if popped==GoalInd
        disp('Goal Found');
        break;
    end
    
    % If popped element is not the Goal then, add the remaining elements to
    % stack
    
    stack=cat(2,stack,waiting);
    
    % Adding the backpointers to this queue
    thisBackPointerStack=cat(2,thisBackPointerStack,nextBackPointerStack);
    
    % Updating this position
    [thisPosition(1),thisPosition(2)]=ind2sub(size(Maze),stack(1));
%     thisPosition
end
%% Plotting the Maze


[X,Y]=meshgrid(1:16,1:12);
X=X(:);
Y=Y(:);
Z=Maze(:);

figure(1)
scatter(X,Y,20,Z);
colormap winter
hold on;

%% Finding path from beginning to the end
this=GoalInd;
linInd=this;

while(1)
    
    backtrack=backPointerBook(this);
    if isnan(backtrack)
        break;
    end
    linInd=cat(1,linInd,backtrack);
    this=backtrack;
    
end
linInd=fliplr(linInd');
% Creating lines between consecutive points
count=1;
for i=1:length(linInd)-1
    [x,y]=ind2sub(size(Maze),linInd(i));
    [x_,y_]=ind2sub(size(Maze),linInd(i+1));
    text(y_,x_,num2str(count));
    count=count+1;
    plot([y,y_],[x,x_],'black','LineWidth',2.0);
end
[row,col]=find(path==1);
title(['Number of steps: ',num2str(count-1)]);
xlim([0 17])
ylim([0 13])

xlabel('Green: Obstacle, Blue: Free Path, Black: Shortest Path')
