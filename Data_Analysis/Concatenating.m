%% This is the script for generating the step-wise regression results

Alpha = 0.05; %The level of Significance
CriRemove = 0.10; %Level of remove criterion

%% Steps of using this script: evaluating the first session, identifying the alpha and CriRemove level
%% Experiment 2: Spatial Ensemble 1s
DIR = '/Users/hanlinfeng/Dropbox/Mooney_Face_Project/Holistic_Ensemble/Data&Data_Analysis/Original_Spatial_Ensemble_Small/Original_Small_Data';
%DIR = 'Dropbox/Mooney_Face_Project/Data&Data_Analysis/Original_Spatial_Ensemble_1_Sec/Data_Original_Spatial_Ensemble_1_Sec';
SubExp2 = 10;
Exp2 = zeros(SubExp2,2);
for ite = 1:SubExp2
    [RawFace, Mean, Resp] = Organizing_Data_withMean(ite,DIR,1);
    Mean = zscore(Mean);
    RawFaceAll((ite*50-49):(ite*50),1:6) = RawFace;
    MeanAll((ite*50-49):(ite*50),1) = Mean;
    RespAll((ite*50-49):(ite*50),1) = Resp;
end

Output = StepWiseModel([RawFaceAll,MeanAll],RespAll,Alpha,CriRemove);
ARS = InterpretOutput(Output);
%% Experiment 3a: Temporal 50ms
DIR = '/Users/hanlinfeng/Dropbox/Mooney_Face_Project/Holistic_Ensemble/Data&Data_Analysis/Original_Temporal_50_Ms/DATA_Original_Temporal_50_Ms';
SubExp3a = 10;
Exp3a = zeros(SubExp3a,2);
for ite = 1:SubExp3a
    [RawFace, Mean, Resp] = Organizing_Data_withMean(ite,DIR,1);
    Mean = zscore(Mean);
    RawFaceAll((ite*50-49):(ite*50),1:6) = RawFace;
    MeanAll((ite*50-49):(ite*50),1) = Mean;
    RespAll((ite*50-49):(ite*50),1) = Resp;
end
Output = StepWiseModel([RawFaceAll,MeanAll],RespAll,Alpha,CriRemove);
ARS = InterpretOutput(Output);

%% Experiment 3b: Temporal 33ms
DIR = '/Users/hanlinfeng/Dropbox/Mooney_Face_Project/Holistic_Ensemble/Data&Data_Analysis/Original_Temporal_33_Ms/Data_Original_Temporal_33_Ms';
SubExp3b = 10;
Exp3b = zeros(SubExp3b,2);
for ite = 1:SubExp3b
    [RawFace, Mean, Resp] = Organizing_Data_withMean(ite,DIR,1);
    Mean = zscore(Mean);
    RawFaceAll((ite*50-49):(ite*50),1:6) = RawFace;
    MeanAll((ite*50-49):(ite*50),1) = Mean;
    RespAll((ite*50-49):(ite*50),1) = Resp;
end
Output = StepWiseModel([RawFaceAll,MeanAll],RespAll,Alpha,CriRemove);
ARS = InterpretOutput(Output);

%% Experiment 4: Upright
DIR = '/Users/hanlinfeng/Dropbox/Mooney_Face_Project/Holistic_Ensemble/Data&Data_Analysis/Original_Upright_Vs_Inverted_1_Sec/Data_Original_Upright_Vs_Inverted_50_Trials/Copy_of_UP';
SubExp4 = 17;
Exp4up = zeros(SubExp4,2);
Exp4in = zeros(SubExp4,2);
for ite = 1:SubExp4
    [RawFace, Mean, Resp] = Organizing_Data_withMean(ite,DIR,2);
    Resp = zscore(Resp);
    RawFaceAll((ite*50-49):(ite*50),1:6) = RawFace;
    MeanAll((ite*50-49):(ite*50),1) = Mean;
    RespAll((ite*50-49):(ite*50),1) = Resp;
