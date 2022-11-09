path = ['ECRA',filesep];     
users = [4,5,6,7,8]; %x�������
y=zeros(5,2); %������-Mec�¶�
y2=zeros(5,2); %������-�㷨�Աȣ�ʱ��

i = 1;
for user=users %����x�������
    q2_result_path = [path,filesep,'q2',filesep,num2str(user),filesep,'result.mat'];
    q3_result_path = [path,filesep,'q3',filesep,num2str(user),filesep,'result.mat'];
    q2_t2_path = [path,filesep,'q2',filesep,num2str(user),filesep,'t2.mat'];
    q3_t2_path = [path,filesep,'q3',filesep,num2str(user),filesep,'t2.mat'];

    q2_result_data = load(q2_result_path);
    q3_result_data = load(q3_result_path);
    q2_t2_data = load(q2_t2_path);
    q3_t2_data = load(q3_t2_path);

    q2_t2 = q2_t2_data.t2;
    q3_t2 = q3_t2_data.t2;
    q2_mec_temperature = q2_result_data.tMec_current_CPU_list(q2_t2+1,1);%mec�¶���F�ı仯
    q3_mec_temperature = q3_result_data.tMec_current_CPU_list(q3_t2+1,1);%mec�¶���F�ı仯
    
    y(i,1) =  q2_mec_temperature;
    y(i,2) =  q3_mec_temperature;
    
    y2(i,1) = q2_result_data.ObjValue_list(q2_t2);
    y2(i,2) = q3_result_data.ObjValue_list(q3_t2);
    i = i+1;
end
users = [4,5,6,7,8];
yyaxis left
plot(users,y(:,1),'linewidth',4);
hold on;
plot(users,y(:,2),'linewidth',4);
ylabel('MEC CPU Temperature (��C)');
yyaxis right
plot(users,y2(:,1)','linewidth',4);
hold on;
plot(users,y2(:,2)','linewidth',4);
grid;
set(gca,'XTick',4:1:8);
xlabel('MEC $F_{m}^{max}$ (GHz) under fMax=0.4GHz');
ylabel('Total Latency (s)');
