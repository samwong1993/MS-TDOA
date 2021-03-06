sigma = [0:100:1000];
c = 3*10^5;
sigma_axis = sigma;
%sigma = sigma_axis;
sigma = 10^(-9)*sigma*c;
crlb = zeros(length(sigma),1);


R = 6371.2;
M = 6;
N = M*(M-1)/2;
Omega = covariance(1,M);
inv_Omega = inv(Omega(1:M-1,1:M-1));
delta = 0;
Rm = 6650;
Ym = 100;
Rb = Rm - Ym;
fc = 10;
f = 15;
F = f/fc;
[max_dis,min_dis,upper] = beta_bound(M,F,R,Rb,Rm,Ym);
[G] = generate_G(N,M);
XYZ = zeros(M,3);
%Bei Jing
[x0 y0 z0] = LGLTtoXYZ(116.41,39.90,R);
XYZ(1,:) = [x0 y0 z0];
%Wu Han
[x0 y0 z0] = LGLTtoXYZ(114.31,30.59,R);
XYZ(2,:) = [x0 y0 z0];
%Shang Hai
[x0 y0 z0] = LGLTtoXYZ(121.47,31.23,R);
XYZ(3,:) = [x0 y0 z0];
%Tokyo
[x0 y0 z0] = LGLTtoXYZ(139.69,35.69,R);
XYZ(4,:) = [x0 y0 z0];
%Seoul
[x0 y0 z0] = LGLTtoXYZ(126.58,37.33,R);
XYZ(5,:) = [x0 y0 z0];
%Qing Dao
[x0 y0 z0] = LGLTtoXYZ(120.3826,36.0671,R);
XYZ(6,:) = [x0 y0 z0];                  

%Jia Yi
[x0 y0 z0] = LGLTtoXYZ(120.4491,23.4801,R);
emitter1 = [x0 y0 z0]';
beta = zeros(1,M);
x = emitter1';
for k = 1:M
    beta = solve_eq(F,R,Rb,Rm,Ym,beta,XYZ,x,k);
end
beta1 = beta;
emitter(:,1) = emitter1;
% beta2 = [0.130743022187950,0.391197329272201,0.520620592610200,0.0738255619888921,0.168515720771200];
%Yin Chuan
[x0 y0 z0] = LGLTtoXYZ(106.2309,38.4872,R);
emitter2 = [x0 y0 z0]';
beta = zeros(1,M);
x = emitter2';
for k = 1:M
    beta = solve_eq(F,R,Rb,Rm,Ym,beta,XYZ,x,k);
end
beta2 = beta;
emitter(:,2) = emitter2;
% beta1 = [0.486164591596301,0.310478405869350,0.177057112583560,0.00974700715358300,0.143452972295470];
%Qiqi Haer
[x0 y0 z0] = LGLTtoXYZ(123.9182,47.3543,R);
emitter3 = [x0 y0 z0]';
% beta3 = [0.373296850690061,0.105761408290660,0.140327847255840,0.134834308670000,0.315574458947491];
beta = zeros(1,M);
x = emitter3';
for k = 1:M
    beta = solve_eq(F,R,Rb,Rm,Ym,beta,XYZ,x,k);
end
beta3 = beta;
emitter(:,3) = emitter3;
%Hong Kong
[x0 y0 z0] = LGLTtoXYZ(114.16,22.28,R);
emitter4 = [x0 y0 z0]';
beta = zeros(1,M);
x = emitter4';
for k = 1:M
    beta = solve_eq(F,R,Rb,Rm,Ym,beta,XYZ,x,k);
end
beta4 = beta;
emitter(:,4) = emitter4;
K = 4;


index = [1 2 3 4 5 6];
for idx = 1:K
    for noise_level = 2:length(sigma)
        eval("crlb(noise_level) = crlb(noise_level) + CRLB_tdoaOTHR(F, Rb, Ym, Rm, R, beta"+string(idx)+", XYZ, emitter"+string(idx)+", sigma(noise_level), M,index);");
    end
end
err = [];
clf
for idx_SNR = 1:length(sigma)
    filename = ".\real_M6_"+string(sigma_axis(idx_SNR))+".txt";
    [err_1,err_2,err_3,err_4]=textread(filename,'%f%f%f%f','delimiter',',');
    err = [err (mean(err_1) + mean(err_2) + mean(err_3) + mean(err_4))];
