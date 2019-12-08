%% Attention Check
% In order to see if participants attend to the task, we added an attention
% check procedure: 15 trials in which one single positive face is
% displayed. 
%% Display function
HideCursor;
TRIAL = 1;
MEAN_ALL = -1; % Setting an impossible value

while MEAN_ALL < 7
    pic_num_all = randsample(1:136,6);
    pic_num = randsample(pic_num_all,TRIAL);
    MEAN_ALL = mean(m_all_image(pic_num));
end

rect_num = randperm(6,TRIAL);
rect_6 = RECT(:,rect_num);
DrawFormattedText(window,'+','center',y_center - Move);
Screen('Flip',window);
WaitSecs(Waiting_Time);
T1 = GetSecs();

Disp = 1;

Screen('DrawTextures',window,pointer_face_UP(pic_num(Disp)),[],rect_6(:,Disp));
Screen('Flip',window);
WaitSecs(Duration);
Screen('Flip',window);

Get_Response;   %Calling the Get_Response.m script, this is the slider bar function

ATT_Response(att_loop) = response;
ATT_Mean(att_loop) = MEAN_ALL;
att_loop = att_loop + 1;