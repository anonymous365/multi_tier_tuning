%% comparison of tuning 
tune_date=cell(1,3);
suffix={'_httperf_untune','_httperf_ostune','_httperf_tuned'};

tune_date{1,1}=compare_runs('laexp_3mem_3web',[1 0 0],[1 0 0],1,'',suffix{1});
tune_date{1,2}=compare_runs('laexp_3mem_3web',[1 0 1],[1 0 0],1,'',suffix{2});
tune_date{1,3}=compare_runs('laexp_3mem_3web',[1 1 1],[1 0 0],1,'',suffix{3});
% close all;
%%
for i=1:1
    for j=1:3
        tune_date{i,j}(:,end)=tune_date{i,j}(:,end)./10;
    end
end
%%
marks={'-','--','-.'};
cols=[1 0 0; 0 0 1;0 0 0];
i=1;
for k=1:2
    figure;hold on;
    min_x=5000;
    max_x=0;
    for j=1:3
        plot(tune_date{i,j}(:,end),tune_date{i,j}(:,k),marks{j},'Color',cols(j,:))
        if max(tune_date{i,j}(:,end)) > max_x
            max_x=max(tune_date{i,j}(:,end));
        end
        if min(tune_date{i,j}(:,end)) < min_x
            min_x=min(tune_date{i,j}(:,end));
        end
    end
    set(gcf, 'Position', [100, 100, 600, 400]);
    set(gca,'fontsize', 12);
    if k==1
        legend('LA_{untuned}','LA_{tuned_{OS}}','LA_{tuned}','Orientation','Horizontal','Location','northwest');
        fname=strcat('comp_tuning_la_3mem_3web.pdf');
%         ylim([0 50]);
        ylabel('Load-average \rightarrow');
    else
        legend('RT_{untuned}','RT_{tuned_{OS}}','RT_{tuned}','Orientation','Horizontal','Location','northwest');
        fname=strcat('comp_tuning_rt_3mem_3web.pdf');
%         ylim([0 10]);
        ylabel('Response time (ms)\rightarrow');
    end
    xlim([min_x-10 max_x+10]);
    xlabel('Throughput (Kilo Ops/sec) \rightarrow');
    export_fig(fname,'-p0.02','-transparent')
end
%% evenly spaced sweep from 600 to 2200, comparison for Web FPM.MC and WC
web_rts=cell(3,2);
prfx={'lb_wc1500/','lb_wc2100/'};
for i=1:3
    for j=1:2
        runs_mat=[];
        for k=1:2
            runs_mat(:,:,k) = csvread(strcat(prfx{j},sprintf('RT_comp_epollWeb_wcXpmc_1mem_%dweb_run%d.csv',i,k)));
        end
        web_rts{i,j} = mean(runs_mat,3);
        if j==1 % the run for 2100 already had the subset values of wc and pmc
            web_rts{i,j} = web_rts{i,j}(5:end,1:3);
        end
    end
end
%% for comparison of RT groups
marks={'--','-.','-'};
cols=[0.7 0 0; 0 0 0.7;0 0.5 0];
for i=1:3
    figure; hold on;
%         bar(1400:200:2200,[web_rts{i,1} web_rts{i,2}]);
        for j=1:3 % Anshul wants to plot as lines not as bar chart
            plot(1400:200:2200,web_rts{i,2}(:,j),marks{j},'Color',cols(j,:),'LineWidth',2.5);
        end
        set(gcf, 'Position', [100, 100, 500, 350]);
        h=legend(strread(num2str(75:25:125),'%s'));
