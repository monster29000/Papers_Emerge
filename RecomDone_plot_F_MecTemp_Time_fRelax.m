path = ['f=0.4',filesep]; %User不在温度阈值上
% path = ['f=1',filesep]; %User在温度阈值上
    
users = [4,5,6,7,8,9]; %x轴采样点
y=zeros(6,2); %两条线-温度
y2=zeros(6,2); %两条线-时间

i = 1;
for user=users %遍历x轴采样点
    q1_result_path = [path,'F=4to9',filesep,'q1',filesep,num2str(user),filesep,'result.mat'];
    q2_result_path = [path,'F=4to9',filesep,'q2',filesep,num2str(user),filesep,'result.mat'];
    q1_t2_path = [path,'F=4to9',filesep,'q1',filesep,num2str(user),filesep,'t2.mat'];
    q2_t2_path = [path,'F=4to9',filesep,'q2',filesep,num2str(user),filesep,'t2.mat'];

    q1_result_data = load(q1_result_path);
    q2_result_data = load(q2_result_path);
    q1_t2_data = load(q1_t2_path);
    q2_t2_data = load(q2_t2_path);

    q1_t2 = q1_t2_data.t2;
    q2_t2 = q2_t2_data.t2;
    q1_mec_temperature = q1_result_data.tMec_current_CPU_list(q1_t2,1);
    q2_mec_temperature = q2_result_data.tMec_current_CPU_list(q2_t2,1);
    
    y(i,1) =  q1_mec_temperature;
    y(i,2) =  q2_mec_temperature;
    
    y2(i,1) = q1_result_data.ObjValue_list(q1_t2);
    y2(i,2) = q2_result_data.ObjValue_list(q2_t2);
    i = i+1;
end
users = [4,5,6,7,8,9];
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
set(gca,'XTick',4:1:9);
xlabel('MEC $F_{m}^{max}$ (GHz) under fMax=0.4GHz');
ylabel('Total Latency (s)');
