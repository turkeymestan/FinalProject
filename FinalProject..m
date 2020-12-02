%% Goal of Script
% Final project We are attempting to code a behavioral experiment 
% using a posner cueing paradigm. A cue will be presented, pointing 
% to one side of the visual field. Two images will then be presented, 
% one of a subject with a gun, the other a subject without a gun. The 
% test subject must press the 'F' key if the gun is on the left side, 
% and must press the 'j' key if the gun is on the right side of the screen. 
% Reaction time as a function of accuracy will be studied, and we will 
% attempt to determine if the cueing had any effect on the accuracy/reaction time.

%% Clear
clear all; 
clc; 

%% Input list
% First Name
% Space presses
% F and J key presses

%% Output list
% D.subID; subject ID
% D.time ; reaction time
% D.race ; race of model with gun; 1 = black,  0 = white
% D.correct ; Whether the study participant correctly identified the side with the gun ; 1 = yes, 0 = no
% D.cueAndGun; Whether the cue and gun were on the same side of the screen ;  1 = yes, 0 = no
% D.trialNumber 

%% recording user input (before psychtoolbox window opens)
prompt = {'Enter first name:'}; % these lines create a dialog box for subject ID input.
dlgtitle = 'Subject ID';
dims = [1 35];
definput = {'First'};
name =  inputdlg(prompt,dlgtitle,dims,definput);

%% Open the main screen 
Screen('Preference','ConserveVRAM',64); 
Screen('Preference', 'SkipSyncTests', 1); 
[onScreen, screenRect] = Screen('OpenWindow',0);    % opens the mainscreen 
Screen('FillRect', onScreen, [255 255 255]);        % paints screen (on the offscreen buffer) 

%% Define Variables 

NumTrials = 50; % number of trials  

dir('ExperimentPhotos/*.jpg'); % set directory 

% formatting text for drawing 
centerX = screenRect(3)/2; % center X coordinate 
centerY = screenRect(4)/2; % center Y coordinate 
textColor = [0 150 80];

% texture parameters 
displayWidth = 400; % these two variables essential for drawing our textures, do not remove without warning. 
displayHeight = 400;

destinationRect1 = CenterRectOnPoint([0 0 displayWidth displayHeight], centerX-500, centerY);
destinationRect2 = CenterRectOnPoint([0 0 displayWidth displayHeight], centerX+500, centerY);

% Fixation cross varibles
screenWidth   = screenRect(3)-screenRect(1); % width of screen = right-left
screenHeight  = screenRect(4)-screenRect(2); % height of screen = bottom-top (remember, top of screen is 0)

screenCenterX = screenWidth/2; % center of screen is half of screen width
screenCenterY = screenHeight/2; % center of screen is half of screen height

fixation.color = [0 0 0]; % make it black
fixation.size = 12;
fixation.penWidth = 4;

% horizontal line
fromH1 = screenCenterX-fixation.size;
fromV1 = screenCenterY;
toH1   = screenCenterX+fixation.size;
toV1   = screenCenterY;

% vertical line
fromH2 = screenCenterX;
fromV2 = screenCenterY-fixation.size;
toH2   = screenCenterX;
toV2   = screenCenterY+fixation.size;

% Create directories for folders
a = dir(fullfile('ExperimentPhotos/BlackArmed/*.jpg')); % folder 1 black & gun
b = dir(fullfile('ExperimentPhotos/BlackUnarmed/*.jpg')); % folder 2 black & no gun
c = dir(fullfile('ExperimentPhotos/WhiteArmed/*.jpg')); % folder 3 white & gun
d = dir(fullfile('ExperimentPhotos/WhiteUnarmed/*.jpg')); % folder 4 white & no gun

%% Present instructions and wait for key press
InstructTrial = 'A cue will first appear.\nYou will then see two images appear.\nPress the <F> key if the weapon is on the left side of the screen.\nPress the <J> key if the weapon is on the right side of the screen.\nPress the space  key to continue.'; 
Screen('TextSize', onScreen ,30 );
DrawFormattedText(onScreen, InstructTrial,centerX-450,centerY,textColor);
Screen('Flip', onScreen);

[keyIsDown,secs,keyCode]=KbCheck(); 
while ~any(keyCode(KbName('space')))
    [keyIsDown,secs,keyCode]=KbCheck();
end 

InstructTrial = 'The session will begin in...';
DrawFormattedText(onScreen, InstructTrial,centerX-300,centerY,textColor);
Screen('Flip', onScreen);
pause (1.5);

InstructTrial = '3';
DrawFormattedText(onScreen, InstructTrial,centerX,centerY,textColor);
Screen('Flip', onScreen);
pause(1);

InstructTrial = '2';
DrawFormattedText(onScreen, InstructTrial,centerX,centerY,textColor);
Screen('Flip', onScreen);
pause(1);

InstructTrial = '1';
DrawFormattedText(onScreen, InstructTrial,centerX,centerY,textColor);
Screen('Flip', onScreen);
pause (1);   

%% Run trials 

