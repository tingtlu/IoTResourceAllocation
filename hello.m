function [isValid,new_c,new_et] = testVaild(ti,serv,x,job,c,C,theta,et)

% L = zeros(10,1);
% P = zeros(10,4);
% P = zeros(10,1);
L = job(ti)./(sum(x.*theta,2));
P = x(ti);
% P = sum(x,2);

% 根据论文公式计算，每个子任务的分配的计算量
% c = min((L*C)./sum(P.*L),[],2);
% tmp_c = c(ti);
tmp_c = min((L(ti)*C(serv))./(P.*L));
% c = min((L*sum(C))./sum(P.*L),[],2);

% new_et = zeros(10,1);
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