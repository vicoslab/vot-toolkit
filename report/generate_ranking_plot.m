function hf = generate_ranking_plot(trackers, accuracy, robustness, plot_title, plot_limit, varargin)

additional_data = {};
display_numbers = 0;

for i = 1:2:length(varargin)
    switch lower(varargin{i})        
        case 'additionaltrackers'
            additional_data = varargin{i+1};  
        case 'displaynumbers'
            display_numbers = varargin{i+1}; 
        otherwise
            error(['Unknown switch ', varargin{i},'!']) ;
    end
end 

    hf = figure('Visible', 'off');

    hold on; box on; grid on;
    title(plot_title, 'interpreter','none');

    available = true(length(trackers), 1);

    
    % Plot regular trackers
    for t = 1:length(trackers)
        if isnan(accuracy(t))
            available(t) = 0;
            continue;
        end;

        plot(robustness(t), accuracy(t), trackers{t}.style.symbol, 'Color', ...
            trackers{t}.style.color, 'MarkerSize',10,  'LineWidth', trackers{t}.style.width);
    end;
    plot_labels = cellfun(@(tracker) tracker.label, trackers, 'UniformOutput', 0);
    
    
    % Plot additional trackers
    if ~isempty(additional_data)
        a_trackers = additional_data{1};
        a_accuracy = additional_data{2};
        a_robustness = additional_data{3};
        
        a_available = true(length(a_trackers), 1);
        
        for t = 1:length(a_trackers)
            if isnan(a_accuracy(t))
                a_available(t) = 0;
                continue;
            end;

            plot(a_robustness(t), a_accuracy(t), a_trackers{t}.style.symbol, 'Color', ...
                a_trackers{t}.style.color, 'MarkerSize',10,  'LineWidth', a_trackers{t}.style.width);
        end;
        a_plot_labels = cellfun(@(tracker) tracker.label, a_trackers, 'UniformOutput', 0);
        plot_labels = cat(1, plot_labels, a_plot_labels);
        available = cat(1, available, a_available);
    end    
    
    % Label trackers with numbers
    if display_numbers
        for t = 1:length(trackers)    
            if isnan(accuracy(t))                
                continue;
            end;
            text(robustness(t) - 0.75, accuracy(t),...
                ['\bf' num2str(t)], ...
                'VerticalAlignment','bottom',...
                'HorizontalAlignment','center',...
                'FontSize',7);

            plot_labels{t} = sprintf('%d - %s', t, trackers{t}.label);
        end
        
        if ~isempty(additional_data)
            for t = 1:length(a_trackers)    
                if isnan(a_accuracy(t))                
                    continue;
                end;
                tracker_number = t + sum(available) - sum(a_available);
                text(a_robustness(t) - 0.75, a_accuracy(t),...
                    ['\bf' num2str(tracker_number)], ...
                    'VerticalAlignment','bottom',...
                    'HorizontalAlignment','center',...
                    'FontSize',7);

                plot_labels{tracker_number} = sprintf('%d - %s', tracker_number, a_trackers{t}.label);
            end
        end
    end
    
    hLegend = legend(plot_labels(available), 'Location', 'NorthWestOutside', 'interpreter', 'none', 'FontSize', 9); 
    
    if ~isempty(additional_data)
        set(hLegend,'FontSize',8);
        hKids = get(hLegend,'Children');
        hText = hKids(strcmp(get(hKids,'Type'),'text'));
        
        black = repmat('k', length(trackers), 1);
        red = repmat('r', length(a_trackers), 1);
        colors = num2cell(cat(1, red, black));
        
        set(hText,{'Color'},colors);
    end
    
    xlabel('Robustness rank'); set(gca,'XDir','Reverse');
    ylabel('Accuracy rank'); set(gca,'YDir','Reverse');
    xlim([1, plot_limit]); 
    ylim([1, plot_limit]);
    hold off;
