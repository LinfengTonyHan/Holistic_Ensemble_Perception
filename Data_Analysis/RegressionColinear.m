%% Correlation with the mean and single faces
for iteSub = 1:10
    for iteCorr = 1:6
        DataTest = DataTemp{iteSub};
        [pearR,~,~] = regression(DataTest(:,iteCorr)',DataTest(:,7)'); 
        corrAll(iteSub, iteCorr) = pearR;
    end
end