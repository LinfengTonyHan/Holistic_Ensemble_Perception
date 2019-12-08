%% This is the script for generating the step-wise regression results
%

Alpha = 0.05; %The level of Significance (incorporating a factor)
CriRemove = 0.10; %Level of remove criterion

%% Steps of using this script: 
% evaluating the first session, identifying the alpha levels，
% then evaluate each session of the script 
%% Experiment 2: Spatial Ensemble 1s
clearvars -except Alpha CriRemove
DIR = '/Users/hanlinfeng/Dropbox/Mooney_Face_Project/Holistic_Ensemble/Data&Data_Analysis/Original_Spatial_Ensemble_Small/Original_Small_Data';
SubExp2 = 10;
Exp2 = zeros(SubExp2,2);
for ite = 1:SubExp2
    [RawFace, Mean, Resp] = Organizing_Data_withMean(ite,DIR,2); %refer to the function Organizing_Data_withMean
    %Here: the 3rd input variable of the function refers to the choice of
    %whether sorting the variables 
    DataTemp{ite} = [RawFace, Mean, Resp];
    Output = StepWiseModel([RawFace,Mean],Resp,Alpha,CriRemove);
    ARS = InterpretOutput(Output);
    ARS_ALL{ite,1} = ARS{1};
    ARS_ALL{ite,2} = ARS{2};
    ARS_ALL{ite,3} = ARS{3};
    Analysis_StepWise{ite} = Output;
end

%% Experiment 3a: Temporal 50ms
clearvars -except Alpha CriRemove
DIR = '/Users/hanlinfeng/Dropbox/Mooney_Face_Project/Holistic_Ensemble/Data&Data_Analysis/Original_Temporal_50_Ms/DATA_Original_Temporal_50_Ms';
SubExp3a = 10;
Exp3a = zeros(SubExp3a,2);
for ite = 1:SubExp3a
    [RawFace, Mean, Resp] = Organizing_Data_withMean(ite,DIR,2);
    Data{ite} = [RawFace, Mean, Resp];
    Output = StepWiseModel([RawFace,Mean],Resp,Alpha,CriRemove);
     ARS = InterpretOutput(Output);
    ARS_ALL{ite,1} = ARS{1};
    ARS_ALL{ite,2} = ARS{2};
    ARS_ALL{ite,3} = ARS{3};
    Analysis_StepWise{ite} = Output;
end

%% Experiment 3b: Temporal 33ms
clearvars -except Alpha CriRemove
DIR = '/Users/hanlinfeng/Dropbox/Mooney_Face_Project/Holistic_Ensemble/Data&Data_Analysis/Original_Temporal_33_Ms/Data_Original_Temporal_33_Ms';
SubExp3b = 10;
Exp3b = zeros(SubExp3b,2);
for ite = 1:SubExp3b
    [RawFace, Mean, Resp] = Organizing_Data_withMean(ite,DIR,2);
    Output = StepWiseModel([RawFace,Mean],Resp,Alpha,CriRemove);
    ARS = InterpretOutput(Output);
    ARS_ALL{ite,1} = ARS{1};
    ARS_ALL{ite,2} = ARS{2};
    ARS_ALL{ite,3} = ARS{3};
    Analysis_StepWise{ite} = Output;
end

%% Experiment 4: Upright
clearvars -except Alpha CriRemove
DIR = '/Users/hanlinfeng/Dropbox/Mooney_Face_Project/Holistic_Ensemble/Data&Data_Analysis/Original_Upright_Vs_Inverted_1_Sec/Data_Original_Upright_Vs_Inverted_50_Trials/Copy_of_UP';
SubExp4 = 17;
Exp4up = zeros(SubExp4,2);
Exp4in = zeros(SubExp4,2);
for ite = 1:SubExp4
    [RawFace, Mean, Resp] = Organizing_Data_withMean(ite,DIR,2);
    Output = StepWiseModel([RawFace,Mean],Resp,Alpha,CriRemove);
    ARS = InterpretOutput(Output);
    ARS_ALL{ite,1} = ARS{1};
    ARS_ALL{ite,2} = ARS{2};
    ARS_ALL{ite,3} = ARS{3};
    Analysis_StepWise{ite} = Output;
