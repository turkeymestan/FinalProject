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

centerX = screenRect(3)/2; % center ‘X’ coordinate 

centerY = screenRect(4)/2; % center ‘Y’ coordinate 
% setting subject ID
% resource for someone else doing subject ID https://www.mathworks.com/matlabcentral/answers/325830-save-matrix-with-unique-subject-id-to-new-file
sid = input('Enter your ID number:', 's') % not sure how this works, just saw it in the group me. 
save(sid,'ID')

destinationRect1 = CenterRectOnPoint([0 0 displayWidth displayHeight], centerX-500, centerY);

destinationRect2 = CenterRectOnPoint([0 0 displayWidth displayHeight], centerX+500, centerY);

textColor = [255 0 0];

%% D struct variables 
D.time =
D.subID =
D.race = 
D.correct = 
D.trialNumber = 

%% Set up directories/matrix for folders

% Create directories for folders
BW = dir(./ExperimentFiles/BlackArmed/*.jpg')); % folder 1 black & gun
BNW = dir(./ExperimentFiles/BlackUnarmed/*.jpg')); % folder 2 black & no gun
WW = dir(./ExperimentFiles/WhiteArmed/*.jpg')); % folder 3 white & gun
WNW = dir(./ExperimentFiles/WhiteUnarmed/*.jpg')); % folder 4 white & no gun

% Create matrix for folders
Folder = {'BW'; 'BNW'; 'WW'; 'WNW'};

%% Create matrix for images
Image = 1:length(NumImages); %NumImages = number of images in each folder (must be the same for all folders)

%% Present instructions and wait for key press
InstructTrial = ‘A cue will first appear. You will then see two images appear. Press the <F> key if the cue points to a weapon. Press the <J> key if the cue does not point towards a weapon.
Press any key to continue.’; 
Screen('TextSize', onScreen ,[50]);
DrawFormattedText(onScreen, InstructTrial,[centerX],[centerY],[textColor]);
Screen('Flip', onScreen);

while ~KbCheck() end % wait for a keypress

%% Pause
pause (2);

%% Run trials 
for i=1: NumTrials 
% randomize the matrix "Folder"
loopOrderFolder = randperm(length(Folder));
% randomize the matrix "Image"
loopOrderImage = randperm(length(WhiteUnarmed.name)); 

    % Left Image 
    for j=1:NumTrials
        % Randomly select image from folder (loopOrderFolder(1))
        RandomNumberLeft = randi([1:length(Folder),1)]);
        FolderLeft = Folder(loopOrderFolder(1));
        RandomImageLeft = FolderLeft(RandomNumberLeft).name;
        % Make texture
        textureLeft = Screen(‘MakeTexture’, onScreen, RandomImageLeft);
        %draw texture loopOrderImage(1) to left side of screen
        Screen(‘DrawTexture’, onScreen, loopOrderImage(1), destinationRect1);
    end
    
    % Right Image
    for k=1:NumTrials
        RandomNumberRight = randi([1:length(loopOrderFolder),1)]);
        FolderRight = Folder(loopOrderFolder(1));
        RandomImageRight = FolderRight(RandomNumberRight).name;
        if loopOrderFolder(1) = 1
            DirectoryRight = Folder(4);  % can also put WNW
            % Make texture
            textureRight =Screen(‘MakeTexture’, onScreen, Image(loopOrderImage(2)));
            % then draw texture (loopOrderImage(2)) from folder 4 to right side of screen
            Screen(‘DrawTexture’, onScreen, texture, destinationRect2);
        if loopOrderFolder(1) = 2
            DirectoryRight = Folder(3); % can also put WW
            % Make texture
            textureRight =Screen(‘MakeTexture’, onScreen, Image(loopOrderImage(2)));
            % then draw texture (loopOrderImage(2)) from folder 3 to right side of screen
            Screen(‘DrawTexture’, onScreen, texture, destinationRect2);
        if loopOrderFolder(1) = 3
            DirectoryRight = Folder(2); % can also put BNW
            % Make texture
            textureRight =Screen(‘MakeTexture’, onScreen, Image(loopOrderImage(2)));
            % then draw texture (loopOrderImage(2)) from folder 2 to right side of screen
            Screen(‘DrawTexture’, onScreen, texture, destinationRect2);
        if loopOrderFolder(1) = 4
            DirectoryRight = Folder(1); % can also put BW
            % Make texture
            textureRight =Screen(‘MakeTexture’, onScreen, Image(loopOrderImage(2)));
            % then draw texture (loopOrderImage(2)) from folder 1 to right side of screen
            Screen(‘DrawTexture’, onScreen, texture, destinationRect2);
        end
    end
    
  % establish a method for determining whether the weapon was on the left or right
  
% the “f” key is key number 70 
% the “j” key is key number 74 
  
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
