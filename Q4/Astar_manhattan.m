function P = Astar_manhattan(S,G)
% ASTAR Implement A* search on 8-puzzle problem.
%   S   Starting puzzle configuration (3x3 array).
%   G   Goal puzzle configuration (3x3 array).
%   P   Path to get from S to G, represented as a vector of integers
%       indicating which direction the tile goes to move into the blank
%       space. Use the following encoding scheme: 1=LEFT, 2=RIGHT, 3=UP,
%       and 4=DOWN.
%
% 4/20/14 Created by Matt Eicholtz for 24-787

if nargin<2
    G = [1 2 3; 4 5 6; 7 8 9]; %default goal state
end

% Before solving, we need to verify that this puzzle is solvable

if ~solvable(S) && nargin<2
    disp('This Puzzle is not solvable. Sorry.');
    return;
end


% 9 is the empty tile.
P=[];
nodeIDStack=[];
stateLabelCount=1;
stateLabel=0;
reachedStates=[];
backPointerBook=[];
costToNodeBook=[];

Goal=G;

thisState=S;
thisStack=S;
thisCost=0;
thisBackPointerStack=0;
% GraphNode(node_num,node_1,node_2,node_3,node_4,heuristic_1,heuristic_2,heuristic_3,heuristic_4)
thisGraphNode=GraphNode();
thisGraphNode.nodeNum=1;
thisGraphStack=thisGraphNode;

% Consider the cost of one move to be equal to unity

count = 1; %keep track of iterations
maxiter = 1e6; %just to make sure the code does not run forever
disp('Please wait while your solution is being calculated...');
used=0;
while count<maxiter
    if count>500 && used==0
        
        disp('Hmm this is a tough one... This is taking longer than usual...');
        used=1;
    end
    
    indicesForDeletion=[];
    flag=0;
    % If this state is a new state then add it to the stack of states
    thisStateVec=thisState(:)';
    if isempty(reachedStates)
        
        thisStateVec=thisState(:)';
        reachedStates=cat(1,reachedStates,thisStateVec);
        nodeIDStack=cat(2,nodeIDStack,thisGraphNode.nodeNum);
    end
    
    if ~ismember(reachedStates,thisStateVec,'rows')

        
        stateLabel=cat(2,stateLabel,stateLabelCount);
        reachedStates=cat(1,reachedStates,thisStateVec);
        nodeIDStack=cat(2,nodeIDStack,thisGraphNode.nodeNum);
    end
    
    
    [nextStack,nextHeuristics]=findMovesManhattan(thisState,G);
    nextCost=ones(1,size(nextStack,3));
    nextTotalCost=thisCost(1)+nextCost+nextHeuristics;
    
    
    if ~isempty(nextStack)
        nextGraphStack=[];
        nextBackPointerStack=thisGraphNode.nodeNum*ones(1,size(nextStack,3));
        for i=1:size(nextStack,3)
            tempNextState=nextStack(:,:,i);
            tempNextStateVec=tempNextState(:)';
            if ~ismember(reachedStates,tempNextStateVec,'rows')
                stateLabelCount=stateLabelCount+1;
                Graph=GraphNode();
                thisGraphNode.nextNode=cat(2,thisGraphNode.nextNode,Graph);
                thisGraphNode.heuristic(i)=nextHeuristics(i);
                Graph.nodeNum=stateLabelCount;
                nextGraphStack=cat(2,nextGraphStack,Graph);
            else
                flag=1;
                indicesForDeletion=cat(2,indicesForDeletion,i);
            end
        end
    end
    
    if flag==1
        nextStack(:,:,indicesForDeletion)=[];
        nextCost(indicesForDeletion)=[];
        nextTotalCost(indicesForDeletion)=[];
        nextHeuristics(indicesForDeletion)=[];
    end
    
    % Popping the stack
    popped=thisStack(:,:,1);
    % poppedNodes=cat(3,poppedNodes,thisStack);
    thisStack(:,:,1)=[];
    thisGraphStack(1)=[];
    
    % Assigning backpointers and costs
    backPointerBook(thisGraphNode.nodeNum)=thisBackPointerStack(1);
    costToNodeBook(thisGraphNode.nodeNum)=thisCost(1);
    
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
    
    % Checking for repetition, and if repeated then remove the one with higher cost
    if ~isempty(thisStack) && ~isempty(nextStack)
        [thisStack,thisCost,nextStack,nextTotalCost,thisBackPointerStack,nextBackPointerStack,thisGraphStack,nextGraphStack]...
            =process(thisStack,thisCost,nextStack,nextTotalCost,thisBackPointerStack,nextBackPointerStack,thisGraphStack,nextGraphStack);
    end
    
    % Append the stack and the Cost and backPointers
    thisStack=cat(3,thisStack,nextStack);
    thisCost=cat(2,thisCost,nextTotalCost);
    thisBackPointerStack=cat(2,thisBackPointerStack,nextBackPointerStack);
    thisGraphStack=cat(2,thisGraphStack,nextGraphStack);
    
    
    % Sort the Costs, stack,graphStack and backpointers accordingly
    [thisCost,I]=sort(thisCost);
    
    thisStack=thisStack(:,:,I);
    thisGraphStack=thisGraphStack(I);
    thisBackPointerStack=thisBackPointerStack(I);
    
    % Updating current position
    thisState=thisStack(:,:,1);
    thisGraphNode=thisGraphStack(1);
    
    count = count+1;
end

if count==maxiter
    fprintf('Sorry.. I had to give up after %d iterations!',maxiter);
end

%% Preparing moves
P=prepareMoves2(reachedStates,backPointerBook,nodeIDStack);
fprintf('Oh yeah its done! Here you go!...')
show8puzzle(S,P);

end