for i=1: NumTrials 
D(i).trialNumber = {i};
%subID repeats for all trials
D(i).subID = cellstr(name);
Screen('DrawLine', onScreen, fixation.color, fromH1, fromV1, toH1, toV1, fixation.penWidth);
Screen('DrawLine', onScreen, fixation.color, fromH2, fromV2, toH2, toV2, fixation.penWidth);
Screen('Flip', onScreen);
pause(0.75);
% randomize the matrix "Folder"
loopOrderFolder = randperm(4);
RandomNumberLeft = Ranint(1,10);
RandomNumberRight = Ranint(1,10);
    if loopOrderFolder(1)==1;
       imageLeft = imread(a(RandomNumberLeft).name);
       imageRight = imread(d(RandomNumberRight).name);
       Gun = 1;
       D(i).race = {'B'}; 
       % Make texture
       textureLeft=Screen('MakeTexture', onScreen, imageLeft);
       textureRight=Screen('MakeTexture', onScreen, imageRight);
   elseif loopOrderFolder(1)==2;
       imageLeft = imread(b(RandomNumberLeft).name);
       imageRight = imread(c(RandomNumberRight).name);
       Gun = 0;
       D(i).race = {'W'};
         % Make texture
       textureLeft=Screen('MakeTexture', onScreen, imageLeft);
       textureRight=Screen('MakeTexture', onScreen, imageRight);
   elseif loopOrderFolder(1)==3;
       imageLeft = imread(c(RandomNumberLeft).name);
       imageRight = imread(b(RandomNumberRight).name);
       Gun = 1;
       D(i).race = {'W'};
         % Make texture
       textureLeft=Screen('MakeTexture', onScreen, imageLeft);
       textureRight=Screen('MakeTexture', onScreen, imageRight);
   elseif loopOrderFolder(1)==4;
      imageLeft = imread(d(RandomNumberLeft).name);
      imageRight = imread(a(RandomNumberRight).name);
      Gun = 0;
      D(i).race = {'B'};
        % Make texture
      textureLeft=Screen('MakeTexture', onScreen, imageLeft);
      textureRight=Screen('MakeTexture', onScreen, imageRight);
    end
    %draw fixation cross 
    Screen('DrawLine', onScreen, fixation.color, fromH1, fromV1, toH1, toV1, fixation.penWidth);
    Screen('DrawLine', onScreen, fixation.color, fromH2, fromV2, toH2, toV2, fixation.penWidth);
    %draw cue
    Cue = Ranint(1,2);
    if Cue == 1
        Screen('FillOval', onScreen, [255 0 0], [centerX-185 centerY-5 centerX-175 centerY+5], 40);
        CuePosition = 1;
    else
        Screen('FillOval', onScreen, [255 0 0], [centerX+175 centerY-5 centerX+185 centerY+5], 40 );
        CuePosition = 0;
    end
    % Draw Circle On Main Screen
    Screen('Flip', onScreen);
    pause(.35);
    %draw fixation cross  
    Screen('DrawLine', onScreen, fixation.color, fromH1, fromV1, toH1, toV1, fixation.penWidth);
    Screen('DrawLine', onScreen, fixation.color, fromH2, fromV2, toH2, toV2, fixation.penWidth);
    %draw textures to left and right sides of screen
    Screen('DrawTexture', onScreen, textureLeft, [],destinationRect1)
    Screen('DrawTexture', onScreen, textureRight, [],destinationRect2)
    [keyIsDown,secs,keyCode]=KbCheck();
    if Gun == CuePosition;
            D(i).cueAndGun = {1};
        else
            D(i).cueAndGun = {0};
    end
    Screen('Flip', onScreen);
    tic
    % Is the participant correct in which person has the gun?   
    while ~any(keyIsDown) == 1;
        [keyIsDown,secs,keyCode]=KbCheck();
         if any(keyCode(KbName('f')))
            D(i).time = {toc*1000};
            if Gun == 1;
                D(i).correct = {1};
            else
                D(i).correct = {0};
            end
         else if any(keyCode(KbName('j')))
            D(i).time = {toc*1000}; 
            if Gun == 0;
               D(i).correct = {1};
            else
                D(i).correct = {0};
            end
             end
         end
    end
end

% Pause 1 second
pause (1)

InstructTrial = 'This is the end of the session. \n \nPlease press space to exit.'; 
Screen('TextSize', onScreen ,30);
DrawFormattedText(onScreen, InstructTrial,centerX-450,centerY,textColor);
Screen('Flip', onScreen);

[keyIsDown,secs,keyCode]=KbCheck();  
 
while ~any(keyCode(KbName('space')))
    [keyIsDown,secs,keyCode]=KbCheck();
    if any(keyCode(KbName('space')))
         Screen('CloseAll');  
    end  
end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% These need to be done:
% save your D struct in a .mat file in the DataFiles folder  
save('ExperimentPhotos/structdata.mat','D') 
% generate a figure for display 
T = struct2table(D);
uitable('Data',T{:,:},'ColumnName',T.Properties.VariableNames,...
    'RowName',T.Properties.RowNames,'Units', 'Normalized', 'Position',[0, 0, 1, 1]); 
