%% This is the main function of the program clear all;
% MAIN.m

clear all;
close all;
clc;

%% Initializing the variables
Version = 'Inverted';
load Image_Pilot
KbName('UnifyKeyNames');
rng('shuffle');
Waiting_Time = 0.5; %Intervals (Blank Screen), 0.5
Cross_Delay = 0.6; %Fixation Cross Duration, 0.6
Duration = 1;  %Time for duration of display, 1
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
xStart = window_w * 0.25;
xEnd = window_w * 0.75;
yStart = window_h * 0.3;
yEnd = window_h * 0.7;
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

%% Order
Order_Prac = randperm(6);

nprac = 6;

Order = Shuffle([ones(1,ntrial /6),2*ones(1,ntrial /6),3*ones(1,ntrial /6), ...
    4*ones(1,ntrial /6),5*ones(1,ntrial /6),6*ones(1,ntrial /6)]);

%%
Mean_Order = [3.8,4.6,5.2,5.8,6.4,7;4.6,5.2,5.8,6.4,7,8]; %6 "parts"
Mean_Order = repmat(Mean_Order,1,50);
Mean_Order = Mean_Order(:, randperm(size(Mean_Order, 2)));  %% Shuffle the columns

% Instruction

%% These instructions are for the Chinese Version
% Ins1_Img = imread('Ins_1.png');
% Ins1 = Screen('MakeTexture',window,Ins1_Img);
% Ins1_width = 1200 * MACHINE;
% Ins1_height = Ins1_width*size(Ins1_Img,1)/size(Ins1_Img,2);
% Ins_Rect1 = [x_center - Ins1_width/2, y_center - Ins1_height/2,...
%     x_center + Ins1_width/2, y_center + Ins1_height/2];
% Screen('DrawTextures',window,Ins1,[],Ins_Rect1);

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
    DrawFormattedText(window,'+','center','center');
    Screen('Flip',window);
    WaitSecs(Waiting_Time);
    DrawFormattedText(window,'+','center','center');
    Screen('DrawTextures',window,pointer_face(pic_num),[],rect_6,180);
    Screen('Flip',window);
    WaitSecs(Duration);
    Screen('Flip',window);
    WaitSecs(Waiting_Time);
    Get_Response;
    
    %RESPONSE(ite) = response;
end

%% Instructions for formal start
% Chinese Version Again
% Ins2_Img = imread('Ins_2.png');
% Ins2 = Screen('MakeTexture',window,Ins2_Img);
% Ins2_width = 1200 * MACHINE;
% Ins2_height = Ins2_width*size(Ins2_Img,1)/size(Ins2_Img,2);
% Ins_Rect2 = [x_center - Ins2_width/2, y_center - Ins2_height/2,...
%     x_center + Ins2_width/2, y_center + Ins2_height/2];
% Screen('DrawTextures',window,Ins2,[],Ins_Rect2);

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
    DrawFormattedText(window,'+','center','center');
    Screen('Flip',window);
    WaitSecs(Waiting_Time);
    DrawFormattedText(window,'+','center','center');
    Screen('DrawTextures',window,pointer_face(pic_num),[],rect_6,180);
    Screen('Flip',window);
    WaitSecs(Duration);
    Screen('Flip',window);
    WaitSecs(Waiting_Time);
    Get_Response;   %Calling the Get_Response Function, this is the slider bar function
    % Location Scan
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
    cd DATA_Inverted  % The data is saved in every single loop, so that crashing will not cause too much loss
    save(filename);
    cd ..
end

sca;

ListenChar(1);
ShowCursor();
%% Save the results
RESULTS_ALL = [MEAN;MEAN_WHOLE;STD;RESPONSE;Order];
cd DATA_Inverted
save(filename);
cd ..

