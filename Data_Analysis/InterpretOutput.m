function ARS = InterpretOutput(AO)
%% This function is written for deriving the results from the stepwise model 
history = double(AO.history.in);

entry1st = find(history(1,:) == 1);
if entry1st == 7
    first = 'mean';
else
    first = ['face',num2str(entry1st)];
end

inmodelV = find(double(AO.inmodel) == 1);
for itr = 1:length(inmodelV)
    inmodel{itr} = ['face',num2str(inmodelV(itr))];
end
try
    PS7 = find(strcmp(inmodel,'face7'));
    inmodel{PS7} = 'mean';
catch
end
if length(inmodel) == 2
    inmodel = [inmodel{2},', ',inmodel{1}];
elseif length(inmodel) == 3
    inmodel = [inmodel{3},', ',inmodel{1},', ',inmodel{2}];
end
Rsq = AO.stats.adjrsq;
%ARS = [first,inmodel,Rsq];
ARS{1} = first;
ARS{2} = inmodel;
ARS{3} = Rsq;