end

%% Experiment 4: Inverted
clearvars -except Alpha CriRemove
DIR = '/Users/hanlinfeng/Dropbox/Mooney_Face_Project/Holistic_Ensemble/Data&Data_Analysis/Original_Upright_Vs_Inverted_1_Sec/Data_Original_Upright_Vs_Inverted_50_Trials/Copy_of_IN';
SubExp4 = 17;
Exp4up = zeros(SubExp4,2);
Exp4in = zeros(SubExp4,2);
for ite = 1:SubExp4
    [RawFace, Mean, Resp] = Organizing_Data_withMean(ite,DIR,2);
    Output = StepWiseModel([RawFace,Mean],Resp,Alpha,CriRemove);
    ARS = InterpretOutput(Output);
    ARS_ALL{ite,1} = ARS{1};
    ARS_ALL{ite,2} = ARS{2};
    ARS_ALL{ite,3} = ARS{3};
    Analysis_StepWise{ite} = Output;
end

%% Experiment 7a: Temporal 100ms New Stimuli
clearvars -except Alpha CriRemove
DIR = '/Users/hanlinfeng/Dropbox/Mooney_Face_Project/Holistic_Ensemble/Data&Data_Analysis/New_Stimuli_Temporal_100_Ms/DATA_ATT_CHECK';
SubExp7a = 13;

for ite = 1:SubExp7a
    [RFin,RFup,RESPin,RESPup] = Organizing_Data3_withMean(ite,DIR,2); %RF: Raw Faces + MEAN
    Output = StepWiseModel(RFup,RESPup,Alpha,CriRemove);
    ARS = InterpretOutput(Output);
    ARS_ALL{ite,1} = ARS{1};
    ARS_ALL{ite,2} = ARS{2};
    ARS_ALL{ite,3} = ARS{3};
    Analysis_StepWise{ite} = Output;
end

%% Inverted Ensembles
for ite = 1:SubExp7a
    try
    [RFin,RFup,RESPin,RESPup] = Organizing_Data3_withMean(ite,DIR,2); %RF: Raw Faces + MEAN
    Output = StepWiseModel(RFin,RESPin,Alpha,CriRemove);
    ARS = InterpretOutput(Output);
    ARS_ALL{ite,1} = ARS{1};
    ARS_ALL{ite,2} = ARS{2};
    ARS_ALL{ite,3} = ARS{3};
    Analysis_StepWise{ite} = Output;
    catch
    end
end

%% Experiment 7b: Spatial New Stimuli 1s
DIR = '/Users/hanlinfeng/Dropbox/Mooney_Face_Project/Holistic_Ensemble/Data&Data_Analysis/New_Stimuli_Spatial_1_Sec/DATA_Spatial';
SubExp7b = 11;
for ite = 1:SubExp7b
    [RFin,RFup,RESPin,RESPup] = Organizing_Data3_withMean(ite,DIR,2); %RF: Raw Faces + MEAN
    Output = StepWiseModel(RFup,RESPup,Alpha,CriRemove);
    ARS = InterpretOutput(Output);
    ARS_ALL{ite,1} = ARS{1};
    ARS_ALL{ite,2} = ARS{2};
    ARS_ALL{ite,3} = ARS{3};
    Analysis_StepWise{ite} = Output;
end

%% Inverted Ensembles
DIR = '/Users/hanlinfeng/Dropbox/Mooney_Face_Project/Holistic_Ensemble/Data&Data_Analysis/New_Stimuli_Spatial_1_Sec/DATA_Spatial';
SubExp7b = 11;
for ite = 1:11
    try 
    [RFin,RFup,RESPin,RESPup] = Organizing_Data3_withMean(ite,DIR,2); %RF: Raw Faces + MEAN
    Output = StepWiseModel(RFin,RESPin,Alpha,CriRemove);
    ARS = InterpretOutput(Output);
    ARS_ALL{ite,1} = ARS{1};
    ARS_ALL{ite,2} = ARS{2};
    ARS_ALL{ite,3} = ARS{3};
    Analysis_StepWise{ite} = Output;
    catch
    end
end

%% This is the end of the analysis code 

