% Importing Speed
speed = out.logsout{7}.Values;
speed_values = speed.Data;
speed_time = speed.Time;

% Importing Input Power Factor before starter
input_power_factor = out.logsout{3}.Values;
input_power_factor_values = input_power_factor.Data;
input_power_factor_time = input_power_factor.Time;

% Importing Output Power Factor of starter
starter_power_factor = out.logsout{4}.Values;
starter_power_factor_values = starter_power_factor.Data;
starter_power_factor_time = starter_power_factor.Time;

% Importing Input Power
input_power = out.logsout{5}.Values;
input_power_values = input_power.Data;
input_power_time = input_power.Time;

% Importing Starter Output Power
starter_output_power = out.logsout{6}.Values;
starter_output_power_values = starter_output_power.Data;
starter_output_power_time = starter_output_power.Time;

% Importing Mechanical Torque
mechanical_torque = out.logsout{1}.Values;
mechanical_torque_values = mechanical_torque.Data;
mechanical_torque_time = mechanical_torque.Time;

% Importing Overall Output Power
mechanical_output_power = out.logsout{2}.Values;
mechanical_output_power_values = mechanical_output_power.Data;
mechanical_output_power_time = mechanical_output_power.Time;

% Define the desired time intervals
desired_times = 0:0.023:max(speed_time); % Use speed_time or max(time)
fv_speed = zeros(size(desired_times));
fv_input_power_factor = zeros(size(desired_times));
fv_starter_power_factor = zeros(size(desired_times));
fv_input_power = zeros(size(desired_times));
fv_starter_output_power = zeros(size(desired_times));
fv_mechanical_torque = zeros(size(desired_times));
fv_mechanical_output_power = zeros(size(desired_times));
fv_output_power = zeros(size(desired_times));

for i = 1:length(desired_times)
    % Find the closest index in the logged time
    % Speed
    [~, speed_idx] = min(abs(speed_time - desired_times(i))); 
    fv_speed(i) = speed_values(speed_idx);
    
    % Input Power Factor
    [~, pf_input_idx] = min(abs(input_power_factor_time - desired_times(i))); 
    fv_input_power_factor(i) = input_power_factor_values(pf_input_idx);
    
    % Starter Power Factor
    [~, pf_starter_idx] = min(abs(starter_power_factor_time - desired_times(i))); 
    fv_starter_power_factor(i) = starter_power_factor_values(pf_starter_idx);
    
    % Input Power
    [~, input_power_idx] = min(abs(input_power_time - desired_times(i))); 
    fv_input_power(i) = input_power_values(input_power_idx);
    
    % Starter Output Power
    [~, starter_output_idx] = min(abs(starter_output_power_time - desired_times(i))); 
    fv_starter_output_power(i) = starter_output_power_values(starter_output_idx);
    
    % Mechanical Torque
    [~, torque_idx] = min(abs(mechanical_torque_time - desired_times(i))); 
    fv_mechanical_torque(i) = mechanical_torque_values(torque_idx);
    
    % Mechanical Output Power
    [~, output_power_idx] = min(abs(mechanical_output_power_time - desired_times(i))); 
    fv_mechanical_output_power(i) = mechanical_output_power_values(output_power_idx);
    
    % Overall Output Power
    [~, overall_output_idx] = min(abs(mechanical_output_power_time - desired_times(i)));
    fv_output_power(i) = mechanical_output_power_values(overall_output_idx);
end

power_loss_overall = abs(fv_output_power -fv_input_power);
power_loss_starter = abs(fv_starter_output_power - fv_input_power);
slip = ((1500-fv_speed)./1500)*100;
efficiency = (fv_output_power./fv_input_power).*100;


[maximum_mech_power,timeidx] = max(fv_mechanical_output_power);
fprintf('Maximum Mechanical output Power is: %dW at time %ds\n',maximum_mech_power, desired_times(timeidx));
[minimum_mech_power,timeidx] = min(fv_mechanical_output_power);
fprintf('Minimum Mechanical output Power is: %dW at time %ds\n',minimum_mech_power, desired_times(timeidx));
avg_mech_power = nanmean(fv_mechanical_output_power);
fprintf('Average Mechanical ouput power %dW\n',avg_mech_power);
% Maximum Power Loss
[maximum_power_loss,timeidx] = max(power_loss_overall);
fprintf('Maximum Power Loss is: %dW at time %ds\n', maximum_power_loss, desired_times(timeidx));

% Minimum Power Loss
[minimum_power_loss,timeidx] = min(power_loss_overall);
fprintf('Minimum Power Loss is %dW at time %ds\n',minimum_power_loss,desired_times(timeidx));

% Average Power Loss
average_power_loss = mean(power_loss_overall);
fprintf('Average Power Loss is %dW\n',average_power_loss);


% Average Efficiency
avg_efficiency= nanmean(efficiency);
fprintf('Average Efficiency is %d \n',avg_efficiency);

% maximum torque
[max_torque, timeidx] = max(fv_mechanical_torque);
fprintf('Maximum torque is %d(Nm) at time %ds\n',max_torque,desired_times(timeidx))
% average Torque
[min_torque, timeidx] = min(abs(fv_mechanical_torque));
fprintf('Minimum torque is %d(Nm) at time %ds\n',min_torque,desired_times(timeidx))
avg_torque = mean(fv_mechanical_torque);
fprintf('Average Torque :%d(Nm)\n',avg_torque);
torque_ripple = (max_torque-min_torque)*100/avg_torque;
fprintf('Torque Ripple is :%d(Nm)\n',torque_ripple);

% Maximum Power Factor Achived
[max_pf, timeidx] = max(fv_input_power_factor);
fprintf('Maximum Power factor is %d at time %ds\n',max_pf,desired_times(timeidx));
avg_pf = nanmean(fv_input_power_factor);
fprintf('Average Power Factor :%d\n',avg_pf);
fprintf('Maximum Power factor angle is %d\n',acos(max_pf));
fprintf('Average Power factor angle is %d\n',acos(avg_pf));

figure;
plot(desired_times, power_loss_overall, 'r-',LineWidth=1.5);
title('Power Loass Vs Time');
xlabel('Time (s)');
ylabel('Power Loss');

figure;
plot(desired_times, slip, 'r-',LineWidth=2);
title('% Slip vs Time');
xlabel('Time (s)');
ylabel('%Slip');