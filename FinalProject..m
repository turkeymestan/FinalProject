%% Goal of Script

%% Clear all
clear all; 
clc; 

%% Open the main screen 
Screen('Preference','ConserveVRAM',64); 
Screen('Preference', 'SkipSyncTests', 1); 
[onScreen, screenRect] = Screen('OpenWindow',0);    % opens the mainscreen 
Screen('FillRect', onScreen, [255 255 255]);        % paints screen black (on the offscreen buffer) 

%% Define Variables 

NumTrials = 50; % number of trials  

dir('ExperimentPhotos/*.jpg'); % sets current directory to ExperimentFiles folder, where there will be two other folders (1) Armed Files (2) Unarmed Files  

% the f key is key number 70 
% the j key is key number 74 

centerX = screenRect(3)/2; % center X coordinate 
centerY = screenRect(4)/2; % center Y coordinate 

destinationRect1 = CenterRectOnPoint([0 0 displayWidth displayHeight], centerX-500, centerY);
destinationRect2 = CenterRectOnPoint([0 0 displayWidth displayHeight], centerX+500, centerY);

textColor = [255 0 0];

fID = fopen('ExperimentResults.txt', 'w'); % creates new text file titled ExperimentResults
% to write to ExperimentResults = fprint(fID, '%s\t%s\t%d\n')
D.time =
D.race = 
D.correct = 
D.trialNumber = 

%% Set up directories/matrix for folders

% Create directories for folders
a = dir(fullfile('BlackArmed')); % folder 1 black & gun
b = dir(fullfile('BlackUnarmed')); % folder 2 black & no gun
c = dir(fullfile('WhiteArmed')); % folder 3 white & gun
d = dir(fullfile('WhiteUnarmed')); % folder 4 white & no gun

%% Record subject ID
IDstring = 'Please enter your first and last name into the dialog box.  \n Press space to exit this screen.';
Screen('TextSize', onScreen, [50]);
DrawFormattedText(onScreen, IDstring, [centerX-550], [centerY], [textColor]);
Screen('Flip', onScreen); 

[keyIsDown,secs,keyCode]=KbCheck(); 
 
while ~any(keyCode(KbName('space')))
    [keyIsDown,secs,keyCode]=KbCheck();
    if any(keyCode(KbName('space')))
         Screen('CloseAll');  
    end  
end % wait for a keypress

prompt = {'Enter first name:','Enter last name:'}; % these lines create a dialog box for subject ID input.
dlgtitle = 'Subject ID';
dims = [1 35];
definput = {'First', 'Last'};
answer = inputdlg(prompt,dlgtitle,dims,definput);

D.subID = answer; 
save('ExperimentResults.txt','D.subID');
T = struct2table(D)

[onScreen, screenRect] = Screen('OpenWindow',0);    % opens the mainscreen 
Screen('FillRect', onScreen, [255 255 255]); 

%% Present instructions and wait for key press
InstructTrial = A cue will first appear. You will then see two images appear. Press the <F> key if the cue points to a weapon. Press the <J> key if the cue does not point towards a weapon. Press any key to continue.; 
Screen('TextSize', onScreen ,[50]);
DrawFormattedText(onScreen, InstructTrial,[centerX-450],[centerY],[textColor]);
Screen('Flip', onScreen);

[keyIsDown,secs,keyCode]=KbCheck(); 
 
while ~any(keyCode(KbName('space')))
    [keyIsDown,secs,keyCode]=KbCheck();
    if any(keyCode(KbName('space')))
         Screen('CloseAll');  
    end  
end 

%% Pause
pause (2);

%% Run trials 
% see displayRSVP_record from lab 4 for writing to data file in data set.
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
       else if loopOrderFolder(1)==2;
         imageLeft = imread(b(RandomNumberLeft).name);
         imageRight = imread(c(RandomNumberRight).name);
         % Make texture
         textureLeft=Screen('MakeTexture', onScreen, imageLeft);
         textureRight=Screen('MakeTexture', onScreen, imageRight);
       else if loopOrderFolder(1)==3;
         imageLeft = imread(c(RandomNumberLeft).name);
         imageRight = imread(b(RandomNumberRight).name);
         % Make texture
         textureLeft=Screen('MakeTexture', onScreen, imageLeft);
         textureRight=Screen('MakeTexture', onScreen, imageRight);
           else
        imageLeft = imread(d(RandomNumberLeft).name);
        imageRight = imread(a(RandomNumberRight).name);
        % Make texture
        textureLeft=Screen('MakeTexture', onScreen, imageLeft);
        textureRight=Screen('MakeTexture', onScreen, imageRight);
           end
           end
    end
%draw textures to left and right sides of screen
Screen('DrawTexture', onScreen, textureLeft, destinationRect1)
Screen('DrawTexture', onScreen, textureRight, destinationRect2)
end
  % establish a method for determining whether the weapon was on the left or right
  
% the f key is key number 70 
% the j key is key number 74 
  
  % wait for a response (keyboard input) 
  [keyIsDown,keyTime,keyCode] = KbCheck; 
  if keyIsDown==1;
    whichKeys = find(keyCode==1);
    if keycode == 70 &  % label for weapon is left
        % save correct to struct
    if keycode == 70 &  % label for weapon is right
        % save incorrect to struct
    if keycode == 74 &  % label for weapon is right
        % save correct to struct
    if keycode == 74 &  % label for weapon is left
        % save incorrect to struct
    end
  end
  
end 

% Pause 1 second
pause (1)

% close main screen 
Screen('CloseAll'); 

% save your D struct in a .mat file in the DataFiles folder  
% generate a figure for display 
