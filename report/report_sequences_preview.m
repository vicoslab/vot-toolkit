function [document] = report_sequences_preview(context, sequences, varargin)
% report_sequences_preview Create an overview document for the given sequences
%
% The function generates a report document for the given sequences by providing a
% preview of each sequence.
%
% Input:
% - context (structure): A report context structure.
% - sequences (cell): An array of sequence descriptors.
% - varargin[Frames] (integer): Number of frames for each sequence to present in a strip.
%
% Output:
% - document (structure): A document structure.
%

document = create_document(context, 'sequences', 'title', 'Sequences preview');

frames = 6;

for i = 1:2:length(varargin)
    switch lower(varargin{i}) 
        case 'frames'
            frames = varargin{i+1};
        otherwise 
            error(['Unknown switch ', varargin{i}, '!']) ;
    end
end 


for s = 1:length(sequences)

    print_indent(1);

    print_text('Processing sequence %s ...', sequences{s}.name);

    document.raw('<div class="timeline">\n');
    
    figure_id = sprintf('sequence_preview_%s', sequences{s}.name);
    
    document.figure(@() generate_sequence_strip(sequences{s}, {}, 'samples', frames, 'window', Inf), ...
        figure_id, sprintf('Sequence %s', sequences{s}.name));

    document.raw('</div>\n');
    
    print_indent(-1);

end;

document.write();



