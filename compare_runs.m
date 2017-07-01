function [closeness] = compare_runs(experiment_name,la_vec,run_vec,nbr_runs,prfx,sufx)
if ~exist('nbr_runs','var') || isempty(nbr_runs)
    nbr_runs=3;
end
if ~exist('prfx','var') || isempty(prfx)
    prfx='';
end
if ~exist('sufx','var') || isempty(sufx)
    sufx='';
end

runs=cell(1,nbr_runs);
for i=1:nbr_runs
    runs{i}=csvread(strcat(prfx,experiment_name,sprintf('_run%d',i),sufx,'.csv'),0,1);
%     run2=csvread(strcat(experiment_name,'_run2.csv'),0,1);
%     run3=csvread(strcat(experiment_name,'_run3.csv'),0,1);
end
runs_la_rt_rr={0, 0, 0};
for i=1:length(runs)
    la=runs{i}(:,1:3);
    la=la(:,logical(la_vec));
    runs_la_rt_rr{i}=[la,runs{i}(:,[4,7])];
    runs_la_rt_rr{i}=sortrows(runs_la_rt_rr{i},size(runs_la_rt_rr{i},2));
end
hf=figure; hold on;
for i=1:length(runs)
    for j=1:size(runs_la_rt_rr{i},2)-1
        plot(runs_la_rt_rr{i}(:,end),runs_la_rt_rr{i}(:,j),'Color',(1:3==i)*j/size(runs_la_rt_rr{i},2))
    end
end
xlabel('Request Rate \rightarrow');
ylabel('Response time (ms) / Load-average');
title(experiment_name);
if ~exist('run_vec','var') || isempty(run_vec)
    x = input('Which runs to chose?[1 1 1] : ');
else
    x=run_vec;
end
close(hf);
figure;hold on;
sz=size(runs_la_rt_rr{1});
if sum(x)==1
    sz=size(runs_la_rt_rr{logical(x)});
end
final_run=zeros(sz);
for i=1:nbr_runs
    if x(i)==0
        continue
    end
    final_run=final_run+ x(i).*runs_la_rt_rr{i}(1:size(final_run,1),:);
end
final_run=final_run./sum(x);
la_rt_rr=[mean(final_run(:,1:sum(la_vec)),2), final_run(:,sum(la_vec)+1:end)];
la_rt_rr=sortrows(la_rt_rr,size(la_rt_rr,2));
closeness=la_rt_rr;
colors=['k','m'];
for j=1:size(la_rt_rr,2)-1
    plot(la_rt_rr(:,end),la_rt_rr(:,j),'-','Color',colors(j));
end
xlabel('Request Rate \rightarrow');
ylabel('Response time (ms) / Load-average');
title(experiment_name);
end