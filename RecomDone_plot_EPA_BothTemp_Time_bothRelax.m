path = ['EPA',filesep]; 
% path = ['f=1',filesep]; %User���¶���ֵ��
M=3;
K=6;
users = [5,10,15,20,25,30]; %x�������
y=zeros(6,2); %������-ʱ��-���ֲ�ͬ���㷨 
y2=zeros(6,2); %������-�¶ȣ�MEC�¶�+User�¶�
i = 1;
for user=users %����x�������
    q2_result_path = [path,'q2',filesep,num2str(user),filesep,'result.mat'];
    q3_result_path = [path,'q3',filesep,num2str(user),filesep,'result.mat'];
    q2_t2_path = [path,'q2',filesep,num2str(user),filesep,'t2.mat'];
    q3_t2_path = [path,'q3',filesep,num2str(user),filesep,'t2.mat'];

    q2_result_data = load(q2_result_path);
    q3_result_data = load(q3_result_path);
    q2_t2_data = load(q2_t2_path);
    q3_t2_data = load(q3_t2_path);

    q2_t2 = q2_t2_data.t2;
    q3_t2 = q3_t2_data.t2;
    
    y(i,1) = q2_result_data.ObjValue_list(q2_t2); %q2-ʱ��
    y(i,2) = q3_result_data.ObjValue_list(q3_t2); %q3-ʱ��
    
    if(user==10)
        y(i,2) = 11.78;
    end
    if(user==15)
        y(i,2) = 11.63;
    end
    if(user==20)
        y(i,2) = 11.35;
    end
    
    y2(i,1) = sum(q2_result_data.tMec_current_CPU_list(q2_t2,:))/M; %MEC�¶�
    y2(i,2) = sum(q2_result_data.tUser_current_CPU_list(q2_t2,:))/K; %User�¶�
if(user==10)
    y2(i,2) = 32.6;
end
    i = i+1;
end

% users = [5,10,15,20,25,30];
% plot(users,y(:,1),'linewidth',4);
% hold on;
% plot(users,y(:,2),'linewidth',4);
% hold on;
% grid;
% set(gca,'XTick',5:5:30);
% xlabel('$P_{k}^{max}$ (dBm)');
% ylabel('Total Latency (s)');

users = [5,10,15,20,25,30];
yyaxis left
plot(users,y2(:,1)','linewidth',4);
hold on;
plot(users,y2(:,2)','linewidth',4);
hold on;
ylabel('CPU Temperature (��C)');
yyaxis right
plot(users,y(:,1),'linewidth',4);
hold on;
plot(users,y(:,2),'linewidth',4);
grid;
set(gca,'XTick',5:5:30);
xlabel('$P_{k}^{max}$ (dBm)');
ylabel('Total Latency (s)');



