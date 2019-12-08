function [Face_Raw,Reaction] = Organizing_Data(subnum,directory,type)
%% [Face_Raw,Reaction] = Organizing_Data(subnum,directory,type)
% if type == 2, Face_Value = sort(Face_Value,'descend');
% sorting the variables according to emotional valence

CurDir = pwd();
cd(directory);
load(['Result_',num2str(subnum),'.mat']);
%ALL_raw = [Order,
    
M = Image_Pilot(3,:);
for ite = 1:ntrial
    Face_Value = M(Face{ite});
    if type == 2
        Face_Value = sort(Face_Value,'descend');
    end
    NumFace = size(Face{ite},2);
    Value(ite,1:NumFace) = Face_Value;
    Value(ite,8) = NumFace;
end

Value(:,7) = RESPONSE';

Value = sortrows(Value,8,'descend');

Face_Raw = Value(1:50,1:6);
Reaction = Value(1:50,7);
cd(CurDir);