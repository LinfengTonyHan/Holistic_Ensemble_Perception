%% This is the main function of the program clear all;
% MAIN.m

clear all;
close all;
clc;

%% Initializing the variables
Version = 'Temporal';
load Image_Pilot
KbName('UnifyKeyNames');
rng('shuffle');
Waiting_Time = 0.5; %Intervals (Blank Screen), 0.5
ISI = 0.050;
ISI = ISI - 0.0167;
Cross_Delay = 0.6; %Fixation Cross Duration, 0.6
Duration = 0.3;  %Time for duration of display, 1
ntrial = 300;  %300
Rest = 30;  %Resting time in trial 100, 200, should be 30 secs
F_Sc = [];
P_Sc = [0,0,900,650];
Num_Size = 24;
Word_Size = 35;

%% Subject Info
Info = {'Number','Initials','Gender [1=Male,2=Female,3=Other]','Age','Ethnicity'};
dlg_title = 'Subject Information';
num_lines = 1;
subject_info = inputdlg(Info,dlg_title,num_lines);

Instructions;
%% Opening the Screen
ListenChar(-1);
Screen('Preference','SkipSyncTests',1);
rng('shuffle');
[window,rect]=Screen('OpenWindow',0,[],F_Sc);
Screen('BlendFunction',window,GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);

window_w=rect(3);
window_h=rect(4);

x_center=window_w/2;
y_center=window_h/2;

MACHINE = rect(3)/1280; %Adjustment of Stimuli
Move = 5 * MACHINE;
Screen('TextSize', window, Word_Size);
Screen('TextFont', window, 'Times');

num=subject_info(1);
num=cell2mat(num);
name=subject_info(2);
name=cell2mat(name);
filename=['Result(',num2str(num),')_',name,'.mat'];
%% Defining the Grid
img_height = 256 * MACHINE;
img_width = 256 * MACHINE;

BOUND_X = 0.45; %Here it is! Please set BOUND as 0~0.5. Larger value will cause the images closer to the center.
BOUND_Y = 0.45;
xStart = window_w * BOUND_X;
xEnd = window_w * (1-BOUND_X);
yStart = window_h * BOUND_Y;
yEnd = window_h * (1-BOUND_Y);
nRows = 2;
nCols = 3;

xGridLines = linspace(xStart, xEnd, nCols);
yGridLines = linspace(yStart, yEnd, nRows);
[xPoints, yPoints] = meshgrid(xGridLines, yGridLines);
RECT = [xPoints(:)'-img_width/2; yPoints(:)'-img_height/2; ...
    xPoints(:)'+img_width/2; yPoints(:)'+img_height/2];
%% Loading the Stimuli
cd Images_ALL

for s=1:136
    IMG=imread([num2str(s),'.png']);
    pointer_face(s)=Screen('MakeTexture', window ,IMG);
end

cd ..

TIMING = zeros(1,300);

%% Order
Order_Prac = randperm(6);

nprac = 6;

Order = [ones(1,ntrial /6),2*ones(1,ntrial /6),3*ones(1,ntrial /6), ...
    4*ones(1,ntrial /6),5*ones(1,ntrial /6),6*ones(1,ntrial /6)];
Interleave_Order = repmat([zeros(1,ntrial/12),180*ones(1,ntrial/12)],1,6);
Order_ALL = [Order;Interleave_Order];
Order_ALL = Order_ALL(:, randperm(size(Order_ALL, 2)));
Order = Order_ALL(1,:);
Interleave_Order = Order_ALL(2,:);

%%
Mean_Order = [3.8,4.6,5.2,5.8,6.4,7;4.6,5.2,5.8,6.4,7,8]; %6 "parts"
Mean_Order = repmat(Mean_Order,1,50);
Mean_Order = Mean_Order(:, randperm(size(Mean_Order, 2)));  %% Shuffle the columns

%% English Version Instructions

Screen('TextSize', window, Num_Size);
Screen('TextFont', window, 'Times');

DrawFormattedText(window,Ins1_1,'center','center');
Screen('Flip',window);

while 1
    [~,~,kC] = KbCheck();
    if kC(KbName('space'))
        break
    end
end

Screen('Flip',window);
WaitSecs(1);

DrawFormattedText(window,Ins1_2,'center','center');
Screen('Flip',window);

while 1
    [~,~,kC] = KbCheck();
    if kC(KbName('space'))
        break
    end
end

Screen('Flip',window);
WaitSecs(1);

