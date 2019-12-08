ShowCursor;
Screen('TextSize', window, Num_Size);
Screen('TextFont', window, 'Times');

DIS = 530 * MACHINE;
W = 60 * MACHINE;
H = 30 * MACHINE;
EMO_WIDTH = W/2;
EMO_HEIGHT = H/2;
Dw = 10 * MACHINE;

left = x_center - 590 * MACHINE;
right = x_center + 500 * MACHINE;
up = y_center - 13;

EMO_POSR = [x_center+DIS-EMO_WIDTH,y_center-EMO_HEIGHT-Dw, ...
    x_center+DIS+EMO_WIDTH,y_center+EMO_HEIGHT-Dw];
EMO_NEGR = [x_center-DIS-EMO_WIDTH,y_center-EMO_HEIGHT-Dw, ...
    x_center-DIS+EMO_WIDTH,y_center+EMO_HEIGHT-Dw];

bar_w=950*MACHINE;
bar_h=6*MACHINE;
bar_rect=[x_center-bar_w/2 y_center-bar_h/2 x_center+bar_w/2 y_center+bar_h/2];
bar_color=[1 1 1];

mark_num=9;
mark_w=3*MACHINE;
mark_h=10*MACHINE;
mark_x=linspace(bar_rect(1)+mark_w/2,bar_rect(3)-mark_w/2,mark_num);
mark_y=repmat(bar_rect(2),1,mark_num);
mark_rect=[mark_x(:)'-mark_w/2; mark_y(:)'-mark_h; mark_x(:)'+mark_w/2; mark_y(:)'];
mark_color=[1 1 1];

block_w=10*MACHINE;
block_h=20*MACHINE;
block_y=y_center;
block_color=[1 1 255];

% button_distance_x=250;
% button_distance_y=150;
% button_w=100;
% button_h=40;
% confirm_x=x_center-button_distance_x;
% confirm_y=y_center+button_distance_y;
% confirm_text='Confirm';
% cancel_x=x_center+button_distance_x;
% cancel_y=y_center+button_distance_y;
% cancel_text='Cancel';
% confirm_rect=[confirm_x-button_w/2 confirm_y-button_h/2 confirm_x+button_w/2 confirm_y+button_h/2];
% cancel_rect=[cancel_x-button_w/2 cancel_y-button_h/2 cancel_x+button_w/2 cancel_y+button_h/2];

text={'1','2','3','4','5','6','7','8','9'};
% Screen('TextSize', window, 18);
for i=1:mark_num
    Screen('DrawText', window, text{i}, mark_x(i)-5, mark_y(i)-30*MACHINE); % Write text to confirm loading of images
end
 Screen('FillRect',window,bar_color,bar_rect);
 Screen('FillRect',window,mark_color,mark_rect);
 DrawFormattedText(window,'Positive',right,up);
 DrawFormattedText(window,'Negative',left,up);
%Screen('DrawTextures',window,Pos,[],EMO_POSR);
%Screen('DrawTextures',window,Neg,[],EMO_NEGR);

 Screen('Flip', window);
 
 
[mouse_x,mouse_y,clicks] = GetMouse;
%the block slides on the bar in accordance with the Mouse's movement
while ~any(clicks) % if NOT already down, wait for release
        [mouse_x,mouse_y,clicks] = GetMouse;
         if mouse_x>=bar_rect(1) && mouse_x<=bar_rect(3) %&& mouse_y>=y_center-block_h/2 && mouse_y<=y_center+block_h/2
             block_x=mouse_x;
         elseif mouse_x<bar_rect(1)
             block_x=bar_rect(1);
         elseif mouse_x>bar_rect(3)
             block_x=bar_rect(3);
         end
            for i=1:mark_num
                Screen('DrawText', window, text{i}, mark_x(i)-5, mark_y(i)-30*MACHINE); % Write text to confirm loading of images
            end
            Screen('FillRect',window,bar_color,bar_rect);
            Screen('FillRect',window,mark_color,mark_rect);
            Screen('FillRect',window,block_color,[block_x-block_w/2 y_center-block_h/2 block_x+block_w/2 y_center+block_h/2]);
DrawFormattedText(window,'Positive',right,up);
DrawFormattedText(window,'Negative',left,up);
 %Screen('DrawTextures',window,Pos,[],EMO_POSR);
 % Screen('DrawTextures',window,Neg,[],EMO_NEGR);
            Screen('Flip', window);
   
         
    %participant clicks to indicate his/her answer
    %the block stops moving
if any(clicks) 
         if mouse_x>=bar_rect(1) && mouse_x<=bar_rect(3) %&& mouse_y>=y_center-block_h/2 && mouse_y<=y_center+block_h/2
             block_x=mouse_x;
         elseif mouse_x<bar_rect(1)
             block_x=bar_rect(1);
         elseif mouse_x>bar_rect(3)
             block_x=bar_rect(3);
         end
         
         response=(block_x-bar_rect(1))/bar_w;
         response = 8*response + 1;
         
        for i=1:mark_num
            Screen('DrawText', window, text{i}, mark_x(i)-5, mark_y(i)-30*MACHINE); % Write text to confirm loading of images
        end
        Screen('FillRect',window,bar_color,bar_rect);
        Screen('FillRect',window,mark_color,mark_rect);
        Screen('FillRect',window,block_color,[block_x-block_w/2 y_center-block_h/2 block_x+block_w/2 y_center+block_h/2]);
 DrawFormattedText(window,'Positive',right,up);
 DrawFormattedText(window,'Negative',left,up);
%         Screen('TextSize', window, 20);
%         Screen('FrameRect', window,[1 1 1],confirm_rect,2);
%         Screen('DrawText', window, confirm_text, confirm_x-35, confirm_y-13);
%         Screen('FrameRect', window,[1 1 1],cancel_rect,2);
%         Screen('DrawText', window, cancel_text, cancel_x-30, cancel_y-13);

% Screen('DrawTextures',window,Pos,[],EMO_POSR);
% Screen('DrawTextures',window,Neg,[],EMO_NEGR);
        Screen('Flip', window);
%         WaitSecs(Waiting_Time);
end
end

% 
% WaitSecs(0.2)
% [mouse_x,mouse_y,clicks] = GetMouse;
% while ~any(clicks)
% if any(clicks) 
%         [mouse_x,mouse_y,clicks] = GetMouse; % check continuously....
%          if mouse_x>=confirm_rect(1) && mouse_x<=confirm_rect(3) && mouse_y>=confirm_rect(2) && mouse_y<=confirm_rect(4)
%                 %click comfirm
%                 Screen('FrameRect', window,[1 1 1],confirm_rect,2);
%                 Screen('DrawText', window, confirm_text, confirm_x-35, confirm_y-13);
%          elseif mouse_x>=cancel_text(1) && mouse_x<=cancel_text(3) && mouse_y>=cancel_text(2) && mouse_y<=cancel_text(4)
%              %click cancel
%                 Screen('FrameRect', window,[1 1 1],cancel_rect,2);
%                 Screen('DrawText', window, cancel_text, cancel_x-30, cancel_y-13);
%          end
%         Screen('Flip', window);
%         WaitSecs(2); %% blank
% end
% end

%disp(result);

%Screen('CloseAll'); 

Screen('TextSize', window, Word_Size);
Screen('TextFont', window, 'Times');

