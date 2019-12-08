function [X_In,X_Up,ReactionIn,ReactionUp] = Organizing_Data3_withMean(subnum,directory,type)
%% function [X_In,X_Up,ReactionIn,ReactionUp] = Organizing_Data3_withMean(subnum,directory,type)
CurDir = pwd();
cd(directory);
load(['Result_',num2str(subnum),'.mat']);
    
M = Image_Pilot(3,:);

for ite = 1:ntrial
    Face_Value = M(Face{ite});
    NumFace = size(Face{ite},2);
    if type == 2
        Face_Value = sort(Face_Value,'descend');
    end
    Value(ite,1:NumFace) = Face_Value;
    Value(ite,8) = NumFace;
    Value(ite,9) = Trial_Order(ite);
end

Value(:,7) = RESPONSE';
Value(:,10) = MEAN';
Value = sortrows(Value,9,'descend');
Value = sortrows(Value,8,'descend');

X_In = Value(1:50,[1:6,10]);
X_Up = Value(51:100,[1:6,10]);
ReactionIn = Value(1:50,7);
ReactionUp = Value(51:100,7);
cd(CurDir);