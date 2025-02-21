%Constant Load tests
format longG;
input_voltage = out.logsout{11}.Values.Data;
input_voltage_time = out.logsout{11}.Values.Time;

input_current = out.logsout{10}.Values.Data;
input_current_time = out.logsout{10}.Values.Time;

input_power = out.logsout{7}.Values.Data;
input_power_time = out.logsout{7}.Values.Time;

input_power_factor = out.logsout{5}.Values.Data;
input_power_factor_time = out.logsout{5}.Values.Time;

starter_output_voltage = out.logsout{13}.Values.Data;
starter_output_voltage_time = out.logsout{13}.Values.Time;

starter_power = out.logsout{8}.Values.Data;
starter_power_time = out.logsout{8}.Values.Time;

starter_power_factor = out.logsout{6}.Values.Data;
starter_power_factor_time = out.logsout{6}.Values.Time;

rotor_current_a = out.logsout{4}.Values.Data(:, 1);
rotor_current_b = out.logsout{4}.Values.Data(:, 2);
rotor_current_c = out.logsout{4}.Values.Data(:, 3);
rotor_current_time = out.logsout{4}.Values.Time;

speed = out.logsout{9}.Values.Data;
speed_time = out.logsout{9}.Values.Time;

mechanical_output_power = out.logsout{2}.Values.Data;
mechanical_output_power_time = out.logsout{2}.Values.Time;

mechanical_output_torque = out.logsout{1}.Values.Data;
mechanical_output_torque_time = out.logsout{1}.Values.Time;

start_time = input('Enter time(Stater get saturated) = ');
sampling = 1/50;
desired_times = 0:sampling:max(start_time);

desired_time1 = 0:sampling:max(speed_time);

inp_volt = interp1(input_voltage_time, input_voltage, desired_times, 'linear', 'extrap');
inp_curr = interp1(input_current_time, input_current, desired_times, 'linear', 'extrap');
inp_power = interp1(input_power_time, input_power, desired_times, 'linear', 'extrap');
inp_pf = interp1(input_power_factor_time, input_power_factor, desired_times, 'linear', 'extrap');
str_volt = interp1(starter_output_voltage_time, starter_output_voltage, desired_times, 'linear', 'extrap');
str_power = interp1(starter_power_time, starter_power, desired_times, 'linear', 'extrap');
str_pf = interp1(starter_power_factor_time, starter_power_factor, desired_times, 'linear', 'extrap');
mech_power = interp1(mechanical_output_power_time, mechanical_output_power, desired_times, 'linear', 'extrap');
mech_torque = interp1(mechanical_output_torque_time, mechanical_output_torque, desired_times, 'linear', 'extrap');
reotora = interp1(rotor_current_time, rotor_current_a, desired_times, 'linear', 'extrap');
reotorb = interp1(rotor_current_time, rotor_current_b, desired_times, 'linear', 'extrap');
reotorc = interp1(rotor_current_time, rotor_current_c, desired_times, 'linear', 'extrap');
spd = interp1(speed_time, speed, desired_times, 'linear', 'extrap');

inp_volt1 = interp1(input_voltage_time, input_voltage, desired_time1, 'linear', 'extrap');
inp_curr1 = interp1(input_current_time, input_current, desired_time1, 'linear', 'extrap');
inp_power1 = interp1(input_power_time, input_power, desired_time1, 'linear', 'extrap');
inp_pf1 = interp1(input_power_factor_time, input_power_factor, desired_time1, 'linear', 'extrap');
str_volt1 = interp1(starter_output_voltage_time, starter_output_voltage, desired_time1, 'linear', 'extrap');
str_power1 = interp1(starter_power_time, starter_power, desired_time1, 'linear', 'extrap');
str_pf1 = interp1(starter_power_factor_time, starter_power_factor, desired_time1, 'linear', 'extrap');
mech_power1 = interp1(mechanical_output_power_time, mechanical_output_power, desired_time1, 'linear', 'extrap');
mech_torque1 = interp1(mechanical_output_torque_time, mechanical_output_torque, desired_time1, 'linear', 'extrap');
reotora1 = interp1(rotor_current_time, rotor_current_a, desired_time1, 'linear', 'extrap');
reotorb1 = interp1(rotor_current_time, rotor_current_b, desired_time1, 'linear', 'extrap');
reotorc1 = interp1(rotor_current_time, rotor_current_c, desired_time1, 'linear', 'extrap');
spd1 = interp1(speed_time, speed, desired_time1, 'linear', 'extrap');


