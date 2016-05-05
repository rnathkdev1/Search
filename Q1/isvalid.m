function truth=isvalid(thisPosition)

if thisPosition(1)>12 || thisPosition(2)>16 || thisPosition(1)<1 || thisPosition(2)<1
    truth=0;
    return;
end

truth = 1;
return;
end
