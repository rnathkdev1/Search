function [thisStack,thisCost,nextStack,nextCost,thisBackPointerStack,nextBackPointerStack]=...
    process(thisStack,thisCost,nextStack,nextCost,thisBackPointerStack,nextBackPointerStack)

[C,ia,ib]=intersect(thisStack,nextStack);

if isempty(C)
    return;
else
    % Compare the costs and put the min one in current stack
    newCostMat=[thisCost(ia);nextCost(ib)];
    thisCost(ia)=min(thisCost(ia),nextCost(ib));
    [~,I]=min(newCostMat);
    col=1:size(I,2);
    newBackPointerMat=[thisBackPointerStack(ia);nextBackPointerStack(ib)];
    
    for i=col
        thisBackPointerStack(ia(i))=newBackPointerMat(I(i),i);
    end
    % Delete the relevant ones from next stack
    nextCost(ib)=[];
    nextStack(ib)=[];
    nextBackPointerStack(ib)=[];
end
    
end