%Slip Calculation
fprintf("Rated Current is 7.2A\n");
fprintf('Maximum Starting inrush current =%dA\n',max(abs(inp_curr)));
slip = (1500-spd)*100/1500;
fprintf('Maximum slip (at Starting) is %d\n',max(slip));
fprintf('Minimum slip (at Starting) is %d\n',min(abs(slip)));
fprintf('Mean Slip is (at Starting) %d\n',nanmean(slip));
slip1 = (1500-spd1)*100/1500;
fprintf('Maximum slip (Overall) is %d\n',max(slip1));
fprintf('Minimum slip (Overall) is %d\n',min(abs(slip1)));
fprintf('Mean Slip (Overall) is %d\n',nanmean(slip1));
%input Power
fprintf('Maximum Input Power (at Starting) is %dw\n',max(inp_power));
fprintf('Minimum Input Power (at Starting) is %dw\n',min(abs(inp_power)));
fprintf('Average Input Power (at Starting) is %dw\n',nanmean(inp_power));

fprintf('Maximum Input Power (Overall) is %dw\n',max(inp_power1));
fprintf('Minimum Input Power (Overall) is %dw\n',min(abs(inp_power1)));
fprintf('Average Input Power (Overall) is %dw\n',nanmean(inp_power1));

%
fprintf('Maximum Input Power factor is (at Starting) %d\n ',max(inp_pf));
fprintf('Minimum Input Power factor is (at Starting) %d\n',min(inp_pf));
fprintf('Average Input Power factor is (at Starting) %d\n',nanmean(inp_pf));

fprintf('Maximum Input Power factor (Overall) is %d\n',max(inp_pf1));
fprintf('Minimum Input Power factor (Overall) is %d\n',min(inp_pf1));
fprintf('Average Input Power factor (Overall) is %d\n',nanmean(inp_pf1));
%
fprintf('Maximum Starter output Power (at Starting) %dw\n',max(str_power));
fprintf('Minimum Starter output Power (at Starting) %dw\n',min(abs(str_power)));
fprintf('Average Starter output Power (at Starting) %dw\n',nanmean(str_power));

fprintf('Maximum Starter output Power (Overall) %dw\n',max(str_power1));
fprintf('Minimum Starter output Power (Overall) %dw\n',min(abs(str_power1)));
fprintf('Average Starter output Power (Overall) %dw\n',nanmean(str_power1));
%
str_power_loss = abs(inp_power-str_power);
fprintf('Maximum Starter Power Loss is (at Starting) %d\n',max(str_power_loss));
fprintf('Minimum Starter Power Loss is (at Starting) %d\n',min(abs(str_power_loss)));
fprintf('Average Starter Power Loss is (at Starting) %d\n',nanmean(str_power_loss));
str_power_loss1 = abs(inp_power1-str_power1);
fprintf('Maximum Starter Power Loss is (at Overall) %d\n',max(str_power_loss1));
fprintf('Minimum Starter Power Loss is (at Overall) %d\n',min(abs(str_power_loss1)));
fprintf('Average Starter Power Loss is (at Overall) %d\n',nanmean(str_power_loss1));
%
fprintf('Maximum Starter power factor (at Starting) is %d\n',max(str_pf));
fprintf('Minimum Starter power factor (at Starting) is %d\n',min(str_pf));
fprintf('Average Starter power factor (at Starting) is %d\n',nanmean(str_pf));

fprintf('Maximum Starter power factor (at Overall) is %d\n',max(str_pf1));
fprintf('Minimum Starter power factor (at Overall) is %d\n',min(str_pf1));
fprintf('Average Starter power factor (at Overall) is %d\n',nanmean(str_pf1));

% difference in power factor;
diff_pf = abs(inp_pf-str_pf);
fprintf('Maximum difference in power factor (at Starting) is %d\n',max(diff_pf));
fprintf('Minimum difference in power factor (at Starting) is %d\n',min(diff_pf));
fprintf('Average difference in power factor (at Starting) is %d\n',nanmean(diff_pf));

diff_pf1 = abs(inp_pf1-str_pf1);
fprintf('Maximum difference in power factor (at Overall) is %d\n',max(diff_pf1));
fprintf('Minimum difference in power factor (at Overall) is %d\n',min(diff_pf1));
fprintf('Average difference in power factor (at Overall) is %d\n',nanmean(diff_pf1));
%Mechanial Power
fprintf('Maximum Mechanical Power Delivered (at Starting) is %dw\n',max(mech_power));
fprintf('Minimum Mechanical Power Delivered (at Starting) is %dw\n',min(abs(mech_power)));
fprintf('Average Mechanical Power Delivered (at Starting) is %dw\n',nanmean(mech_power));

fprintf('Maximum Mechanical Power Delivered is(at Overall) %dw\n',max(mech_power1));
fprintf('Minimum Mechanical Power Delivered is(at Overall) %dw\n',min(abs(mech_power1)));
fprintf('Average Mechanical Power Delivered is(at Overall) %dw\n',nanmean(mech_power1));

fprintf('Maximum Mechanical Torque Delivered is(at Starting) %dNm\n',max(mech_torque));
fprintf('Minimum Mechanical Torque Delivered is(at Starting) %dNm\n',min(abs(mech_torque)));
fprintf('Average Mechanical Torque Delivered is(at Starting) %dNm\n',nanmean(mech_torque));