DrawFormattedText(window,Ins1_3,'center','center');
Screen('Flip',window);

while 1
    [~,~,kC] = KbCheck();
    if kC(KbName('space'))
        break
    end
end

Screen('Flip',window);
WaitSecs(1);

DrawFormattedText(window,Ins1_4,'center','center');
Screen('Flip',window);

while 1
    [~,~,kC] = KbCheck();
    if kC(KbName('space'))
        break
    end
end

Screen('TextSize', window, Word_Size);
Screen('TextFont', window, 'Times');

%% Practice Block
for ite = 1:nprac
    HideCursor;
    TRIAL = Order_Prac(ite);
    pic_num = randsample(1:136,TRIAL);
    
    rect_num = randperm(6,TRIAL);
    rect_6 = RECT(:,rect_num);
    DrawFormattedText(window,'+','center',y_center - Move);
    Screen('Flip',window);
    WaitSecs(Waiting_Time);
    
    for Disp = 1:TRIAL
        
        Screen('DrawTextures',window,pointer_face(pic_num(Disp)),[],rect_6(:,Disp),Interleave_Order(ite));
        Screen('Flip',window);
        DUR = Duration / TRIAL - 0.0167;
        WaitSecs(DUR);
        Screen('Flip',window);
        WaitSecs(ISI);
        
    end
    
    Get_Response;
    
end

%% English Version Instructions

Screen('TextSize', window, Num_Size);
Screen('TextFont', window, 'Times');

DrawFormattedText(window,Ins2,'center','center');
Screen('Flip',window);

while 1
    [~,~,kC] = KbCheck();
    if kC(KbName('space'))
        break
    end
end

Screen('TextSize', window, Word_Size);
Screen('TextFont', window, 'Times');


%% Block 1~3
m_all_image = Image_Pilot(3,:);

for ite = 1:ntrial
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
    
    for Disp = 1:TRIAL
        %DrawFormattedText(window,'+','center',y_center - Move);
        Screen('DrawTextures',window,pointer_face(pic_num(Disp)),[],rect_6(:,Disp),Interleave_Order(ite));
        Screen('Flip',window);
        DUR = Duration / TRIAL - 0.0167;
        WaitSecs(DUR);
        %DrawFormattedText(window,'+','center',y_center - Move);
        Screen('Flip',window);
        WaitSecs(ISI);
        
    end
    T2 = GetSecs();
    Get_Response;   %Calling the Get_Response Function, this is the slider bar function
    
    
    TIMING(ite) = T2 - T1;
    RESPONSE(ite) = response;
    
    MEAN(ite) = mean(Image_Pilot(3,pic_num));
    STD(ite) = std(Image_Pilot(3,pic_num));
    Face{ite} = pic_num;
    MEAN_WHOLE(ite) = mean(Image_Pilot(3,pic_num_all));
    
    
    if ite == 100
        Start_Time = GetSecs();
        while GetSecs < Start_Time + Rest
            Time_Left = ceil(Rest - (GetSecs - Start_Time));
            DrawFormattedText(window, ['TIME FOR A BREAK! \n\n TIME LEFT: ', ...
                num2str(Time_Left),' secs'],'center','center');
            Screen('Flip',window);
        end
        
        DrawFormattedText(window,'Press SPACE to continue','center','center');
        Screen('Flip',window);
        while 1
            [~,~,kC] = KbCheck();
            if kC(KbName('space'))
                break
            end
        end
        
    end
    
    
    if ite == 200
        Start_Time = GetSecs();
        while GetSecs < Start_Time + Rest
            Time_Left = ceil(Rest - (GetSecs - Start_Time));
            DrawFormattedText(window, ['Time for a break! \n\n TIME LEFT: ', ...
                num2str(Time_Left),' secs'],'center','center');
            Screen('Flip',window);
        end
        
        DrawFormattedText(window,'Press SPACE to continue','center','center');
        Screen('Flip',window);
        while 1
            [~,~,kC] = KbCheck();
            if kC(KbName('space'))
                break
            end
        end
    end
    cd DATA_Temporal_Interleave  % The data is saved in every single loop, so that crashing will not cause too much loss
    save(filename);
    cd ..
end

sca;

ListenChar(1);
ShowCursor();
%% Save the results
RESULTS_ALL = [MEAN;MEAN_WHOLE;STD;RESPONSE;Order;Interleave_Order];
cd DATA_Temporal_Interleave
save(filename);
cd ..

