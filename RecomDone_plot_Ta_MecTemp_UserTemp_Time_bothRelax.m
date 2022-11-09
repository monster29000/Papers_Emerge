path = ['Ta',filesep,'q2',filesep]; 
    
users = [20,25,30,35,40,45]; %x轴采样点
y=zeros(6,2); %两条线-温度
y2=zeros(6,1); %一条线-时间

i = 1;
for user=users %遍历x轴采样点
    q2_result_path = [path,num2str(user),filesep,'result.mat'];
    q2_t2_path = [path,num2str(user),filesep,'t2.mat'];

    q2_result_data = load(q2_result_path);
    q2_t2_data = load(q2_t2_path);

    q2_t2 = q2_t2_data.t2;
    q2_user_temperature = q2_result_data.tUser_current_CPU_list(q2_t2,1); %用户温度
    q2_mec_temperature = q2_result_data.tMec_current_CPU_list(q2_t2,1); %mec温度
    
    y(i,1) =  q2_user_temperature;
    y(i,2) =  q2_mec_temperature;
    
%     y2(i,1) = q1_result_data.ObjValue_list(q1_t2);
    y2(i,1) = q2_result_data.ObjValue_list(q2_t2);
    i = i+1;
end
users = [20,25,30,35,40,45];
yyaxis left
plot(users,y(:,1),'linewidth',4);
hold on;
plot(users,y(:,2),'linewidth',4);
hold on;
ylabel('CPU Temperature (°C)');
yyaxis right
plot(users,y2(:,1)','linewidth',4);
hold on;
% plot(users,y2(:,2)','linewidth',4);
grid;
set(gca,'XTick',20:5:45);
xlabel('Ambient Temperature (°C)');
ylabel('Total Latency (s)');
