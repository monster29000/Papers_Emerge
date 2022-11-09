path = ['N',filesep,'f=0.4,F=6',filesep]; 

M=3;
K=6;
users = [64,128,256,512]; %x轴采样点
y=zeros(4,1); %一条线-时延 
y2=zeros(4,2); %两条线-温度：MEC温度+User温度
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
    
%     y(i,1) = q1_result_data.ObjValue_list(q1_t2); %q1-时延    
%     y2(i,1) = sum(q1_result_data.tMec_current_CPU_list(q1_t2,:))/M; %q1MEC温度
%     y2(i,2) = sum(q1_result_data.tUser_current_CPU_list(q1_t2,:))/K; %q1User温度
    %这时候考不考虑温度约束对图像都没有影响，因为f、F都是全分配，即q1、q2图像相同
    y(i,1) = q2_result_data.ObjValue_list(q2_t2); %q2-时延
    y2(i,1) = sum(q2_result_data.tMec_current_CPU_list(q2_t2,:))/M; %q2MEC温度
    y2(i,2) = sum(q2_result_data.tUser_current_CPU_list(q2_t2,:))/K; %q2User温度

    i = i+1;
end

% users = [10,20,30,40,50,60];
% plot(users,y(:,1),'linewidth',4);
% hold on;
% plot(users,y(:,2),'linewidth',4);
% hold on;
% grid;
% set(gca,'XTick',10:10:60);
% xlabel('pMax(mW)');
% ylabel('Total Latency(s)');
users = [64,128,256,512];
interval = 1:length(users);
yyaxis left
plot(interval,y2(:,1)','linewidth',4);
hold on;
plot(interval,y2(:,2)','linewidth',4);
hold on;
set(gca,'XTick',[1:1:4]);
ylabel('CPU Temperature (°C)');
yyaxis right
plot(interval,y(:,1)','linewidth',4);
hold on;
% plot(users,y(:,2),'linewidth',4);
grid;
set(gca,'XTickLabel',{'64','128','256','512'});
xlabel('Number of Subcarries (N)');
ylabel('Total Latency (s)');

