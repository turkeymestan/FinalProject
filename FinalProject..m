%%%%%% I dont think we need this anymore but we can keep it for now incase we need it. 
%%%%%% It includes a struct input we may need.
  % wait for a response (keyboard input) 
 % [keyIsDown,keyTime,keyCode] = KbCheck; 
  %while keyIsDown==1;
   % whichKeys = find(keyCode==1);
    %if keyCode == 70 &  % label for weapon is left
     %   d.correct = 1
    %else if keyCode == 70 &  % label for weapon is right
     %    d.correct = 0
    %else if keyCode == 74 &  % label for weapon is right
     %    d.correct = 1
    %else if keyCode == 74 &  % label for weapon is left
     %    d.correct = 0 
    %end
  %end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Goal of Script
% Final project We are attempting to code a behavioral experiment 
% using a posner cueing paradigm. A cue will be presented, pointing 
% to one side of the visual field. Two images will then be presented, 
% one of a subject with a gun, the other a subject without a gun. The 
% test subject must press the 'F' key if the cue points towards the gun, 
% and must press the 'j' key if the cue does not point towards the gun. 
% Reaction time as a function of accuracy will be studied, and we will 
% attempt to determine if the cueing had any effect on the accuracy/reaction time.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Clear all
clear all; 
clc; 

%% recording user input (before psychtoolbox window opens)
prompt = {'Enter first name:','Enter last name:'}; % these lines create a dialog box for subject ID input.
dlgtitle = 'Subject ID';
dims = [1 35];
definput = {'First', 'Last'};
answer = input (prompt,dlgtitle,dims,definput);

D.subID = answer; 
%save('ExperimentResults.txt','D.subID');

%% Open the main screen 
Screen('Preference','ConserveVRAM',64); 
Screen('Preference', 'SkipSyncTests', 1); 
[onScreen, screenRect] = Screen('OpenWindow',0);    % opens the mainscreen 
Screen('FillRect', onScreen, [255 255 255]);        % paints screen (on the offscreen buffer) 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Create Struct
T = struct2table(D)
%%%% Does this need to be moved before the first variable is introduced?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Define Variables 

NumTrials = 50; % number of trials  

dir('ExperimentPhotos/*.jpg'); % sets current directory to ExperimentFiles folder, where there will be two other folders (1) Armed Files (2) Unarmed Files  

% the f key is key number 70 
% the j key is key number 74 

% formatting text for drawing 
centerX = screenRect(3)/2; % center X coordinate 
centerY = screenRect(4)/2; % center Y coordinate 
textColor = [0 150 80];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define displayWidth & displayHeight OR load all images in before for loop and use size(imageLeft) w/in for loop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

destinationRect1 = CenterRectOnPoint([0 0 displayWidth displayHeight], centerX-500, centerY);
destinationRect2 = CenterRectOnPoint([0 0 displayWidth displayHeight], centerX+500, centerY);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% What is happening with these??
%fID = fopen('ExperimentResults.txt', 'w'); % creates new text file titled ExperimentResults
% to write to ExperimentResults = fprint(fID, '%s\t%s\t%d\n')
%D.time =
%D.race = 
%D.correct = 
%D.trialNumber = 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Make sure this is centered
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Present instructions and wait for key press
InstructTrial = 'A cue will first appear.\nYou will then see two images appear.\nPress the <F> key if the cue points to a weapon.\nPress the <J> key if the cue does not point towards a weapon.\nPress the space  key to continue.'; 
Screen('TextSize', onScreen ,30 );
DrawFormattedText(onScreen, InstructTrial,centerX-450,centerY,textColor);
Screen('Flip', onScreen);

[keyIsDown,secs,keyCode]=KbCheck(); 
while ~any(keyCode(KbName('space')))
    [keyIsDown,secs,keyCode]=KbCheck();
