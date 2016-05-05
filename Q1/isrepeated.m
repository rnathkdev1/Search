function truth = isrepeated(thisPosition,stack)

if (isempty(find(stack==thisPosition)))
    truth = 0;
else truth =1;
end

end