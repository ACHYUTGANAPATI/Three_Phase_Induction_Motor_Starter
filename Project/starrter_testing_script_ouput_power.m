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
desired_times = 0:0.6423:max(speed_time); % Use speed_time or max(time)
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

efficiency_overall = (fv_output_power./fv_input_power).*100;
efficiency_starter = (fv_starter_output_power./fv_input_power).*100;
power_loss_overall = abs(fv_output_power -fv_input_power);
power_loss_starter = abs(fv_starter_output_power - fv_input_power);

slip = ((1500-fv_speed)./1500)*100;
% Plotting Output Power vs Other Variables in Separate Figures



figure;
plot(fv_output_power, efficiency_overall, 'r-');
title('Output Power vs Speed');
xlabel('Output Power (W)');
ylabel('Efficienency');

% Plot Output Power vs Speed
figure;
plot(fv_output_power, fv_speed, 'r-');
title('Output Power vs Speed');
xlabel('Output Power (W)');
ylabel('Speed (RPM)');

% Plot Output Power vs Input Power Factor
figure;
plot(fv_output_power, fv_input_power_factor, 'g-');
title('Output Power vs Input Power Factor');
xlabel('Output Power (W)');
ylabel('Input Power Factor');

% Plot Output Power vs Starter Power Factor
figure;
plot(f_output_power, fv_starter_power_factor, 'm-');
title('Output Power vs Starter Power Factor');
xlabel('Output Power (W)');
ylabel('Starter Power Factor');

% Plot Output Power vs Input Power
figure;
plot(fv_output_power, fv_input_power, 'c-');
title('Output Power vs Input Power');
xlabel('Output Power (W)');
ylabel('Input Power (W)');

% Plot Output Power vs Starter Output Power
figure;
plot(fv_output_power, fv_starter_output_power, 'k-');
title('Output Power vs Starter Output Power');
xlabel('Output Power (W)');
ylabel('Starter Output Power (W)');

% Plot Output Power vs Mechanical Torque
figure;
plot(fv_output_power, fv_mechanical_torque, 'b-');
title('Output Power vs Mechanical Torque');
xlabel('Output Power (W)');
ylabel('Mechanical Torque (Nm)');

% Plot Output Power vs Mechanical Output Power
figure;
plot(fv_output_power, fv_mechanical_output_power, 'r-');
title('Output Power vs Mechanical Output Power');
xlabel('Output Power (W)');
ylabel('Mechanical Output Power (W)');
