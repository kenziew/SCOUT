function SelectedColour = uicolorpick3(varargin)

% Create a figure window, 160x215...
SysCol = get(0,'DefaultUicontrolBackgroundColor');
DkSys = SysCol * 0.6; DkSys(DkSys < 0) = 0;
LtSys = SysCol / 1.1; LtSys(LtSys > 1) = 1;

% Set Startup position...
if nargin == 1
    position = varargin{1};
else
    SSize = get(0,'ScreenSize');
    Centre = SSize(3:4)/2;
    position = [Centre(1)-80 Centre(2)-107];
end

% Draw Dialog...
hFig = figure('position',[position(1) position(2) 280 190],...
    'Name','Color',...
    'NumberTitle','off',...
    'Menubar','none',...
    'Color',SysCol,...
    'Visible','on',... 
    'Resize','off');
    
% find out what directory this function is in...
[pathstr] = fileparts(which(mfilename));

% Then load the palette...
Loaded = load([pathstr '\Palette_3.col'],'-mat');
Palette = Loaded.Palette;
RGBColours = Palette.Colours;
Names = Palette.ColourNames;
% You could modify Palette.col to show different colours.
% use "load palette.col -mat" in workspace


CLR = 0;

Labels(1,:) = {'Col11','Col21','Col31','Col41'};
Labels(2,:) = {'Col12','Col22','Col32','Col42'};
Labels(3,:) = {'Col13','Col23','Col33','Col43'};
Labels(4,:) = {'Col14','Col24','Col34','Col44'};
Labels(5,:) = {'Col13','Col23','Col33','Col43'};
Labels(6,:) = {'Col14','Col24','Col34','Col44'};

CtrlTags(1,:) = {'FrmCol11','FrmCol21','FrmCol31','FrmCol41','FrmCol51','FrmCol61'};
CtrlTags(2,:) = {'FrmCol12','FrmCol22','FrmCol32','FrmCol42','FrmCol52','FrmCol62'};
CtrlTags(3,:) = {'FrmCol13','FrmCol23','FrmCol33','FrmCol43','FrmCol53','FrmCol63'};
CtrlTags(4,:) = {'FrmCol14','FrmCol24','FrmCol34','FrmCol44','FrmCol54','FrmCol64'};
CtrlTags(5,:) = {'FrmCol15','FrmCol25','FrmCol35','FrmCol45','FrmCol55','FrmCol65'};
CtrlTags(6,:) = {'FrmCol16','FrmCol26','FrmCol36','FrmCol46','FrmCol56','FrmCol66'};
CtrlTags(7,:) = {'FrmCol17','FrmCol27','FrmCol37','FrmCol47','FrmCol57','FrmCol67'};
CtrlTags(8,:) = {'FrmCol18','FrmCol28','FrmCol38','FrmCol48','FrmCol58','FrmCol68'};
CtrlTags(9,:) = {'FrmCol19','FrmCol29','FrmCol39','FrmCol49','FrmCol59','FrmCol69'};

for i = 1:6 % For each row in the grid...   
    for ctrl = 1:9 
        CLR = CLR + 1;            
        myColour = RGBColours(CLR,:);
        
        switch ctrl 
            case 1
                x = 10;
            case 2
                x = 35;
            case 3
                x = 60;
            case 4
                x = 105;
            case 5
                x = 130;
            case 6
                x = 155;
            case 7
                x = 200;
            case 8
                x = 224;
            case 9
                x = 248;
        end
        
        switch i 
            case 1
                y = 6;
            case 2
                y = 36;
            case 3
                y = 66;
            case 4
                y = 96;
            case 5
                y = 126;
            case 6
                y = 156;
        end
        
        CtrlP = [x, y, 25, 25];
        
        uicontrol('style','frame',...
                  'position',CtrlP,...
                  'BackgroundColor',myColour,...
                  'ForegroundColor',DkSys,...
                  'enable','inactive',...
                  'TooltipString',Names{CLR},...
                  'ButtonDownFcn',@SelectColour);
    end 
end


      
set(hFig,'visible','on');

% Wait for the user to respond to the dialog...
try 
    uiwait(hFig)
catch
    delete (hFig)
end

% This will fail if the user closes the dialog using the 'close' button.
% When this happens, the returned value is empty.
try
    SelectedColour = get(hFig,'UserData');
    delete(hFig)
catch
    SelectedColour = [];
end

% -----------------------------------------------------------
function SelectColour(hObj,EventData)

% Get the Selected Colour...
SelectedColour = get(hObj,'BackgroundColor');

% Get the Handle to the figure...
hFig = get(hObj,'Parent');

pos_color1 = hObj.Position;

% get colors on either side of the one selected 
x = [10, 35, 60, 105, 130, 155, 200, 224, 248];
y = [6, 36, 66, 96, 126, 156];

x_ind = find(x == pos_color1(1));
y_ind = find(y == pos_color1(2));
[pathstr] = fileparts(which(mfilename));
Loaded = load([pathstr '\Palette_3.col'],'-mat');
Palette = Loaded.Palette;
RGBColours = Palette.Colours;
Names = Palette.ColourNames;

% if click the middle of each row, find color on either side
if x_ind == 2 || x_ind == 5 || x_ind == 8
%     pos_color2 = x_ind + 1;
%     color2 = x(pos_color2);
%     pos_color3 = x_ind - 1;
%     color3 = x(pos_color3);
    
    color2_index =  ((y_ind - 1)*9)+ (x_ind + 1);
    color3_index =  ((y_ind - 1)*9)+ (x_ind - 1);
elseif x_ind == 1 || x_ind == 4 || x_ind == 7
    color2_index =  ((y_ind - 1)*9)+ (x_ind + 1);
    color3_index =  ((y_ind - 1)*9)+ (x_ind + 2);
    
%     pos_color2 = x_ind + 1;
%     color2 = x(pos_color2);
%     pos_color3 = x_ind + 2;
%     color3 = x(pos_color3);
elseif x_ind == 3 || x_ind == 6 || x_ind == 9
%     pos_color2 = x_ind - 1;
%     color2 = x(pos_color2);
%     pos_color3 = x_ind - 2;
%     color3 = x(pos_color3);
    color2_index =  ((y_ind - 1)*9)+ (x_ind - 1);
    color3_index =  ((y_ind - 1)*9)+ (x_ind - 2);
end

color1_index =  ((y_ind - 1)*9)+ x_ind;
% color2_position =  [color2, y(y_ind), 25 , 25];
% color3_position =  [color3, y(y_ind), 25 , 25];

% find position of child to then index the background color
color1 = Palette.Colours(color1_index,:);
color2 = Palette.Colours(color2_index,:);
color3 = Palette.Colours(color3_index,:);
 
SelectedColours = [{color1},{color2},{color3}];
% Set the UserData to the Selected Colour...
set(hFig,'UserData',SelectedColours);

% Resume Execution of the Code... (suspended by uiwait)
uiresume;