fprintf('Maximum Mechanical Torque Delivered is(at Overall) %dNm\n',max(mech_torque1));
fprintf('Minimum Mechanical Torque Delivered is(at Overall) %dNm\n',min(abs(mech_torque1)));
fprintf('Average Mechanical Torque Delivered is(at Overall) %dNm\n',nanmean(mech_torque1));

torque_ripple = (max(mech_torque)-min(mech_torque))*100/mean(mech_torque);
fprintf('Mechanical Torque Ripple is(at Starting) %d\n',torque_ripple);
torque_ripple1 = (max(mech_torque1)-min(mech_torque1))*100/mean(mech_torque1);
fprintf('Mechanical Torque Ripple is(at Overall) %d\n',torque_ripple1);


motor_power_loss = abs(str_power-mech_power);
motor_power_loss1 = abs(str_power1-mech_power1);
fprintf('Maximum Motor Power Loss (at Starting) is %dw\n',max(motor_power_loss));
fprintf('Minimum Motor Power Loss (at Starting) is %dw\n',min(motor_power_loss));
fprintf('Average Motor Power Loss (at Starting) is %dw\n',mean(motor_power_loss));

fprintf('Maximum Motor Power Loss (at Overall) is %dw\n',max(motor_power_loss1));
fprintf('Minimum Motor Power Loss (at Overall) is %dw\n',min(motor_power_loss1));
fprintf('Average Motor Power Loss (at Overall) is %dw\n',mean(motor_power_loss1));

power_loss = abs(inp_power-mech_power);
fprintf('Maximum overall Power Loss (at Starting) is %dw\n',max(power_loss));
fprintf('Minimum overall Power Loss (at Starting) is %dw\n',min(power_loss));
fprintf('Average overall Power Loss (at Starting) is %dw\n',mean(power_loss));

power_loss1 = abs(inp_power1-mech_power1);
fprintf('Maximum overall Power Loss (at Overall) is %dw\n',max(power_loss1));
fprintf('Minimum overall Power Loss (at Overall) is %dw\n',min(power_loss1));
fprintf('Average overall Power Loss (at Overall) is %dw\n',mean(power_loss1));


Fs = 1 / (desired_times(2) - desired_times(1)); % calculate sampling frequency from time step

% Calculate THD for each phase current signal
thd_reotora = thd(reotora, Fs);
thd_reotorb = thd(reotorb, Fs);
thd_reotorc = thd(reotorc, Fs);

% Display the THD results
fprintf('THD for rotor current A(at Starting): %.2f%%\n', thd_reotora);
fprintf('THD for rotor current B(at Starting): %.2f%%\n', thd_reotorb);
fprintf('THD for rotor current C(at Starting): %.2f%%\n', thd_reotorc);

Fs1 = 1 / (desired_time1(2) - desired_time1(1)); % calculate sampling frequency from time step

% Calculate THD for each phase current signal
thd_reotora1 = thd(reotora1, Fs1);
thd_reotorb1 = thd(reotorb1, Fs1);
thd_reotorc1 = thd(reotorc1, Fs1);

% Display the THD results
fprintf('THD for rotor current A(at Overall): %.2f%%\n', thd_reotora1);
fprintf('THD for rotor current B(at Overall): %.2f%%\n', thd_reotorb1);
fprintf('THD for rotor current C(at Overall): %.2f%%\n', thd_reotorc1);

efficency = (mech_power./inp_power).*100;
efficency1 = (str_power1./inp_power1).*100;
fprintf('Maximum overall Efficency at starting %d%%\n',max(efficency));
fprintf('Average overall Efficency at starting %d%%\n',nanmean(efficency));
fprintf('Maximum Efficency at of Starter %d%%\n',max(efficency1));
fprintf('Average Efficency at of Starter %d%%\n',nanmean(efficency1));

figure;
plot(desired_time1,slip1, 'r', 'LineWidth', 1.1);
title('%Slip Vs Time ');
xlabel('Time (s)');
ylabel('%Slip');

figure;
plot(desired_time1,str_power_loss1, 'g', 'LineWidth', 1.1);
title('starter power loss Vs Time ');
xlabel('Time (s)');
ylabel('starter power loss');

figure;
plot(desired_time1,diff_pf1, 'r', 'LineWidth', 1.1);
title('Power Factor difference Vs Time ');
xlabel('Time (s)');
ylabel('Power Factor difference');

figure;
plot(desired_time1,motor_power_loss1, 'g', 'LineWidth', 1.1);
title('motor power loss Vs Time ');
xlabel('Time (s)');
ylabel('motor power loss');

figure;
plot(desired_time1,power_loss1, 'r', 'LineWidth', 1.1);
title('power loss Vs Time ');
xlabel('Time (s)');
ylabel('power loss');

figure;
plot(desired_time1,efficency1, 'g', 'LineWidth', 1.1);
title('Starter Efficiency Vs Time ');
xlabel('Time (s)');
ylabel('Efficiency');