function [vectorThisStack,vectorNextStack]=convertToVector(thisStack,nextStack)
vectorThisStack=[];
vectorNextStack=[];

for i=1:size(thisStack,3)
    thisPlane=thisStack(:,:,i);
    vectorPlane=thisPlane(:)';
    vectorThisStack=cat(1,vectorThisStack,vectorPlane);
end

for i=1:size(nextStack,3)
    thisPlane=nextStack(:,:,i);
    vectorPlane=thisPlane(:)';
    vectorNextStack=cat(1,vectorNextStack,vectorPlane);
end


end
