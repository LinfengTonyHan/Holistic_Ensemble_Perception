%% Display function
HideCursor;
TRIAL = Order(ite);
MEAN_ALL = 100; % Setting an impossible value
while MEAN_ALL < Mean_Order(1,ite) || MEAN_ALL > Mean_Order(2,ite)
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

if Trial_Order(ite) == 0
    
    for Disp = 1:TRIAL
        %DrawFormattedText(window,'+','center',y_center - Move);
        
        Screen('DrawTextures',window,pointer_face_UP(pic_num(Disp)),[],rect_6(:,Disp));
        Screen('Flip',window);
        DUR = Duration / TRIAL - 0.0167;
        %tic;
        WaitSecs(DUR);
        %disp(toc);
        %DrawFormattedText(window,'+','center',y_center - Move);
        Screen('Flip',window);
        WaitSecs(ISI);
        
    end
    
elseif Trial_Order(ite) == 1
    for Disp = 1:TRIAL
        %DrawFormattedText(window,'+','center',y_center - Move);
        
        Screen('DrawTextures',window,pointer_face_IN(pic_num(Disp)),[],rect_6(:,Disp));
        Screen('Flip',window);
        DUR = Duration / TRIAL - 0.0167;
        %tic;
        WaitSecs(DUR);
        %disp(toc);
        %DrawFormattedText(window,'+','center',y_center - Move);
        Screen('Flip',window);
        WaitSecs(ISI);
        
    end
    
end
T2 = GetSecs();
Get_Response;   %Calling the Get_Response Function, this is the slider bar function


TIMING(ite) = T2 - T1;
RESPONSE(ite) = response;

MEAN(ite) = mean(Image_Pilot(3,pic_num));
MEAN_INVERTED(ite) = mean(Image_Pilot(4,pic_num));
STD(ite) = std(Image_Pilot(3,pic_num));
STD_INVERTED(ite) = std(Image_Pilot(4,pic_num));
Face{ite} = pic_num;
Face_All{ite} = pic_num_all;
MEAN_WHOLE(ite) = mean(Image_Pilot(3,pic_num_all));
MEAN_WHOLE_INVERTED(ite) = mean(Image_Pilot(4,pic_num_all));