function cbScrollwheel(sel, ~, evt)
%Allows interactive adjustment of the number of clusters / cuts to perform

% No region has been selected yet:
if isempty(sel.disp.cutVecs)
    return
end

%Determine scrolling direction and update cluster count accordingly
nEigs = size(sel.disp.cutVecs, 2);

switch sign(evt.VerticalScrollCount)
    case -1 % Scrolling up
        if sel.disp.clusterNum < nEigs
            sel.disp.clusterNum = sel.disp.clusterNum + 1;
        else
            return
        end
    case 1 % Scrolling down
        if sel.disp.clusterNum > 1
            sel.disp.clusterNum = sel.disp.clusterNum - 1;
        else
            return
        end
end

% Recalculate clusters with new cluster count:
sel.calcRoi;

%  Display traces automatically (use timers to make things
% snappier):
if strcmp(sel.h.timers.loadTraces.Running, 'off')
    start(sel.h.timers.loadTraces);
end

end
