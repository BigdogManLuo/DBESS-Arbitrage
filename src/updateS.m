function s_new=updateS(s,a,dt,S,A,P_set) %num表示第一组还是第二组电池
    SOC=S(s);
    P_dbess=A(a);
    SOC_new=SOC-P_dbess*dt;
    s_new=SOC_new/P_set+1;
end