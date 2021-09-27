% ===============================
% == Run frequentist analyses ===
% ===============================

% set working directory
cd /Users/philippe/desktop/projects/bigv_arousal

% add path with function pncovs
addpath code/functions/

% importdata (synthetic dataset at 'synthetic/01_bigv_arousal_synthetic.txt')
NEO = importdata('code/derivatives/01_bigv_arousal.txt');
NEO.IID = NEO.textdata(2:end,1);
NEO.varnames = NEO.textdata(1,3:end)';
NEO = rmfield(NEO,'textdata');

% get covariates
covs = struct();
covs.data = NEO.data(:,1:3);
covs.varnames = NEO.varnames(1:3,1);

% get NEO scores
bigv = struct();
bigv.data = NEO.data(:,8:12);
bigv.varnames = NEO.varnames(8:12,1);

% get NEO facets
facets = struct();
facets.data = NEO.data(:,13:42);
facets.varnames = NEO.varnames(13:42,1);

% get CNS arousal variables
eeg = struct();
eeg.data = NEO.data(:,5:7);
eeg.varnames = NEO.varnames(5:7,1);

%% calculate intercorrelations between NEO variables
[rho,p] = corr(bigv.data,'Type','Spearman');

% Conbach's alpha at main diagonal (calculated using SPSS)
v = [ 0.906 0.899 0.868 0.836 0.881 ];  
rho = rho - diag(diag(rho)) + diag(v);

% set p = -1 at main diagonal
p = p - diag(diag(p)) + diag(repelem(-1,5));

% output table intercorrelations_bigv_T.txt
table = array2table([rho, p], 'VariableNames', [{'NEO_N_T_rho'}  {'NEO_E_T_rho'} {'NEO_O_T_rho'} {'NEO_A_T_rho'} {'NEO_C_T_rho'} {'NEO_N_T_p'} {'NEO_E_T_p'} {'NEO_O_T_p'} {'NEO_A_T_p'} {'NEO_C_T_p'}], 'RowNames', bigv.varnames(1:5,1));
writetable(table, strcat('code/tables/intercorr_bigv.txt'), 'Delimiter', '\t', 'WriteRowNames', 1)

%% calculate intercorrelations between NEO facets
[rho,p] = corr(facets.data,'Type','Spearman');

% Conbach' alpha at main diagonal (calculated using SPSS)
v = [ 0.803 0.697 0.773 0.668 0.529 0.735 ...
      0.722 0.745 0.826 0.660 0.577 0.796 ...
      0.682 0.756 0.702 0.601 0.740 0.458 ...
      0.682 0.539 0.681 0.548 0.700 0.485 ...
      0.685 0.585 0.614 0.637 0.710 0.681] ;
rho = rho - diag(diag(rho)) + diag(v);

% set p = -1 at main diagonal
p = p - diag(diag(p)) + diag(repelem(-1,30));

% output table intercorr_facets.txt
varnames = [split(join([facets.varnames;facets.varnames(end,1)], '_rho '), ' '); split(join([facets.varnames;facets.varnames(end,1)], '_p '), ' ')];
varnames([31 62]) = [];
table = array2table([rho, p], 'VariableNames', varnames, 'RowNames', facets.varnames);
writetable(table, 'code/tables/intercorr_facets.txt', 'Delimiter', '\t', 'WriteRowNames', 1)

%% calculate intercorrelations between EEG-vigilance variables
[rho,p] = corr(eeg.data,'Type','Spearman');

% set p = -1 at main diagonal
p = p - diag(diag(p)) + diag(repelem(-1,3));

% output table intercorr_eeg_T.txt
varnames = [{'Mean_rho'} {'Stability_rho'} {'Slope_rho'} {'Mean_p'} {'Stability_p'} {'Slope_p'}];
table = array2table([rho, p], 'VariableNames', varnames, 'RowNames', eeg.varnames);
writetable(table, 'code/tables/intercorr_eeg.txt', 'Delimiter', '\t', 'WriteRowNames', 1)

%% calculate correlations of covariates with NEO personality and EEG-vigilance variables
[rho,p] = corr([eeg.data bigv.data facets.data], covs.data,'Type','Spearman');

% output table intercorr_eeg_T.txt
varnames = [{'sex_rho'} {'age_rho'} {'daytime_rho'} {'sex_p'} {'age_p'} {'daytime_p'}];
table = array2table([rho, p], 'VariableNames', varnames, 'RowNames', [eeg.varnames; bigv.varnames; facets.varnames]);
writetable(table, 'code/tables/results_covs.txt', 'Delimiter', '\t', 'WriteRowNames', 1)

%% Calculate correlations and prepare data for permutation-based qq-plots (get residuals)

% adjust eeg by sex, age, and time (ranked variables resamble Spearman)
eeg.res = zeros(size(eeg.data));
for i = 1:size(eeg.data,2)
    model = fitlm(tiedrank(covs.data), tiedrank(eeg.data(:,i)));
    eeg.res(:,i) = model.Residuals{:,1};
end

% adjust bigv by sex, age, and time (ranked variables resamble Spearman)
bigv.res = zeros(size(bigv.data));
for i = 1:size(bigv.data,2)
    model = fitlm(tiedrank(covs.data), tiedrank(bigv.data(:,i)));
    bigv.res(:,i) = model.Residuals{:,1};
end

% adjust facets by sex, age, and time (ranked variables resamble Spearman)
facets.res = zeros(size(facets.data));
for i = 1:size(facets.data,2)
    model = fitlm(tiedrank(facets.data), tiedrank(facets.data(:,i)));
    facets.res(:,i) = model.Residuals{:,1};
end

