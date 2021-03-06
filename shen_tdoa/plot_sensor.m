clear all
num = [4,5,6,7,8,9];
SNR = 10;
err = [];
clf
for idx = 1:length(num)
    filename = ".\model_5_M"+string(num(idx))+"_SNR10.txt";
    [err_1,err_2,err_3]=textread(filename,'%f%f%f','delimiter',',');
    err = [err (mean(err_1) + mean(err_2) + mean(err_3))];
end
err_shen = [];
for idx = 1:length(num)
    filename = ".\shen_model_5_M"+string(num(idx))+"_SNR10.txt";
    [err_1,err_2,err_3]=textread(filename,'%f%f%f','delimiter',',');
    err_shen = [err_shen (mean(err_1) + mean(err_2) + mean(err_3))];
end

plot(num,err_shen,'^-', 'linewidth', 1.1, 'markerfacecolor', [29, 191, 151]/255);
hold on
plot(num,err,'ok-','linewidth',1.1,'markerfacecolor',[36, 169, 225]/255);

% for i = 1:m
%     plot(sigma,10^3*error(i,:),'b--o') 
% end



sigma = 0.1;
%Attack example 1 
s = [40,40,-40,-40,40,0,-40,0,10;40,-40,40,-40,0,40,0,-40,5];
xTrue = [10,20,0;-10,0,-10];
% %Attack example 5
s = [800,300,1500,-600,1500,1000,-1000,-1000,0;600,450,-1000,700,800,0,0,-1000,-1500];
xTrue = [1000,-200,300;-1000,-250,200];
[d,M] = size(s); K = size(xTrue,2);
Omega = ones(M-1,M-1)+eye(M-1);
k = max(num);
crlb(k) = TDOALocCRLB(s,xTrue(:,1),Omega,sigma) + TDOALocCRLB(s,xTrue(:,2),Omega,sigma) + TDOALocCRLB(s,xTrue(:,3),Omega,sigma);
for idx = 1:max(num) - min(num)
    k = k - 1;
    s = s(:,1:size(s,2)-1);
    [d,M] = size(s); K = size(xTrue,2);
    Omega = ones(M-1,M-1)+eye(M-1);
    crlb(k) = TDOALocCRLB(s,xTrue(:,1),Omega,sigma) + TDOALocCRLB(s,xTrue(:,2),Omega,sigma) + TDOALocCRLB(s,xTrue(:,3),Omega,sigma);
end
ylim([0 100])
plot(num,crlb(num),'*-r','linewidth',1.5);
legend("Shen's Alg with L-2 norm",'AMLC','CRLB');
xlabel('Number of Sensors')
ylabel('RMSE (m)')
set(gca,'yscale','log')
set(gca,'xtick',num)
