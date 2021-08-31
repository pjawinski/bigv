% ==================================================================================
% == Big Five personality traits and brain arousal in the resting state: QQ-plot ===
% ==================================================================================

% set working directory
cd /Users/philippe/desktop/projects/bigv_arousal

% load data
load('code/derivatives/03_permutations_bigv.mat', 'p_exp', 'p_obs');
load('code/derivatives/03_permutations_facets.mat', 'p_exp_facets', 'p_obs_facets');

% get number of permutations
npermutations = size(p_exp.full,3);

% put observed p values into one variable
struct_p_obs = p_obs;
struct_p_obs_facets = p_obs_facets;
p_obs = [struct_p_obs.full(:) struct_p_obs.partial(:)];
p_obs_facets = [struct_p_obs_facets.full(:) struct_p_obs_facets.partial(:)];

% put expected p values into one variable
struct_p_exp = p_exp;
p_exp = zeros(15,npermutations,2);
p_exp(:,:,1) = reshape(struct_p_exp.full,15,npermutations);
p_exp(:,:,2) = reshape(struct_p_exp.partial,15,npermutations);

struct_p_exp_facets = p_exp_facets;
p_exp_facets = zeros(90,npermutations,2);
p_exp_facets(:,:,1) = reshape(struct_p_exp_facets.full,90,npermutations);
p_exp_facets(:,:,2) = reshape(struct_p_exp_facets.partial,90,npermutations);

% draw plot
ttl = {'Big Five', 'Facets'};
txt = {'a', 'b'};
label = {'full', 'partial'};

for j = 1:2
    
qq_figure(j) = figure(); hold on;
    
    subplot(1,7,[1 2]); hold on;

        RND_Vector_p = sort(p_exp(:,:,j), 'descend');
        RND_Vector_Z = norminv(RND_Vector_p/2);
        Konf95 = zeros(size(RND_Vector_p,1),1);
        Konf05 = zeros(size(RND_Vector_p,1),1);
        Median = zeros(size(RND_Vector_p,1),1);
        Mean = zeros(size(RND_Vector_p,1),1);

        for i=1:size(RND_Vector_p,1)
            Konf95(i,1) = -log10(min(maxk(RND_Vector_p(i,:),size(RND_Vector_p,2)/20)));
            Konf05(i,1) = -log10(max(mink(RND_Vector_p(i,:),size(RND_Vector_p,2)/20)));
            Median(i,1) = -log10(median(RND_Vector_p(i,:)));
            Mean(i,1) = -log10(2*normcdf(mean(RND_Vector_Z(i,:))));    
        end

        x = Mean;
        x2 = [x;flipud(x)];

        set(0,'DefaultTextFontname', 'CMU Serif');
        set(0,'defaulttextinterpreter','latex')
        set(gca,'TickLabelInterpreter', 'latex');

        inBetween = [Konf05;flipud(Konf95)];
        a = fill(x2, inBetween, [211,211,211]/255);
        set(a,'EdgeColor','none','facealpha',0.5);
        plot(Mean,-log10(sort(p_obs(:,j),'descend')),'o','Color',[0, 0.4470, 0.7410],'Markersize',2,'LineWidth',1)
        plot(Mean,Mean,'k-');

        ax = gca;
        ax.XAxis.FontSize = 8;
        ax.YAxis.FontSize = 8;
        ax.TickLabelInterpreter='latex';

        ylim([0 4]); xlim([0 1.2]);
        xlabel(sprintf('expected p-value ($-log_{10}$ scale)'),'fontsize',10,'Interpreter','latex');
        ylabel(sprintf('observed p-value ($-log_{10}$ scale)'),'fontsize',10,'Interpreter','latex');

        xticks(0:1:1);
        xticklabels(0:1:1);
        ytickformat('%.0f');
        yticks(1:1:4);
        yticklabels(1:1:4);

        text(-0.7,4.2,txt{1},'Fontsize', 18, 'HorizontalAlignment', 'left', 'FontWeight', 'bold');
        title(ttl{1,1}, 'Fontsize', 10);

        
    subplot(1,7,[5:7]); hold on;

        RND_Vector_p = sort(p_exp_facets(:,:,j), 'descend');
        RND_Vector_Z = norminv(RND_Vector_p/2);
        Konf95 = zeros(size(RND_Vector_p,1),1);
        Konf05 = zeros(size(RND_Vector_p,1),1);
        Median = zeros(size(RND_Vector_p,1),1);
        Mean = zeros(size(RND_Vector_p,1),1);

        for i=1:size(RND_Vector_p,1)
            Konf95(i,1) = -log10(min(maxk(RND_Vector_p(i,:),size(RND_Vector_p,2)/20)));
            Konf05(i,1) = -log10(max(mink(RND_Vector_p(i,:),size(RND_Vector_p,2)/20)));
            Median(i,1) = -log10(median(RND_Vector_p(i,:)));
            Mean(i,1) = -log10(2*normcdf(mean(RND_Vector_Z(i,:))));    
        end

        x = Mean;
        x2 = [x;flipud(x)];

        set(0,'DefaultTextFontname', 'CMU Serif');
        set(0,'defaulttextinterpreter','latex')
        set(gca,'TickLabelInterpreter', 'latex');

        inBetween = [Konf05;flipud(Konf95)];
        a = fill(x2, inBetween, [211,211,211]/255);
        set(a,'EdgeColor','none','facealpha',0.5);
        plot(Mean,-log10(sort(p_obs_facets(:,j),'descend')),'o','Color',[0, 0.4470, 0.7410],'Markersize',2,'LineWidth',1)
        plot(Mean,Mean,'k-');

        ax = gca;
        ax.XAxis.FontSize = 8;
        ax.YAxis.FontSize = 8;
        ax.TickLabelInterpreter='latex';

        ylim([0 4]); xlim([0 2]);
        xlabel(sprintf('expected p-value ($-log_{10}$ scale)'),'fontsize',10,'Interpreter','latex');
        ylabel(sprintf('observed p-value ($-log_{10}$ scale)'),'fontsize',10,'Interpreter','latex');

        xticks(0:1:2);
        xticklabels(0:1:2);
        ytickformat('%.0f');
        yticks(1:1:4);
        yticklabels(1:1:4);

        text(-0.7,4.2,txt{2},'Fontsize', 18, 'HorizontalAlignment', 'left', 'FontWeight', 'bold');
        title(ttl{1,2}, 'Fontsize', 10);
        
