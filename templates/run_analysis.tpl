% This script can be used to perform a comparative analyis of the experiments
% in the same manner as for the VOT2013 challenge
% You can copy and modify it to create a different analyis

[sequences, experiments] = vot_environment();

trackers = create_trackers('{{tracker}}'); % TODO: add more trackers here

% If you are performing analysis on a dataset that does not have per-frame
% labels, use "labels = [];" here!
labels = {'camera_motion', 'illum_change', 'occlusion', 'size_change', ...
    'motion_change', 'empty'};

context = create_report_context('report_{{tracker}}'); % TODO: name of the report

% Perform ranking analysis
ranking_index = ranking_analysis(context, trackers, sequences, ...
        experiments, 'labels', labels, 'permutationplot', 1, 'arplot', 1);

% Perform standard A-R plot analysis
ar_index = ar_analysis(context, trackers, sequences, experiments);

documents = {ranking_index, 'Tracker ranking', 'The official ranking analysis'; ...
    ar_index, 'A-R plots', 'Results visualized as A-R plots'};

generate_index(context, documents);

