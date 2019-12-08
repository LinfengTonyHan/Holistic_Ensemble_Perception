function Output = StepWiseModel(Raw_Face,Response,crit_enter,crit_remove)
[b,se,pval,inmodel,stats,nextstep,history] = stepwisefit(Raw_Face,Response,'penter',crit_enter,'premove',crit_remove);
Output.b= b;
Output.se = se;
Output.pval = pval;
Output.inmodel = inmodel;
Output.stats = stats;
Output.nextstep = nextstep;
Output.history = history;
n = length(Response);
Output.stats.rsq = 1 - (history.rmse.^2/var(Response)) .* ((n-1-history.df0)/(n-1));
% To obtain Adjusted R-Squared values. 
Output.stats.adjrsq = 1 - stats.rmse.^2/var(Response);
end