function P=prepareMoves(reachedStates,backPointerBook)

thisIndex=length(backPointerBook);
keepCount=length(backPointerBook);


while(1)
   keepCount=keepCount-1;
   prevIndex=backPointerBook(thisIndex);
   
   if prevIndex==0
       break;
   end
   
   
   lastMat=reshape(reachedStates(thisIndex,:),[3,3]);
   
   secondLastMat=reshape(reachedStates(prevIndex,:),[3,3]);
   
   I2=find(lastMat==9);
   I1=find(secondLastMat==9);
   
%    1=LEFT, 2=RIGHT, 3=UP, and 4=DOWN.

    diff=I2-I1;
    
    if diff==1
        % Move up
        P(keepCount)=3;
    elseif diff==-1
        % Move down
        P(keepCount)=4;
    elseif diff==3
        % Move Left
        P(keepCount)=1;
    else P(keepCount)=2;
    end
    
    thisIndex=prevIndex;
    
end

P(P==0)=[];

end