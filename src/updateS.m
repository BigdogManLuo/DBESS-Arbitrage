function s_new=updateS(s,a,dt,S,A,P_set) %num��ʾ��һ�黹�ǵڶ�����
    SOC=S(s);
    P_dbess=A(a);
    SOC_new=SOC-P_dbess*dt;
    s_new=SOC_new/P_set+1;
end