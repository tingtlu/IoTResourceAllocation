function [isValid,new_c,new_et] = testVaild(ti,serv,x,job,c,C,theta,et)

L = job(ti)./(sum(x.*theta,2));
P = x(ti);

% 根据论文公式计算，每个子任务的分配的计算量
tmp_c = min((L(ti)*C(serv))./(P.*L));

new_et = L./tmp_c;
toal = sum(x.*tmp_c);
%每台服务中所有子任务所分配的计算能力不超过该服务器的总计算容量
if toal(serv) <= C(serv) && (new_et(ti) < et(ti))
    isValid = true;
    new_c = tmp_c;
else
    isValid = false;
    new_et = et;
    new_c = c;
end