%         h=legend('75_{1500}','100_{1500}','125_{1500}','75_{2100}','100_{2100}','125_{2100}','Orientation','Horizontal','Position',[280 350 0.2 0.2]');
        v = get(h,'title');
        set(v,'string','Max Children');
%         set(v,'string','Max Children_{LB_{WC}}');
    fname=strcat('comp_epollWeb_wcXpmc_lbWC2100_1mem_',num2str(i),'web_2runs_avg.pdf');
    set(gca,'fontsize', 14);
    ylim([0 50]);
    ylabel('Response time (ms)\rightarrow');
    xlabel('worker connections \rightarrow');
    export_fig(fname,'-p0.02','-transparent')
end
%% for single set of RT groups,
for i=1:3
    figure; hold on;
    bar(1400:200:2200,web_rts{i});
    set(gcf, 'Position', [100, 100, 700, 500]);
    h=legend(strread(num2str(75:25:125),'%s'));
    v = get(h,'title');
    set(v,'string','Max Children');
    fname=strcat('comp_epollWeb_wcXpmc_1mem_',num2str(i),'web_2runs_avg.pdf');
    ylim([0 50]);
    ylabel('Response time (ms)\rightarrow');
    xlabel('worker connections \rightarrow');
    export_fig(fname,'-p0.02','-transparent')
end

%% fine sweep from 800 to 2100 comparison for LB Worker_connections
web_epoll = cell(3,3); % 3 web vs 3 configs (without epoll, epollLB, epollEV)
run_webs=[1 0 0; 1 0 1; 1 1 1];
prfx={'RT_comp_','RT_comp_epoll_','RT_comp_epollev_'};
for i=1:3
    for j=1:3
        runs_mat=[];
        for k=1:2
            runs_mat(:,:,k) = csvread(strcat(prfx{j},sprintf('1mem_%dweb_run%d.csv',i,k)));
            web_epoll{i,j} = mean(runs_mat,3);
        end
    end
end
%%
wc=[800 900 1000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000 2100];
marks={'-','--','-.'};
cols=[0.7 0 0; 0 0 0.7;0 0.5 0];
for i=1:3
    figure; hold on;
    for j=2:2
        for k=1:3
            plot(wc,web_epoll{i,j}(:,k),marks{k},'Color',cols(k,:),'LineWidth',2)
        end
    end
    if i==1
%         legend('RR28_{select}','RR30_{select}','RR32_{select}','RR28_{epoll}','RR30_{epoll}','RR32_{epoll}','RR28_{epollev}','RR30_{epollev}','RR32_{epollev}','Orientation','Horizontal','Location','northoutside');
        legend('280 K ops/s','300 K ops/s','320 K ops/s','Orientation','Horizontal','Location','north');
    elseif i==2
        legend('RR36_{select}','RR39_{select}','RR42_{select}','RR36_{epoll}','RR39_{epoll}','RR42_{epoll}','RR36_{epollev}','RR39_{epollev}','RR42_{epollev}','Orientation','Horizontal','Location','northoutside');
    elseif i==3
        legend('RR38_{select}','RR44_{select}','RR50_{select}','RR38_{epoll}','RR44_{epoll}','RR50_{epoll}','RR38_{epollev}','RR44_{epollev}','RR50_{epollev}','Orientation','Horizontal','Location','northoutside');
    end
    set(gcf, 'Position', [100, 100, 700, 500]);
    set(gca,'fontsize', 12);
    %     ylim([0 100]);
%     fname=strcat('comp_3epoll_wc_1mem_',num2str(i),'web_2runs_avg.pdf');
    ylabel('Response time (ms)\rightarrow');
    xlabel('worker connections \rightarrow');
    export_fig('comp_wc_LB_epollLB_1mem_1web_2runsavg.pdf','-p0.02','-transparent')
    break;
end

%% comparing worker_connections on LB
suffix={'_httperf_wc500','_httperf_wc1000','_httperf_wc2000','_httperf_wc3000'};
conf_web{1,1}=compare_runs('laexp_1mem_1web',[1 0 0],[],2,'',suffix{1});
conf_web{1,2}=compare_runs('laexp_1mem_2web',[1 0 1],[],2,'',suffix{1});
conf_web{1,3}=compare_runs('laexp_1mem_3web',[1 1 1],[],2,'',suffix{1});
conf_web{2,1}=compare_runs('laexp_1mem_1web',[1 0 0],[],3,'',suffix{2});
conf_web{2,2}=compare_runs('laexp_1mem_2web',[1 0 1],[],3,'',suffix{2});
conf_web{2,3}=compare_runs('laexp_1mem_3web',[1 1 1],[],3,'',suffix{2});
conf_web{3,1}=compare_runs('laexp_1mem_1web',[1 0 0],[],2,'',suffix{3});
conf_web{3,2}=compare_runs('laexp_1mem_2web',[1 0 1],[],2,'',suffix{3});
conf_web{3,3}=compare_runs('laexp_1mem_3web',[1 1 1],[],2,'',suffix{3});
conf_web{4,1}=compare_runs('laexp_1mem_1web',[1 0 0],[],2,'',suffix{4});
conf_web{4,2}=compare_runs('laexp_1mem_2web',[1 0 1],[],2,'',suffix{4});
conf_web{4,3}=compare_runs('laexp_1mem_3web',[1 1 1],[],2,'',suffix{4});


%% comparing different setups
% prefx={'ng_','ne_'};
conf_web=cell(4,3);
suffix={'_httperf_apacheev','_httperf_apachelb','_httperf_nginxev','_httperf_nginxlb'};

conf_web{1,1}=compare_runs('laexp_3mem_1web',[1 0 0],[],3,'',suffix{1});
conf_web{1,2}=compare_runs('laexp_3mem_2web',[1 0 1],[],3,'',suffix{1});
conf_web{1,3}=compare_runs('laexp_3mem_3web',[1 1 1],[],3,'',suffix{1});
conf_web{2,1}=compare_runs('laexp_3mem_1web',[1 0 0],[],3,'',suffix{2});
conf_web{2,2}=compare_runs('laexp_3mem_2web',[1 0 1],[],3,'',suffix{2});
conf_web{2,3}=compare_runs('laexp_3mem_3web',[1 1 1],[],3,'',suffix{2});
conf_web{3,1}=compare_runs('laexp_3mem_1web',[1 0 0],[],3,'',suffix{3});
conf_web{3,2}=compare_runs('laexp_3mem_2web',[1 0 1],[],3,'',suffix{3});
conf_web{3,3}=compare_runs('laexp_3mem_3web',[1 1 1],[],3,'',suffix{3});
conf_web{4,1}=compare_runs('laexp_3mem_1web',[1 0 0],[],3,'',suffix{4});
conf_web{4,2}=compare_runs('laexp_3mem_2web',[1 0 1],[],3,'',suffix{4});
conf_web{4,3}=compare_runs('laexp_3mem_3web',[1 1 1],[],3,'',suffix{4});
close all;
%%
for i=1:4
    for j=1:3
        conf_web{i,j}(:,end)=conf_web{i,j}(:,end)./10;
    end
end
%%
marks={'-',':','--','-.'};
cols=[1 0 0; 0 0 1;0 0 0; 0 0.5 0];
x_ax=[100 350;200 400;200 450];
for j=1:3 % different web
    for k=1:2 % for LA and RT
        figure;hold on;
        min_x=5000;
        max_x=0;
        for i=1:4 % for different conf 3 different conf
            plot(conf_web{i,j}(:,end),conf_web{i,j}(:,k),marks{i},'Color',cols(i,:),'LineWidth',3)
            if max(conf_web{i,j}(:,end)) > max_x
                max_x=max(conf_web{i,j}(:,end));
            end
            if min(conf_web{i,j}(:,end)) < min_x
                min_x=min(conf_web{i,j}(:,end));
            end
        end
        if k==1
            legend('LA_{apacheEV}','LA_{apacheLB}','LA_{nginxEV}','LA_{nginxLB}','Orientation','Horizontal','Location','northwest');
            fname=strcat('comp_conf_la_3mem_',num2str(j),'web_avruns.pdf');
            figname=strcat('comp_conf_la_3mem_',num2str(j),'web_avruns.fig');
            ylim([0 50]);
            ylabel('Load-average \rightarrow');
        else
            legend('RT_{apacheEV}','RT_{apacheLB}','RT_{nginxEV}','RT_{nginxLB}','Orientation','Horizontal','Location','northwest');
            fname=strcat('comp_conf_rt_3mem_',num2str(j),'web_avruns.pdf');
            figname=strcat('comp_conf_rt_3mem_',num2str(j),'web_avruns.fig');
            ylim([0 100]);
            ylabel('Response time (ms)\rightarrow');
        end
        %         set(gcf, 'Position', [100, 100, 600, 400]);
        set(gca,'fontsize', 12);
%         xlim(x_ax(j,:));
        %         xlim([min_x-10 max_x+10]);
        xlabel('Throughput (Kilo Ops/sec) \rightarrow');
        savefig(figname);
        export_fig(fname,'-p0.02','-transparent')
    end
end


%%
mem_web=cell(3);
mem_web{1,1}=compare_runs('laexp_1mem_1web',[1 0 0],[],2);
mem_web{1,2}=compare_runs('laexp_1mem_2web',[1 0 1],[],2);
mem_web{1,3}=compare_runs('laexp_1mem_3web',[1 1 1],[],2);
mem_web{2,1}=compare_runs('laexp_2mem_1web',[1 0 0],[],2);
mem_web{2,2}=compare_runs('laexp_2mem_2web',[1 0 1],[],2);
mem_web{2,3}=compare_runs('laexp_2mem_3web',[1 1 1],[],2);
mem_web{3,1}=compare_runs('laexp_3mem_1web',[1 0 0]);
mem_web{3,2}=compare_runs('laexp_3mem_2web',[1 0 1]);
mem_web{3,3}=compare_runs('laexp_3mem_3web',[1 1 1]);
%%
mem_web=cell(3);
% apache lb
% selected_runs=[1,1,1;1,0,1;1,1,1;1,0,0;1,1,1;0,1,1;0,1,1;1,1,0;1,0,1];
% nginx lb
% selected_runs=[1 1 1;0 1 1;0 1 1;1 1 1;0 1 1;0 1 1;1 1 1;1 0 0;1 1 1];
% nginx everything
selected_runs=[1 1 0;1 1 0;0 1 0;1 1 0;1 1 0;0 1 0;1 1 0;1 1 1;0 1 0];
mem_web{1,1}=compare_runs('laexp_1mem_1web',[1 0 0],selected_runs(1,:),2);
mem_web{1,2}=compare_runs('laexp_1mem_2web',[1 0 1],selected_runs(2,:),2);
mem_web{1,3}=compare_runs('laexp_1mem_3web',[1 1 1],selected_runs(3,:),2);
mem_web{2,1}=compare_runs('laexp_2mem_1web',[1 0 0],selected_runs(4,:),2);
mem_web{2,2}=compare_runs('laexp_2mem_2web',[1 0 1],selected_runs(5,:),2);
mem_web{2,3}=compare_runs('laexp_2mem_3web',[1 1 1],selected_runs(6,:),2);
mem_web{3,1}=compare_runs('laexp_3mem_1web',[1 0 0],selected_runs(7,:));
mem_web{3,2}=compare_runs('laexp_3mem_2web',[1 0 1],selected_runs(8,:));
mem_web{3,3}=compare_runs('laexp_3mem_3web',[1 1 1],selected_runs(9,:));
close all;
%%
for i=1:3
    for j=1:3
        mem_web{i,j}(:,end)=mem_web{i,j}(:,end)./10;
    end
end

%%
marks={'-','--','-.'};
cols=[1 0 0; 0 0 1;0 0 0];
intens=0.5:0.25:1;
for i=1:3
    for k=1:2
        figure;hold on;
        min_x=5000;
        max_x=0;
        for j=1:3
            plot(mem_web{i,j}(:,end),mem_web{i,j}(:,k),marks{j},'Color',cols(j,:))
            if max(mem_web{i,j}(:,end)) > max_x
                max_x=max(mem_web{i,j}(:,end));
            end
            if min(mem_web{i,j}(:,end)) < min_x
                min_x=min(mem_web{i,j}(:,end));
            end
        end
        set(gcf, 'Position', [100, 100, 600, 400]);
        set(gca,'fontsize', 12);
        if k==1
            legend('LA_{1web}','LA_{2web}','LA_{3web}','Orientation','Horizontal','Location','northwest');
            fname=strcat('comp_la_',num2str(i),'mem_123web_avruns_si.pdf');
            ylim([0 50]);
            ylabel('Load-average \rightarrow');
        else
            legend('RT_{1web}','RT_{2web}','RT_{3web}','Orientation','Horizontal','Location','northwest');
            fname=strcat('comp_rt_',num2str(i),'mem_123web_avruns_si.pdf');
            ylim([0 10]);
            ylabel('Response time (ms)\rightarrow');
        end
        xlim([min_x-10 max_x+10]);
        xlabel('Throughput (Kilo Ops/sec) \rightarrow');
        export_fig(fname,'-p0.02','-transparent')
    end
end
%%
marks={'-','--','-.'};
cols=[1 0 0; 0 0 1;0 0 0];
x_ax=[100 350;200 400;200 450];
for i=1:3
    for k=1:2
        figure;hold on;
        for j=1:3
            plot(mem_web{j,i}(:,end),mem_web{j,i}(:,k),marks{j},'Color',cols(j,:));
        end
        set(gcf, 'Position', [100, 100, 600, 400]);
        set(gca,'fontsize', 16);
        if k==1
            legend('LA_{1mem}','LA_{2mem}','LA_{3mem}','Orientation','Horizontal','Location','northwest');
            fname=strcat('comp_la_123mem_',num2str(i),'web_avruns_si.pdf');
            ylim([0 50]);
            ylabel('Load-average \rightarrow');
        else
            legend('RT_{1mem}','RT_{2mem}','RT_{3mem}','Orientation','Horizontal','Location','northwest');
            fname=strcat('comp_rt_123mem_',num2str(i),'web_avruns_si.pdf');
            ylim([0 10]);
            ylabel('Response time (ms)\rightarrow');
        end
        %         xlim([min(mem_web{j,i}(:,end))-10 max(mem_web{j,i}(:,end))+10]);
        xlim(x_ax(i,:));
        xlabel('Throughput (Kilo Ops/sec) \rightarrow');
        export_fig(fname,'-p0.02','-transparent')
    end
    %     title(strcat(num2str(i),' Web, varying Mem averaged and cleaned runs'));
end

%% re-run comparison
old_new=[oldruns;runmw300;reruns];
% mem_web;
marks={'-','--','-.'};
cols=[1 0 0; 0 0 1;0 0 0];
for j=1:3 % different web
    figure;hold on;
    for k=1:2 % for LA and RT
        min_x=5000;
        max_x=0;
        for i=1:3 % for different fpm conf 2 different conf
            plot(old_new{i,j}(:,end),old_new{i,j}(:,k),marks{k},'Color',cols(i,:))
            if max(old_new{i,j}(:,end)) > max_x
                max_x=max(old_new{i,j}(:,end));
            end
            if min(old_new{i,j}(:,end)) < min_x
                min_x=min(old_new{i,j}(:,end));
            end
        end
    end
    set(gcf, 'Position', [100, 100, 600, 400]);
    set(gca,'fontsize', 12);
    legend('LA_{mw=500}','LA_{mw=300}','LA_{mw=200}','RT_{mw=500}','RT_{mw=300}','RT_{mw=200}','Orientation','Vertical','Location','northwest');
    fname=strcat('comp_conf_1mem_',num2str(j),'web_avruns.pdf');
    ylabel('Load Average / Response time (ms)\rightarrow');
    xlim([min_x-10 max_x+10]);
    ylim([0 50]);
    xlabel('Throughput (Kilo Ops/sec) \rightarrow');
    export_fig(fname,'-p0.02','-transparent')
end
