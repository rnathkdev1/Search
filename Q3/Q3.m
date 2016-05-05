%% Important Variable names

% Priority Queue - priorityQueue
% Cost To Node Table - costToNodeBook
% List of backpointers - backPointerBook

%% Creating the Graph
clc; clear;

G=GraphNode('G',[],[],[],0,0,0,7);
D=GraphNode('D',[],[],G,0,0,2,5);
E=GraphNode('E',G,[],[],7,0,0,6);
C=GraphNode('C',D,G,E,2,10,2,4);
A=GraphNode('A',[],D,C,0,4,3,2);
B=GraphNode('B',C,E,[],2,1,0,3);
S=GraphNode('S',A,C,B,1,8,2,1);

% This is a mapping of node numbers to node letters
mappingLeft=['S';'A';'B';'C';'D';'E';'G'];
mappingRight=[1; 2; 3; 4; 5; 6; 7];

%% Performing the Uniform Cost Search
Goal=G;

backPointerBook=char(zeros(7,1));
costToNodeBook=zeros(7,1);

thisPosition=S;
priorityQueue=S;
thisCost=0;
thisBackPointerStack='0';
thisCostToNode=[];
Iter=0;
while(1)
    Iter=Iter+1;
    nextStack=[];
    nextCost=[];
    nextBackPointerStack=[];
    
    % There are 3 moves possible for the next item
    
    
    if ~isempty(thisPosition.left_node)
        nextStack=cat(2,nextStack,thisPosition.left_node);
        nextCost=cat(2,nextCost,thisCost(1)+thisPosition.cost_left);
        nextBackPointerStack=cat(2,nextBackPointerStack,thisPosition.name);
    end
    
    if ~isempty(thisPosition.center_node)
        nextStack=cat(2,nextStack,thisPosition.center_node);
        nextCost=cat(2,nextCost,thisCost(1)+thisPosition.cost_center);
        nextBackPointerStack=cat(2,nextBackPointerStack,thisPosition.name);
    end
    
    if ~isempty(thisPosition.right_node)
        nextStack=cat(2,nextStack,thisPosition.right_node);
        nextCost=cat(2,nextCost,thisCost(1)+thisPosition.cost_right);
        nextBackPointerStack=cat(2,nextBackPointerStack,thisPosition.name);
    end
    
    %% DISPLAYING STATUS OF QUEUE AND COSTS
    fprintf('Iter %d:\n',Iter);
    fprintf('Queue:\n')
    fprintf('[');
    fprintf(' %s',priorityQueue.name);
    fprintf(']');
    if ~isempty(nextStack)
        fprintf('%s ',nextStack.name);
    end
    fprintf('\n');
    fprintf('Costs:\n')
    fprintf('[');
    fprintf('%d ',thisCost);
    fprintf(']');
    if ~isempty(nextStack)
        fprintf(' %d',nextCost);
    end
    fprintf('\n\n\n');
    
    
    
    % Popping the Stack
    
    popped=priorityQueue(1);
    priorityQueue(1)=[];
    
    % Assigning BackPointers and Costs
    backPointerBook(popped.node_num)=thisBackPointerStack(1);
    if ~costToNodeBook(popped.node_num)
        costToNodeBook(popped.node_num)=thisCost(1);
    end
    
    % Updating this backpointers
    thisBackPointerStack(1)=[];
    thisCost(1)=[];
    
    % Checking if the popped element is the Goal
    if popped==Goal
        disp('Goal Found');
        break;
    end
    
    % If popped element is not the Goal then, add the remaining elements to
    % stack
    
    % Checking for repetition, and if repeated then which one to remove!
    [priorityQueue,thisCost,nextStack,nextCost,thisBackPointerStack,nextBackPointerStack]=process(priorityQueue,thisCost,nextStack,nextCost,thisBackPointerStack,nextBackPointerStack);
    
    % Append the stack and the Cost and backPointers
    priorityQueue=cat(2,priorityQueue,nextStack);
    thisCost=cat(2,thisCost,nextCost);
    
    thisBackPointerStack=cat(2,thisBackPointerStack,nextBackPointerStack);
    
    % Sort the Costs and stack accordingly
    [thisCost,I]=sort(thisCost);
    priorityQueue=priorityQueue(I);
    
    % Updating the backpointers
    thisBackPointerStack=thisBackPointerStack(I);
    % updating current position
    thisPosition=priorityQueue(1);
%     break;
    
end
%% Processing final path
fprintf('\n\n')
disp('Displaying Shortest Cost Path...')
state='G';
while(1)
    if state=='0'
        break;
    end
    fprintf('-->%s ',state);
    index=mappingRight(mappingLeft==state);
    state=backPointerBook(index);
end
fprintf('\n');
    

%% Displaying the backPointerBook, costToNodeBook and Final Path
fprintf('\n\n')
disp('Displaying the back pointer array...');
fprintf('\n\nNode\tBackPointer\n');

for i=1:length(backPointerBook)
    fprintf('%s\t%s\n',mappingLeft(i),backPointerBook(i));
end
fprintf('\n\n')
disp('Displaying the Cost to Node array...');
fprintf('\n\nNode\tCost to Node\n');

for i=1:length(backPointerBook)
    fprintf('%s\t%d\n',mappingLeft(i),costToNodeBook(i));
end