end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Make sure this is centered
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
InstructTrial = 'The session will begin in...';
DrawFormattedText(onScreen, InstructTrial,centerX-100,centerY,textColor);
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% see displayRSVP_record from lab 4 for writing to data file in data set.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1: NumTrials 
% randomize the matrix "Folder"
loopOrderFolder = randperm(4);
RandomNumberLeft = Ranint(1,10);
RandomNumberRight = Ranint(1,10);
    if loopOrderFolder(1)==1;
       imageLeft = imread(a(RandomNumberLeft).name);
       imageRight = imread(d(RandomNumberRight).name);
       % Make texture
       textureLeft=Screen('MakeTexture', onScreen, imageLeft);
       textureRight=Screen('MakeTexture', onScreen, imageRight);
   elseif loopOrderFolder(1)==2;
       imageLeft = imread(b(RandomNumberLeft).name);
       imageRight = imread(c(RandomNumberRight).name);
         % Make texture
       textureLeft=Screen('MakeTexture', onScreen, imageLeft);
       textureRight=Screen('MakeTexture', onScreen, imageRight);
   elseif loopOrderFolder(1)==3;
       imageLeft = imread(c(RandomNumberLeft).name);
       imageRight = imread(b(RandomNumberRight).name);
         % Make texture
       textureLeft=Screen('MakeTexture', onScreen, imageLeft);
       textureRight=Screen('MakeTexture', onScreen, imageRight);
   elseif loopOrderFolder(1)==4;
      imageLeft = imread(d(RandomNumberLeft).name);
      imageRight = imread(a(RandomNumberRight).name);
        % Make texture
      textureLeft=Screen('MakeTexture', onScreen, imageLeft);
      textureRight=Screen('MakeTexture', onScreen, imageRight);
   end
 end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %% resource for insufficient memory error -> https://github.com/Psychtoolbox-3/Psychtoolbox-3/issues/276
 % ^ says occurs when using multiple screens? Does the virual desktop treat its projection as an extra screen?
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%draw fixation cross 
Screen('DrawLine', onScreen, fixation.color, fromH1, fromV1, toH1, toV1, fixation.penWidth);
Screen('DrawLine', onScreen, fixation.color, fromH2, fromV2, toH2, toV2, fixation.penWidth);
%draw cue
Cue = Ranint(1,2);
    if Cue == 1
        Screen('FillOval', onScreen, [0 0 0], [centerX-255 centerY-5 centerX-245 centerY+5], 40);
        CuePosition = 'left';
    else
        Screen('FillOval', onScreen, [0 0 0], [centerX+245 centerY-5 centerX+255 centerY+5], 40);
        CuePosition = 'right';
    end
        % Draw Circle On Main Screen
Screen('Flip', onScreen);
pause(.2);
%draw fixation cross  
Screen('DrawLine', onScreen, fixation.color, fromH1, fromV1, toH1, toV1, fixation.penWidth);
Screen('DrawLine', onScreen, fixation.color, fromH2, fromV2, toH2, toV2, fixation.penWidth);
%draw textures to left and right sides of screen
Screen('DrawTexture', onScreen, textureLeft, [],destinationRect1)
Screen('DrawTexture', onScreen, textureRight, [],destinationRect2)
Screen('Flip', onScreen);
pause(2);% pause for 2 seconds
tic
% Is the participant correct in which person has the gun?   
    while ~any(keyCode==keyIsDown))
        [keyIsDown,secs,keyCode]=KbCheck();
         if any(keyCode(KbName('f')))
            duration = toc*1000;
            if Gun == 'left';
                GunCorrect = 1;
            else
                GunCorrect = 0;
            end
         else if any(keyCode(KbName('j')))
            duration = toc*1000; 
            if Gun == 'right';
                GunCorrect = 1';
            else
                GunCorrect = 0;
            end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Add whether the cue was on the same side as the gun
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
% Is the cue on the same side as the gun?
    while ~any(keyCode==keyIsDown)
        [keyIsDown,secs,keyCode]=KbCheck();
         if any(keyCode(KbName('f')))
            duration = toc*1000;
            if Gun == 'left';
                GunCorrect = 1;
            else
                GunCorrect = 0;
            end
         else if any(keyCode(KbName('j')))
            duration = toc*1000; 
            if Gun == 'right';
                GunCorrect = 1';
            else
                GunCorrect = 0;
            end
     end
end
  
% the f key is key number 70 
% the j key is key number 74 

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
save('DataFiles/structdata.mat','D')
% generate a figure for display 
T = struct2table(D);
uitable('Data',T{:,:},'ColumnName',T.Properties.VariableNames,...
    'RowName',T.Properties.RowNames,'Units', 'Normalized', 'Position',[0, 0, 1, 1]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
