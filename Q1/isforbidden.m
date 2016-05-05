function truth=isforbidden(thisPosition,forbidden)

truth=0;

if forbidden(thisPosition)==1
    truth=1;
    return;
end

end