function [allowedMoves,heuristics]=findMoves(thisState,GoalState)

allowedMoves=[];
heuristics=[];

[row,col]=find(thisState==9);

% There are 4 possible moves in a general case
if isvalid(row+1,col)
    tempState=thisState;
    [tempState(row+1,col),tempState(row,col)]=deal(tempState(row,col),tempState(row+1,col));
    allowedMoves=cat(3,allowedMoves,tempState);
    
    matchedPoints=sum(sum(tempState==GoalState));
    heuristics=cat(2,heuristics,9-matchedPoints);
end
 
if isvalid(row,col+1)
    tempState=thisState;
    [tempState(row,col+1),tempState(row,col)]=deal(tempState(row,col),tempState(row,col+1));
    allowedMoves=cat(3,allowedMoves,tempState);
    
    matchedPoints=sum(sum(tempState==GoalState));
    heuristics=cat(2,heuristics,9-matchedPoints);
end

if isvalid(row-1,col)
    tempState=thisState;
    [tempState(row-1,col),tempState(row,col)]=deal(tempState(row,col),tempState(row-1,col));
    allowedMoves=cat(3,allowedMoves,tempState);
    
    matchedPoints=sum(sum(tempState==GoalState));
    heuristics=cat(2,heuristics,9-matchedPoints);
end

if isvalid(row,col-1)
    tempState=thisState;
    [tempState(row,col-1),tempState(row,col)]=deal(tempState(row,col),tempState(row,col-1));
    allowedMoves=cat(3,allowedMoves,tempState);
    
    matchedPoints=sum(sum(tempState==GoalState));
    heuristics=cat(2,heuristics,9-matchedPoints);
end



end

function truth=isvalid(row,col)
truth=0;

if row>0 && col>0 && row<=3 && col<=3 
    truth=1;
end

end