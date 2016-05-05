function P=prepareMoves2(reachedStates,backPointerBook,nodeIDStack)

thisIndex=length(backPointerBook);
keepCount=length(backPointerBook);


while(1)
    
   keepCount=keepCount-1;
   
   thisIndexConcerned=nodeIDStack==thisIndex;
   prevIndex=backPointerBook(thisIndex);
   prevIndexConcerned=nodeIDStack==prevIndex;
   
   if prevIndex==0
       break;
   end
   
   
   lastMat=reshape(reachedStates(thisIndexConcerned,:),[3,3]);
   secondLastMat=reshape(reachedStates(prevIndexConcerned,:),[3,3]);
   
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