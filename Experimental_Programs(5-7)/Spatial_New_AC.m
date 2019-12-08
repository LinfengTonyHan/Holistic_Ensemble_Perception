%% This is the main function of the program -- spatially distributed display (more holistic stimulus set)
% On each trial, 1 ~ 6 faces are randomly selected from the stimulus set.
% These faces are simultaneously displayed for 1 second.
% The overall distribution of the mean is nearly uniform.

clear all;
close all;
clc;
 
%% Initializing the variables
Version = 'Spatial_New_1s';
load Image_Pilot.mat
KbName('UnifyKeyNames');
rng('shuffle');
Waiting_Time = 0.5; %Intervals (Blank Screen), 0.5
ISI = 0.100;
ISI = ISI - 0.0167;
Cross_Delay = 0.6; %Fixation Cross Duration, 0.6
Duration = 1;  %Time for duration of display, 1
Duration = Duration - 0.0167;
ntrial = 600;  %600
Rest = 30;  %Resting time in trial 150, 300, 450  should be 30 secs
F_Sc = [];
P_Sc = [0,0,900,650];
Num_Size = 24;
Word_Size = 35;
img_ratio = 1;
npic = 250;
att_loop = 1;
att_times = 15;
att_trials = round(600/att_times);
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

%% Loading the Stimuli
cd New_Stimuli_Selected 

for s=1:npic
    IMG_UP=imread(['img_UP_',num2str(s),'.tif']);
    pointer_face_UP(s)=Screen('MakeTexture', window ,IMG_UP);
end
for s=1:npic
    IMG_IN=imread(['img_IN_',num2str(s),'.tif']);
    pointer_face_IN(s)=Screen('MakeTexture', window ,IMG_IN);
end

cd ..

%% Defining the Circle
img_height = size(IMG_UP,1) * MACHINE * img_ratio;
img_width = size(IMG_UP,2) * MACHINE * img_ratio;

num_pts = 6;

xStart = window_w * 0.35;
xEnd = window_w * 0.65;
yStart = window_h * 0.32;
yEnd = window_h * 0.68;
nRows = 2;
nCols = 3;

xGridLines = linspace(xStart, xEnd, nCols);
yGridLines = linspace(yStart, yEnd, nRows);
[xPoints, yPoints] = meshgrid(xGridLines, yGridLines);
RECT = [xPoints(:)'-img_width/2; yPoints(:)'-img_height/2; ...
    xPoints(:)'+img_width/2; yPoints(:)'+img_height/2];

TIMING = zeros(1,ntrial);

%% Order 
nprac = 12;

Order_Prac = [randperm(6),randperm(6)];
Trial_Order = repmat([0,1],1,ntrial/2);
Order = [ones(1,ntrial /6),2*ones(1,ntrial /6),3*ones(1,ntrial /6), ...
    4*ones(1,ntrial /6),5*ones(1,ntrial /6),6*ones(1,ntrial /6)];
ALL_Order = [Trial_Order;Order];
ALL_Order = ALL_Order(:, randperm(size(ALL_Order, 2))); 
Trial_Order = ALL_Order(1,:);
Order = ALL_Order(2,:);
%% 
Mean_Order = [3,4.1,4.8,5.5,6.2,6.9;4.1,4.8,5.5,6.2,6.9,8]; %6 "parts"
Mean_Order = repmat(Mean_Order,1,ntrial/6);
Mean_Order_UP = Mean_Order(:, randperm(size(Mean_Order, 2)));  %% Shuffle the columns
Mean_Order_IN = Mean_Order(:, randperm(size(Mean_Order, 2))); 

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
        pic_num = randsample(1:npic,TRIAL);
        
        rect_num = randperm(6,TRIAL);
        rect_num = sort(rect_num);
        rect_6 = RECT(:,rect_num);
        DrawFormattedText(window,'+','center',y_center - Move);
        Screen('Flip',window);
        WaitSecs(Waiting_Time);
        
        if Trial_Order(ite) == 0
        
        %DrawFormattedText(window,'+','center',y_center - Move);
        Screen('DrawTextures',window,pointer_face_UP(pic_num),[],rect_6);
        Screen('Flip',window);
        WaitSecs(Duration);
        %DrawFormattedText(window,'+','center',y_center - Move);
        Screen('Flip',window);
        
        elseif Trial_Order(ite) == 1
           
        %DrawFormattedText(window,'+','center',y_center - Move);
        Screen('DrawTextures',window,pointer_face_IN(pic_num),[],rect_6);
        Screen('Flip',window);
        WaitSecs(Duration);
        %DrawFormattedText(window,'+','center',y_center - Move);
        Screen('Flip',window);
    
        
        end
        
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

        if ~(mod(ite,att_trials)==0)
            Display_Spatial;
        else
            Display_Spatial;
            Attention_Check_Spatial;
        end
        if ite == 100 || ite == 200 || ite == 300 || ite == 400 || ite == 500
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
        
       
cd DATA_Spatial_New  % The data is saved in every single loop, so that crashing will not cause too much loss
save(filename);
cd ..   
end

sca;

ListenChar(1);
ShowCursor();
%% Save the results
RESULTS_ALL = [MEAN;MEAN_WHOLE;STD;RESPONSE;Order];
cd DATA_Spatial_New
save(filename);
cd ..


