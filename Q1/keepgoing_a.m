function keepgoing_a(thisPosition,forbidden,Goal,path)
global found;
global finalpath;
if found==1
    return;
end


if thisPosition(1)>12 || thisPosition(2)>16 || thisPosition(1)<1 || thisPosition(2)<1
    return;
end

if forbidden(thisPosition(1),thisPosition(2))==1;
    return;
end

if thisPosition==Goal
    disp('Goal Found');
    finalpath=path;
    found=1;
    return;
end


forbidden(thisPosition(1),thisPosition(2))=1;
path=cat(1,path,thisPosition);


% Go North
newPosition=[thisPosition(1)+1,thisPosition(2)];
keepgoing_a(newPosition,forbidden,Goal,path);

% Go East
newPosition=[thisPosition(1),thisPosition(2)+1];
keepgoing_a(newPosition,forbidden,Goal,path);

% Go South
newPosition=[thisPosition(1)-1,thisPosition(2)];
keepgoing_a(newPosition,forbidden,Goal,path);

% Go West
newPosition=[thisPosition(1),thisPosition(2)-1];
keepgoing_a(newPosition,forbidden,Goal,path);


end