% calculate correlations
[rho_obs_full,p_obs_full] = corr(eeg.data, bigv.data,'Type','Spearman');
[rho_obs_partial,p_obs_partial] = partialcorr(eeg.data, bigv.data, covs.data, 'rows', 'pairwise', 'type', 'Spearman');

% test whether Pearson correlations of residualized variables correspond to
% partial Spearman correlations - they do.
[rho_obs_res, ~] = corr(eeg.res, bigv.res, 'rows', 'pairwise', 'type', 'Pearson');
p_obs_res = pncovs(rho_obs_res,size(eeg.res,1),size(covs.data,2));
isequal(round(rho_obs_partial,12),round(rho_obs_res,12)) % should be 1
isequal(round(p_obs_partial,12),round(p_obs_res,12)) % should be 1

% FDR-correction
FDR_obs_full = reshape(mafdr(p_obs_full(:), 'BHFDR', 1), size(p_obs_full,1), size(p_obs_full,2));
FDR_obs_partial = reshape(mafdr(p_obs_partial(:), 'BHFDR', 1), size(p_obs_partial,1), size(p_obs_partial,2));

% how many correlations are nominally and FDR-significant?
% 6 (zero-order) and 3 (partial) show nominal significance 
% 3 (zero-order) and 1 (partial) show FDR significance
[sum(p_obs_full(:)<0.05) sum(p_obs_partial(:)<0.05);...
 sum(FDR_obs_full(:)<0.05) sum(FDR_obs_partial(:)<0.05)]

% put into structure
p_obs = struct();
p_obs.full = p_obs_full;
p_obs.partial = p_obs_partial;

FDR_obs = struct();
FDR_obs.full = FDR_obs_full;
FDR_obs.partial = FDR_obs_partial;

rho_obs = struct();
rho_obs.full = rho_obs_full;
rho_obs.partial = rho_obs_partial;

%% Create result output for NEO personality traits

% results_bigv_full.txt
table = array2table([rho_obs.full' p_obs.full' FDR_obs.full'], 'VariableNames', [{'rho_Mean'}, {'rho_Stability'}, {'rho_Slope'}, {'p_Mean'}, {'p_Stability'}, {'p_Slope'}, {'FDR_Mean'}, {'FDR_Stability'}, {'FDR_Slope'}], 'RowNames', bigv.varnames(1:5,1));
writetable(table, 'code/tables/results_bigv_full.txt', 'Delimiter', '\t', 'WriteRowNames', 1)% results_bigv_T.txt

% results_bigv_partial.txt
table = array2table([rho_obs.partial' p_obs.partial' FDR_obs.partial'], 'VariableNames', [{'rho_Mean'}, {'rho_Stability'}, {'rho_Slope'}, {'p_Mean'}, {'p_Stability'}, {'p_Slope'}, {'FDR_Mean'}, {'FDR_Stability'}, {'FDR_Slope'}], 'RowNames', bigv.varnames(1:5,1));
writetable(table, 'code/tables/results_bigv_partial.txt', 'Delimiter', '\t', 'WriteRowNames', 1)

%% Create result output for NEO personality facets (30 T-Scores)

% calculate correlations
[rho_obs_full,p_obs_full] = corr(eeg.data, facets.data,'Type','Spearman');
[rho_obs_partial,p_obs_partial] = partialcorr(eeg.data, facets.data, covs.data, 'rows', 'pairwise', 'type', 'Spearman');

% FDR-correction
FDR_obs_full = reshape(mafdr(p_obs_full(:), 'BHFDR', 1), size(p_obs_full,1), size(p_obs_full,2));
FDR_obs_partial = reshape(mafdr(p_obs_partial(:), 'BHFDR', 1), size(p_obs_partial,1), size(p_obs_partial,2));

% put into structure
p_obs_facets = struct();
p_obs_facets.full = p_obs_full;
p_obs_facets.partial = p_obs_partial;

FDR_obs_facets = struct();
FDR_obs_facets.full = FDR_obs_full;
FDR_obs_facets.partial = FDR_obs_partial;

rho_obs_facets = struct();
rho_obs_facets.full = rho_obs_full;
rho_obs_facets.partial = rho_obs_partial;

% results_facets_full.txt
table = array2table([rho_obs_facets.full' p_obs_facets.full' FDR_obs_facets.full'], 'VariableNames', [{'rho_Mean'}, {'rho_Stability'}, {'rho_Slope'}, {'p_Mean'}, {'p_Stability'}, {'p_Slope'}, {'FDR_Mean'}, {'FDR_Stability'}, {'FDR_Slope'}], 'RowNames', facets.varnames);
writetable(table, 'code/tables/results_facets_full.txt', 'Delimiter', '\t', 'WriteRowNames', 1)% results_bigv_T.txt

% results_facets_partial.txt
table = array2table([rho_obs_facets.partial' p_obs_facets.partial' FDR_obs_facets.partial'], 'VariableNames', [{'rho_Mean'}, {'rho_Stability'}, {'rho_Slope'}, {'p_Mean'}, {'p_Stability'}, {'p_Slope'}, {'FDR_Mean'}, {'FDR_Stability'}, {'FDR_Slope'}], 'RowNames', facets.varnames);
writetable(table, 'code/tables/results_facets_partial.txt', 'Delimiter', '\t', 'WriteRowNames', 1)

%% save variables in .mat file
save('code/derivatives/02_bigv_arousal_results.mat', 'NEO', 'eeg', 'bigv', 'covs', 'facets', 'p_obs', 'rho_obs', 'FDR_obs', 'p_obs_facets', 'rho_obs_facets', 'FDR_obs_facets');
