path = ['F=6',filesep]; %Mec不在温度阈值上
% path = ['F=8',filesep]; %Mec在温度阈值上
    
users = [0.1,0.2,0.3,0.4,0.5,0.6,0.7]; %x轴采样点
y=zeros(6,2); %两条线-mec温度
y2=zeros(6,2); %两条线-user温度

i = 1;
for user=users %遍历x轴采样点
    q1_result_path = [path,'q1',filesep,num2str(user),filesep,'result.mat'];
    q2_result_path = [path,'q2',filesep,num2str(user),filesep,'result.mat'];
    q1_t2_path = [path,'q1',filesep,num2str(user),filesep,'t2.mat'];
    q2_t2_path = [path,'q2',filesep,num2str(user),filesep,'t2.mat'];

    q1_result_data = load(q1_result_path);
    q2_result_data = load(q2_result_path);
    q1_t2_data = load(q1_t2_path);
    q2_t2_data = load(q2_t2_path);

    q1_t2 = q1_t2_data.t2;
    q2_t2 = q2_t2_data.t2;
    q1_mec_temperature = q1_result_data.tMec_current_CPU_list(q1_t2,1);
    q2_mec_temperature = q2_result_data.tMec_current_CPU_list(q2_t2,1);
    q1_user_temperature = q1_result_data.tUser_current_CPU_list(q1_t2,1);
    q2_user_temperature = q2_result_data.tUser_current_CPU_list(q2_t2,1);

    y(i,1) =  q1_mec_temperature;
    y(i,2) =  q2_mec_temperature;
    
    y2(i,1) = q1_user_temperature;
    y2(i,2) = q2_user_temperature;
    i = i+1;
end
users = [0.1,0.2,0.3,0.4,0.5,0.6,0.7];
yyaxis left
plot(users,y(:,1),'linewidth',4);
hold on;
plot(users,y(:,2),'linewidth',4);
hold on;
ylabel('MEC CPU Temperature (°C)');
yyaxis right
plot(users,y2(:,1)','linewidth',4);
hold on;
plot(users,y2(:,2)','linewidth',4);
grid;
set(gca,'XTick',0.1:0.1:0.7);
xlabel('User $f_{k}^{max}$ (GHz) under FMax=6GHz');
ylabel('User CPU Temperature (°C)');
