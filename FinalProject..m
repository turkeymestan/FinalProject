clear all; 
clc; 

%% Open the main screen 

Screen('Preference','ConserveVRAM',64); 
Screen('Preference', 'SkipSyncTests', 1); 
[onScreen, screenRect] = Screen('OpenWindow',0);    % opens the mainscreen 
Screen('FillRect', onScreen, [255 255 255]);        % paints screen black (on the offscreen buffer) 

%% Define Variables 
centerX = screenRect(3)/2; % center ‘X’ coordinate 

centerY = screenRect(4)/2; % center ‘Y’ coordinate 

NumTrials = 50; % number of trials  

dir(‘ExperimentFiles/*.jpg’); % sets current directory to ExperimentFiles folder, where there will be two other folders (1) Armed Files (2) Unarmed Files 

InstructTrial = ‘You will see two images appear. Press the F key if the cue points to a weapon. Press the J key if the cue does not point towards a weapon.’;  
% the “f” key is key number 70 
% the “j” key is key number 74 
blackArmed = dir(‘./ExperimentFiles/blackArmed/*.jpg’); 
whiteArmed = dir(‘./ExperimentFiles/whiteArmed/*.jpg’);  
blackUnarmed = dir(‘./ExperimentFiles/blackUnarmed/*.jpg’);  
whiteUnarmed = dir(‘./ExperimentFiles/whiteUnarmed/*.jpg’); 

%% D struct variables 
D.time =
D.subID =
D.race = 
D.correct = 
D.trialNumber = 

% load images (4 folders: blackArmed, whiteArmed, blackUnarmed, whiteUnarmed) 
imListWeapon = dir(’WeaponImages/*.jpg’); 
imListNoWeapon = dir(’NoWeaponImages/*.jpg’); 
imName = fullfile('ImageFiles', imLT(x).name);
im = imread(''); %read image

% counterbalance conditions and randomize trial order 
% Text string telling subjects instructions  

DrawFormattedText(onScreen, instructTrial, [centerX],[centerY],[40 115 80]); 
Screen('Flip', onScreen); 
pause (2); 
% store text string in D struct 
% clear text string

pause (2)

% run trials 
for i=1: NumTrials 
  % show current images (one with gun, one without) 
  imagesc(im);
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
