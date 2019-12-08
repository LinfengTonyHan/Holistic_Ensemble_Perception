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

text={'1','2','3','4','5','6','7','8','9'};
for i=1:mark_num
    Screen('DrawText', window, text{i}, mark_x(i)-5, mark_y(i)-30*MACHINE); % Write text to confirm loading of images
end
Screen('FillRect',window,bar_color,bar_rect);
Screen('FillRect',window,mark_color,mark_rect);
DrawFormattedText(window,'Positive',right,up);
DrawFormattedText(window,'Negative',left,up);
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
    Screen('Flip', window);
   
    %participant clicks to indicate his/her answer
    %the block stops moving
    if any(clicks)
        if mouse_x >= bar_rect(1) && mouse_x<=bar_rect(3) %&& mouse_y>=y_center-block_h/2 && mouse_y<=y_center+block_h/2
            block_x = mouse_x;
        elseif mouse_x < bar_rect(1)
            block_x = bar_rect(1);
        elseif mouse_x > bar_rect(3)
            block_x = bar_rect(3);
        end
        
        response = (block_x-bar_rect(1))/bar_w;
        response = 8*response + 1;
        
        for i=1:mark_num
            Screen('DrawText', window, text{i}, mark_x(i)-5, mark_y(i)-30*MACHINE); % Write text to confirm loading of images
        end
        Screen('FillRect',window,bar_color,bar_rect);
        Screen('FillRect',window,mark_color,mark_rect);
        Screen('FillRect',window,block_color,[block_x-block_w/2 y_center-block_h/2 block_x+block_w/2 y_center+block_h/2]);
        DrawFormattedText(window,'Positive',right,up);
        DrawFormattedText(window,'Negative',left,up);
        Screen('Flip', window);
    end
end

Screen('TextSize', window, Word_Size);
Screen('TextFont', window, 'Times');

