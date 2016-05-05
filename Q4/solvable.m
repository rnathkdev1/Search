%% This function checks if a given puzzle can be solved
function truth=solvable(S)
truth=1;
S=S';
S=S(:);
S(S==9)=[];
inversion=[];
for i=1:length(S)
    thisNum=S(i);
    remainingSegment=S(i+1:end);
    numInversion=sum(remainingSegment<thisNum);
    inversion=cat(2,inversion,numInversion);
   
end

sumInversion=sum(inversion);
if rem(sumInversion,2)==1
    truth=0;
end

end