end
plot(sigma_axis,1000*crlb,'r','linewidth',1.5);
hold on
plot(sigma_axis,1000*err,'ok-','linewidth',1.1,'markerfacecolor',[36, 169, 225]/255);




M = 4;
N = M*(M-1)/2;
Omega = covariance(1,M);
inv_Omega = inv(Omega(1:M-1,1:M-1));
delta = 0;
Rm = 6650;
Ym = 100;
Rb = Rm - Ym;
fc = 10;
f = 15;
F = f/fc;
[max_dis,min_dis,upper] = beta_bound(M,F,R,Rb,Rm,Ym);
[G] = generate_G(N,M);
XYZ = zeros(M,3);
%Bei Jing
[x0 y0 z0] = LGLTtoXYZ(116.41,39.90,R);
XYZ(1,:) = [x0 y0 z0];
%Wu Han
[x0 y0 z0] = LGLTtoXYZ(114.31,30.59,R);
XYZ(2,:) = [x0 y0 z0];
%Shang Hai
[x0 y0 z0] = LGLTtoXYZ(121.47,31.23,R);
XYZ(3,:) = [x0 y0 z0];
%Tokyo
[x0 y0 z0] = LGLTtoXYZ(139.69,35.69,R);
XYZ(4,:) = [x0 y0 z0];            

%Jia Yi
[x0 y0 z0] = LGLTtoXYZ(120.4491,23.4801,R);
emitter1 = [x0 y0 z0]';
beta = zeros(1,M);
x = emitter1';
for k = 1:M
    beta = solve_eq(F,R,Rb,Rm,Ym,beta,XYZ,x,k);
end
beta1 = beta;
emitter(:,1) = emitter1;
% beta2 = [0.130743022187950,0.391197329272201,0.520620592610200,0.0738255619888921,0.168515720771200];
%Yin Chuan
[x0 y0 z0] = LGLTtoXYZ(106.2309,38.4872,R);
emitter2 = [x0 y0 z0]';
beta = zeros(1,M);
x = emitter2';
for k = 1:M
    beta = solve_eq(F,R,Rb,Rm,Ym,beta,XYZ,x,k);
end
beta2 = beta;
emitter(:,2) = emitter2;
% beta1 = [0.486164591596301,0.310478405869350,0.177057112583560,0.00974700715358300,0.143452972295470];
%Qiqi Haer
[x0 y0 z0] = LGLTtoXYZ(123.9182,47.3543,R);
emitter3 = [x0 y0 z0]';
% beta3 = [0.373296850690061,0.105761408290660,0.140327847255840,0.134834308670000,0.315574458947491];
beta = zeros(1,M);
x = emitter3';
for k = 1:M
    beta = solve_eq(F,R,Rb,Rm,Ym,beta,XYZ,x,k);
end
beta3 = beta;
emitter(:,3) = emitter3;
%Hong Kong
[x0 y0 z0] = LGLTtoXYZ(114.16,22.28,R);
emitter4 = [x0 y0 z0]';
beta = zeros(1,M);
x = emitter4';
for k = 1:M
    beta = solve_eq(F,R,Rb,Rm,Ym,beta,XYZ,x,k);
end
beta4 = beta;
emitter(:,4) = emitter4;
K = 4;


index = [1 2 3 4];
for idx = 1:K
    for noise_level = 2:length(sigma)
        eval("crlb(noise_level) = crlb(noise_level) + CRLB_tdoaOTHR(F, Rb, Ym, Rm, R, beta"+string(idx)+", XYZ, emitter"+string(idx)+", sigma(noise_level), M,index);");
    end
end
err = [];
for idx_SNR = 1:length(sigma)
    filename = ".\real_M4_"+string(sigma_axis(idx_SNR))+".txt";
    [err_1,err_2,err_3,err_4]=textread(filename,'%f%f%f%f','delimiter',',');
    err = [err (mean(err_1) + mean(err_2) + mean(err_3) + mean(err_4))];
end
plot(sigma_axis,1000*crlb,'b','linewidth',1.5);
hold on
plot(sigma_axis,1000*err,'^k-','linewidth',1.1,'markerfacecolor',[36, 169, 225]/255);
xlabel('Standard Deviation of TDOA Measurement Noise (ns)')
ylabel('RMSE of the Geolocation(m)')
legend("CRLB M=6",'AMLC M=6',"CRLB M=4",'AMLC M=4');