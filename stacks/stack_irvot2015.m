function experiments = stack_irvot2015()

set_global_variable('bundle', 'https://liu.box.com/shared/static/4yczc0pb5uwjvvm54zfh601aj5vdz7q7.zip');

baseline.name = 'baseline';
baseline.converter = [];
baseline.execution = 'default';
baseline.labels = {'camera_motion', 'illum_change', 'occlusion', 'size','motion', 'empty'};
               
baseline.parameters.repetitions = 15;
baseline.parameters.burnin = 10;
baseline.parameters.skip_initialize = 5;
baseline.parameters.failure_overlap = 0;

region_noise.name = 'region_noise';
region_noise.converter = @(sequence) sequence_transform_initialization(...
    sequence, @noisy_transform, 'rectangle');
region_noise.execution = 'default';
region_noise.labels = {'camera_motion', 'illum_change', 'occlusion', 'size', 'motion', 'empty'};
region_noise.parameters.repetitions = 15;
region_noise.parameters.burnin = 10;
region_noise.parameters.skip_initialize = 5;
region_noise.parameters.failure_overlap = 0;

experiments = {baseline, region_noise};

end

function [transform] = noisy_transform(sequence, index, context)

    bounds = region_convert(get_region(sequence, index), 'rectangle');

    scale = 0.9 + rand(1, 2) * 0.2;
    move = bounds(3:4) .* (0.1 - rand(1, 2) * 0.2);

    transform = [scale(1), 0, move(1); 0, scale(2), move(2); 0, 0, 1];

end
