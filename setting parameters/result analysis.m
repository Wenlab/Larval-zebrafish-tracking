fish_pos_c = load('tracking result with prediction/30 gamma=0.1 head2yolk new_stage matching 10ms/negtive_velocity_suppress_history_length_3/output_fish_tr.txt');
stage_pos = load('tracking result with prediction/30 gamma=0.1 head2yolk new_stage matching 10ms/negtive_velocity_suppress_history_length_3/output_stage_position.txt');
fish_direction_c = load('tracking result with prediction/30 gamma=0.1 head2yolk new_stage matching 10ms/negtive_velocity_suppress_history_length_3/output_fish_direction.txt');
temp = load('tracking result with prediction/30 gamma=0.1 head2yolk new_stage matching 10ms/negtive_velocity_suppress_history_length_3/output_fish_tr_predicted.txt');
command = load('tracking result with prediction/30 gamma=0.1 head2yolk new_stage matching 10ms/negtive_velocity_suppress_history_length_3/output_command.txt');
fish_velocity_average_proj = load('tracking result with prediction/30 gamma=0.1 head2yolk new_stage matching 10ms/negtive_velocity_suppress_history_length_3/output_fish_v_predicted.txt');
fish_tr_predicted = temp(:,13:14);
fish_tr_predicted_yolk = temp(:,11:12);
% fish_pos_s = temp(:,1:2);
fish_position_proj = temp(:,3:4);
% fish_direction_s = temp(:,5:6);
fish_direction_average = temp(:,7:8);
fish_position_average = temp(:,9:10);
theta = atan(-0.0065);
dst_x = 264;
dst_y = 182;
scale = 32.5;
fish_pos_s(:,1) = ((fish_pos_c(:,1)-dst_x)*cos(theta)-(fish_pos_c(:,2)-dst_y)*sin(theta))/scale - stage_pos(:,1)/10000;
fish_pos_s(:,2) = ((fish_pos_c(:,2)-dst_y)*cos(theta)+(fish_pos_c(:,1)-dst_x)*sin(theta))/scale - stage_pos(:,2)/12800;
fish_tr_predicted = [fish_pos_s(1,:);fish_tr_predicted];
fish_tr_predicted(length(fish_tr_predicted),:) = [];
prediction_error = fish_tr_predicted - fish_pos_s;
fish_direction_s(:,1) = fish_direction_c(:,1)*cos(theta)-fish_direction_c(:,2)*sin(theta);
fish_direction_s(:,2) = fish_direction_c(:,2)*cos(theta)+fish_direction_c(:,1)*sin(theta);

figure;
plot(fish_pos_s);
hold on;
plot(fish_tr_predicted);
plot(-stage_pos(:,1)/10000);
plot(-stage_pos(:,2)/12800);

fish_pos_c_error(:,1) = abs(fish_pos_c(:,1)-dst_x);
fish_pos_c_error(:,2) = abs(fish_pos_c(:,2)-dst_y);
figure;
plot(fish_pos_c_error);

n_start=29265;
n_end=29280;
figure;
quiver(fish_pos_s(n_start:n_end,1),fish_pos_s(n_start:n_end,2),fish_direction_s(n_start:n_end,1)/10,fish_direction_s(n_start:n_end,2)/10,0);
hold on;
plot(fish_pos_s(n_start:n_end,1),fish_pos_s(n_start:n_end,2));
quiver(fish_pos_s(n_start:n_end,1),fish_pos_s(n_start:n_end,2),prediction_error(n_start:n_end,1),prediction_error(n_start:n_end,2),0,'r');
plot(fish_tr_predicted(n_start:n_end,1),fish_tr_predicted(n_start:n_end,2),'g');
plot(fish_tr_predicted_yolk(n_start:n_end,1),fish_tr_predicted_yolk(n_start:n_end,2),'g');
plot(fish_position_proj(n_start:n_end,1),fish_position_proj(n_start:n_end,2),'y');
quiver(fish_position_proj(n_start:n_end,1),fish_position_proj(n_start:n_end,2),fish_velocity_average_proj(n_start:n_end,1),fish_velocity_average_proj(n_start:n_end,2),0,'g');
plot(fish_position_average(n_start:n_end,1),fish_position_average(n_start:n_end,2),'b');
quiver(fish_position_average(n_start:n_end,1),fish_position_average(n_start:n_end,2),fish_direction_average(n_start:n_end,1)/10,fish_direction_average(n_start:n_end,2)/10,0,'g');

figure;
plot(fish_pos_c);
figure;
plot(prediction_error);

figure;
plot(command(:,1));
hold on;
plot(command(:,2));