end
Output = StepWiseModel([RawFaceAll,MeanAll],RespAll,Alpha,CriRemove);
ARS = InterpretOutput(Output);

%% Experiment 4: Inverted
DIR = '/Users/hanlinfeng/Dropbox/Mooney_Face_Project/Holistic_Ensemble/Data&Data_Analysis/Original_Upright_Vs_Inverted_1_Sec/Data_Original_Upright_Vs_Inverted_50_Trials/Copy_of_IN';
SubExp4 = 17;
Exp4up = zeros(SubExp4,2);
Exp4in = zeros(SubExp4,2);
for ite = 1:SubExp4
    [RawFace, Mean, Resp] = Organizing_Data_withMean(ite,DIR,2);
    Resp = zscore(Resp);
    RawFaceAll((ite*50-49):(ite*50),1:6) = RawFace;
    MeanAll((ite*50-49):(ite*50),1) = Mean;
    RespAll((ite*50-49):(ite*50),1) = Resp;
end
Output = StepWiseModel([RawFaceAll,MeanAll],RespAll,Alpha,CriRemove);
ARS = InterpretOutput(Output);
%% Experiment 7a: Temporal 100ms New Stimuli
%% RF -- including all the single face values as well as the mean value column
DIR = '/Users/hanlinfeng/Dropbox/Mooney_Face_Project/Holistic_Ensemble/Data&Data_Analysis/New_Stimuli_Temporal_100_Ms/DATA_ATT_CHECK';
SubExp7a = 13;
for ite = 1:SubExp7a
    [RFin,RFup,RESPin,RESPup] = Organizing_Data3_withMean(ite,DIR,1); %RF: Raw Faces + MEAN
    RESPup = zscore(RESPup);
    RFupAll((ite*50-49):(ite*50),1:7) = RFup;
    RESPupAll((ite*50-49):(ite*50),1) = RESPup;
end
Output = StepWiseModel(RFupAll,RESPupAll,Alpha,CriRemove);
ARS = InterpretOutput(Output);

%% Inverted Ensembles
for ite = 1:SubExp7a
    [RFin,RFup,RESPin,RESPup] = Organizing_Data3_withMean(ite,DIR,2); %RF: Raw Faces + MEAN
    RESPin = zscore(RESPin);
    RFinAll((ite*50-49):(ite*50),1:7) = RFin;
    RESPinAll((ite*50-49):(ite*50),1) = RESPin;
end
Output = StepWiseModel(RFinAll,RESPinAll,Alpha,CriRemove);
ARS = InterpretOutput(Output);

%% Experiment 7b (I refer to Exp 8 here): Spatial New Stimuli 1s
DIR = '/Users/hanlinfeng/Dropbox/Mooney_Face_Project/Holistic_Ensemble/Data&Data_Analysis/New_Stimuli_Spatial_1_Sec/DATA_Spatial';
SubExp7b = 11;
for ite = 1:SubExp7b
    [RFin,RFup,RESPin,RESPup] = Organizing_Data3_withMean(ite,DIR,1); %RF: Raw Faces + MEAN
    RESPup = zscore(RESPup);
    RFupAll((ite*50-49):(ite*50),1:7) = RFup;
    RESPupAll((ite*50-49):(ite*50),1) = RESPup;
end
Output = StepWiseModel(RFupAll,RESPupAll,Alpha,CriRemove);
ARS = InterpretOutput(Output);

%% Inverted Ensembles
for ite = 1:11
    [RFin,RFup,RESPin,RESPup] = Organizing_Data3_withMean(ite,DIR,1); %RF: Raw Faces + MEAN
    RESPin = zscore(RESPin);
    RFinAll((ite*50-49):(ite*50),1:7) = RFin;
    RESPinAll((ite*50-49):(ite*50),1) = RESPin;
end
Output = StepWiseModel(RFinAll,RESPinAll,Alpha,CriRemove);
ARS = InterpretOutput(Output);

%% This is the end of the analysis code

