function [t_sum,obj_sum,location] = solve_GPGD(M,N,F,Rb,Rm,Ym,P_F,R,P_Rb,P_Rm,P_Ym,G,P_tau0,inv_Omega,upper,max_dis,min_dis,XYZ,plt,K)
t_sum = [];
for i = 1:K
    [x, beta, obj] = GPGD(M,N,P_F,R,P_Rb,P_Rm,P_Ym,G(1:M-1,:),eval("P_tau0(1:M-1,"+string(i)+")'"),inv_Omega,upper,max_dis,min_dis,XYZ,plt);
    [A B C] = ABC(F,R,Rb,Rm,Ym,beta);
    [t D] = PD(A,B,C,beta,R,Rb);
    t_sum = [t_sum,t'];
    obj_sum(i) = obj;
    eval("location.x"+string(i)+"=x;");
end
end


% [x0, beta0, obj0] = GPGD(M,N,P_F,R,P_Rb,P_Rm,P_Ym,G(1:M-1,:),P_tau0(1:M-1,1)',inv_Omega,upper,max_dis,min_dis,XYZ,plt);
% [A B C] = ABC(F,R,Rb,Rm,Ym,beta0);
% [t0 D] = PD(A,B,C,beta0,R,Rb);
% [x1, beta1, obj1] = GPGD(M,N,P_F,R,P_Rb,P_Rm,P_Ym,G(1:M-1,:),P_tau0(1:M-1,2)',inv_Omega,upper,max_dis,min_dis,XYZ,plt);
% [A B C] = ABC(F,R,Rb,Rm,Ym,beta1);
% [t1 D] = PD(A,B,C,beta1,R,Rb);
% [x2, beta2, obj2] = GPGD(M,N,P_F,R,P_Rb,P_Rm,P_Ym,G(1:M-1,:),P_tau0(1:M-1,3)',inv_Omega,upper,max_dis,min_dis,XYZ,plt);
% [A B C] = ABC(F,R,Rb,Rm,Ym,beta2);
% [t2 D] = PD(A,B,C,beta2,R,Rb);
% t = [t0',t1',t2'];
% obj = obj0 + obj1 + obj2
% norm(x0 - emitter1')
% norm(x1 - emitter2')
% norm(x2 - emitter2')

