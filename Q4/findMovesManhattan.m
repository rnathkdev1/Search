function [allowedMoves,heuristics]=findMovesManhattan(thisState,GoalState)

allowedMoves=[];
heuristics=[];

[row,col]=find(thisState==9);

% There are 4 possible moves in a general case
if isvalid(row+1,col)
    tempState=thisState;
    [tempState(row+1,col),tempState(row,col)]=deal(tempState(row,col),tempState(row+1,col));
    allowedMoves=cat(3,allowedMoves,tempState);
    thisheuristic=doManhattan3x3(tempState,GoalState);
    heuristics=cat(2,heuristics,thisheuristic);
end
 
if isvalid(row,col+1)
    tempState=thisState;
    [tempState(row,col+1),tempState(row,col)]=deal(tempState(row,col),tempState(row,col+1));
    allowedMoves=cat(3,allowedMoves,tempState);
    thisheuristic=doManhattan3x3(tempState,GoalState);
    heuristics=cat(2,heuristics,thisheuristic);
end

if isvalid(row-1,col)
    tempState=thisState;
    [tempState(row-1,col),tempState(row,col)]=deal(tempState(row,col),tempState(row-1,col));
    allowedMoves=cat(3,allowedMoves,tempState);
    thisheuristic=doManhattan3x3(tempState,GoalState);
    heuristics=cat(2,heuristics,thisheuristic);
end

if isvalid(row,col-1)
    tempState=thisState;
    [tempState(row,col-1),tempState(row,col)]=deal(tempState(row,col),tempState(row,col-1));
    allowedMoves=cat(3,allowedMoves,tempState);
    thisheuristic=doManhattan3x3(tempState,GoalState);
    heuristics=cat(2,heuristics,thisheuristic);
end



end

function truth=isvalid(row,col)
truth=0;

if row>0 && col>0 && row<=3 && col<=3 
    truth=1;
end

end

function manhattan=doManhattan3x3(thisState,GoalState)
manhattan=0;
for i=1:8
    [row,col]=find(thisState==i);
    [row_,col_]=find(GoalState==i);
    
    manhattan=manhattan+pdist2([row,col],[row_,col_],'cityblock');

end
end