% print
set(qq_figure(j),'PaperUnits', 'centimeters');
set(qq_figure(j),'PaperPosition', [4 18 12 8]);
print(strcat('code/figures/qqplot_', string(label{j}), '.pdf'),'-dpdf')
print(strcat('code/figures/qqplot_', string(label{j}),'.png'),'-dpng', '-r300')
end


%% Big Five: Get some permutation-based statistics
clear all

% load data
load('code/derivatives/03_permutations_bigv.mat');
npermutations = size(p_exp.full,3);

% Big Five x EEG-vigilance: how many observed p-values below 0.05?
% - count: 6
count = sum(p_obs.full(:) < 0.05)

% What is the percentage of permutation-based datasets with at least 6
% p-values below 0.05
% - 1.1%
sum((sum(reshape(p_exp.full,15,npermutations) < 0.05)>=count)')/npermutations

% Big Five x EEG-vigilance: What is the strongest observed p-value?
% - p = 2E-4
plowest = min(p_obs.full(:))

% What is the percentage of permutation-based datasets with at least one
% p-value below plowest (2E-4)
% - 0.2%
sum(sum(reshape(p_exp.full,15,npermutations) < plowest)>=1)/npermutations

% Big Five x EEG-vigilance (partial correlations): What is the strongest 
% observed p-value?
% - p = 0.001
plowest = min(p_obs.partial(:))

% What is the percentage of permutation-based datasets (partial correlations)
% with at least one p-value below plowest (0.001)
% - 1.1 %
sum(sum(reshape(p_exp.partial,15,npermutations) < plowest)>=1)/npermutations
