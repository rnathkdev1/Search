function show8puzzle(puzzle,moves)
% SHOW8PUZZLE Visualize 8-puzzle using specified moves.

figure(1);
clf;
set(gcf,'MenuBar','none','Toolbar','none',...
    'NumberTitle','off','Name','8-Puzzle',...
    'Position',[80 80 400 400]);
for m=1:length(moves)
    set(gcf,'Name',sprintf('8-Puzzle: move %d/%d',m,length(moves)));
    update(puzzle);
    [puzzle,whichtile] = applymove(puzzle,moves(m));
    [row,col] = ind2sub(size(puzzle),whichtile);
    
    rectangle('Position',[col-1 row-1 1 1],'EdgeColor','r','LineWidth',2);
    pause(1);
    update(puzzle);
end

end

% Helper functions
% ------------------------
function update(puzzle)
    clf;
    axes(...
    'Color',[1 1 1],...
    'Box','on',...
    'GridLineStyle','-',...
    'LineWidth',1,...
    'Position',[-0.001 -0.001 1.002 1.002],...%[0.05 0.05 0.9 0.9],...
    'YDir','reverse',...
    'XLim',[0 3],...
    'YLim',[0 3],...
    'XGrid','on',...
    'YGrid','on',...
    'XTickLabel','',...
    'YTickLabel','',...
    'XTick',1:3,...
    'YTick',1:3);
    for ii=1:3
        for jj=1:3
            if puzzle(jj,ii)~=9
                text(ii-0.5,jj-0.5,num2str(puzzle(jj,ii)),'FontSize',36,'HorizontalAlignment','center');
            end
        end
    end
end
function [q,r] = applymove(p,move)
% APPLYMOVE Get the next puzzle state after applying a specified move.
    ind = find(p==9);
    q = p;
    switch move
        case 1; r = ind+3;
        case 2; r = ind-3;
        case 3; r = ind+1;
        case 4; r = ind-1;
    end
    q(ind) = q(r); q(r) = 9;
end

