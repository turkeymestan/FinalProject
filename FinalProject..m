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

% the “f” key is key number 70 
% the “j” key is key number 74 
Armed = dir('./ExperimentPhotos/Armed/*.jpg'); 

Unarmed = dir('./ExperimentPhotos/Unarmed/*.jpg');  

centerX = screenRect(3)/2; % center ‘X’ coordinate 

centerY = screenRect(4)/2; % center ‘Y’ coordinate 

displayWidth = 400;
displayHeight = 400;

destinationRect1 = CenterRectOnPoint([0 0 displayWidth displayHeight], centerX-500, centerY);

destinationRect2 = CenterRectOnPoint([0 0 displayWidth displayHeight], centerX+500, centerY);

textColor = [0 150 50];

InstructTrial = 'A cue will first appear. You will then see two images appear. Press the <F> key if the cue points to a weapon. Press the <J> key if the cue does not point towards a weapon. Press any key to continue.'; 
Screen('TextSize', onScreen ,[50]);
DrawFormattedText(onScreen, InstructTrial,[centerX-400],[centerY],[textColor]);
Screen('Flip', onScreen);

[keyIsDown,secs,keyCode]=KbCheck(); % wait for a keypress

while ~any(keyCode(KbName('space')))
    [keyIsDown,secs,keyCode]=KbCheck();
    if any(keyCode(KbName('space')))
        Screen('CloseAll');
    end 
 end 




%% D struct variables 
D.time =
D.subID =
D.race = 
D.correct = 
D.trialNumber = 

%% load images (4 folders: blackArmed, whiteArmed, blackUnarmed, whiteUnarmed) 
% basically going to be using Lab 7 exercise 1B, but this time have two different parameters for imList? (how do you get it to draw from two different folders simultaneously?)

%% Set up directories/matrix for folders
BW = dir(fullfile(BlackArmed,'/*.jpg')); % folder 1 black & gun
BNW = dir(fullfile(BlackUnarmed,'/*.jpg')); % folder 2 black & no gun
WW = dir(fullfile(WhiteArmed,'/*.jpg')); % folder 3 white & gun
WNW = dir(fullfile(WhiteUnarmed,'/*.jpg')); % folder 4 white & no gun

% Create matrix for folders
Folder = {'BW'; 'BNW'; 'WW'; 'WNW'};

%% Create matrix for images
Image = 1:length(NumImages); %NumImages = number of images in each folder (must be the same for all folders)

%%%%% is this needed? %%%%%%%
DrawFormattedText(onScreen, instructTrial, [centerX],[centerY],[40 115 80]); 
Screen('Flip', onScreen); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pause (2);


%%%% NOTES%%%%%
% generate a random number between 1 and the number of images
RandomNumber = randi([1 size(MyImages,1)]);
% get the corresponding name of the image 
RandomImage = MyImages(RandomNumber).name;
% display the image
image(imread(RandomImage));

imName = fullfile('ImageFiles', imLT(x).name);
im = imread(''); %read image
%%%% END OF NOTES %%%%

%% run trials 
for i=1: NumTrials 
% randomize the matrix "Folder"
loopOrderFolder = randperm(length(Folder));
% randomize the matrix "Image"
loopOrderImage = randperm(length(Image));

    for j=1:NumTrials
        % Set directory for proper folder
        DirectoryLeft = Folder(loopOrderFolder(1));
        % Randomly select image from folder (loopOrderFolder(1))
        
        % Make texture
        textureLeft = 
        %draw texture loopOrderImage(1) to left side of screen
        Screen(‘DrawTexture’, onScreen, loopOrderImage(1), [,sourceRect] [,destinationRect]);
    end
    
    for k=1:NumTrials
        if loopOrderFolder(1) = 1
            DirectoryRight = Folder(4);  % can also put WNW
            % Make texture
            textureRight =
            % then draw texture (loopOrderImage(2)) from folder 4 to right side of screen
            Screen(‘DrawTexture’, onScreen, texture, [,sourceRect] [,destinationRect]);
        if loopOrderFolder(1) = 2
            DirectoryRight = Folder(3); % can also put WW
            % Make texture
            textureRight =
            % then draw texture (loopOrderImage(2)) from folder 3 to right side of screen
            Screen(‘DrawTexture’, onScreen, texture, [,sourceRect] [,destinationRect]);
        if loopOrderFolder(1) = 3
            DirectoryRight = Folder(2); % can also put BNW
            % Make texture
            textureRight =
            % then draw texture (loopOrderImage(2)) from folder 2 to right side of screen
            Screen(‘DrawTexture’, onScreen, texture, [,sourceRect] [,destinationRect]);
        if loopOrderFolder(1) = 4
            DirectoryRight = Folder(1); % can also put BW
            % Make texture
            textureRight = 
            % then draw texture (loopOrderImage(2)) from folder 1 to right side of screen
            Screen(‘DrawTexture’, onScreen, texture, [,sourceRect] [,destinationRect]);
        end
    end
    
  % establish a method for determining whether the weapon was on the left or right
  
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
