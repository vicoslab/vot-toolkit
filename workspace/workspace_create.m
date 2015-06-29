function workspace_create(varargin)
% workspace_create Initialize a new VOT workspace
%
% This function serves as a guided initialization of a workspace. It generates
% all the basic scripts to run your tracker on an experiment stack based on a 
% series of questions.
%
% Input:
% - varargin[Tracker] (boolean, string): Generate a new tracker, if boolean, the 
%   identifier of a tracker will be obtained interactively.
% - varargin[Stack] (string): Select a stack as an input.
%

tracker = [];
stack = [];

for j=1:2:length(varargin)
    switch lower(varargin{j})
        case 'tracker', tracker = varargin{j+1};
        case 'stack', stack = varargin{j+1};
        otherwise, error(['unrecognized argument ' varargin{j}]);
    end
end

script_directory = fileparts(mfilename('fullpath'));

set_global_variable('toolkit_path', fileparts(script_direcory));
set_global_variable('indent', 0);
set_global_variable('directory', pwd());

stacks = {};

files = dir(fullfile(script_directory, 'stacks'));

for i = 1:length(files)
    if ~files(i).isdir && strncmp(files(i).name, 'stack_', 6)
        stacks{end+1} = files(i).name(7:end-2);
    end;
end

directory = pwd();

% Check if the directory is already a valid VOT workspace ...

configuration_file = fullfile(directory, 'configuration.m');

if exist(configuration_file, 'file')
    error('Directory is probably already a VOT workspace.');
end;

% Copy configuration templates ...

templates_directory = fullfile(script_directory, 'templates');

version = toolkit_version();

if isempty(stack)

    print_text('Select one of the available experiment stacks:');

    for i = 1:length(stacks)
        print_text(' %d - %s', i, stacks{i});
    end;

    option = input('Selection: ', 's');
    option = int32(str2double(option));

    if isempty(option) || option < 1 || option > length(stacks)
        error('Not a valid stack!');
    end;

    selected_stack = stacks{option};

else

    for i = 1:length(stacks)
        if strcmp(stacks{i}, stack)
            selected_stack = stacks{i};
            break;
        end;
    end;

    if isempty(selected_stack)
        error('Not a valid stack!');
    end;

end

variables = {'version', num2str(version.major), ...
    'tracker', tracker_identifier, 'stack', selected_stack, ...
    'toolkit', get_global_variable('toolkit_path')};

generate_from_template(fullfile(directory, 'configuration.m'), ...
    fullfile(templates_directory, 'configuration.tpl'), variables{:});

generate_from_template(fullfile(directory, 'run_experiments.m'), ...
    fullfile(templates_directory, 'run_experiments.tpl'), variables{:});

generate_from_template(fullfile(directory, 'run_test.m'), ...
    fullfile(templates_directory, 'run_test.tpl'), variables{:});

generate_from_template(fullfile(directory, 'run_pack.m'), ...
    fullfile(templates_directory, 'run_pack.tpl'), variables{:});

generate_from_template(fullfile(directory, 'run_browse.m'), ...
    fullfile(templates_directory, 'run_browse.tpl'), variables{:});

generate_from_template(fullfile(directory, 'run_analysis.m'), ...
    fullfile(templates_directory, 'run_analysis.tpl'), variables{:});

if islogical(tracker)

    tracker_identifier = input('Input an unique identifier for your tracker: ', 's');

    if ~valid_identifier(tracker_identifier)
        error('Not a valid tracker identifier!');
    end;

    if tracker
        
    end

elseif ~isempty(tracker)



end

%generate_from_template(fullfile(directory, ['tracker_', tracker_identifier, '.m']), ...
%    fullfile(templates, 'tracker.tpl'), variables{:});

% Print further instructions ...

print_text('');
print_text('***************************************************************************');
print_text('');
print_text('The VOT workspace has been configured');
print_text('Please edit the tracker_%s.m file to configure your tracker.', tracker_identifier);
print_text('Then run run_test.m script to make sure that the tracker is working.');
print_text('To run the experiments execute the run_experiments.m script.');
print_text('');
print_text('***************************************************************************');
print_text('');
