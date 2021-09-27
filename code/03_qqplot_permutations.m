% ================================================================================
% == Run permutations to calculate expected p-values under the null hypothesis ===
% ================================================================================

% set working directory
cd /users/philippe/desktop/projects/bigv_arousal

% add path with function pncovs
addpath code/functions/

% load files
load('code/derivatives/02_bigv_arousal_results.mat', 'NEO', 'eeg', 'bigv', 'covs', 'facets', 'p_obs', 'rho_obs', 'FDR_obs', 'p_obs_facets', 'rho_obs_facets', 'FDR_obs_facets');

% create vector for permutation
npermutations = 1000000;
rng(68882,'twister')

u = zeros(size(eeg.res,1), npermutations);
for i = 1:npermutations
    u(:,i) = randperm(size(u,1));
end

% speed up Spearman correlations by ranking variables before loop
for i = 1:size(bigv.data,2)
    bigv.datarnk(:,i) = tiedrank(bigv.data(:,i));
end

for i = 1:size(eeg.data,2)
    eeg.datarnk(:,i) = tiedrank(eeg.data(:,i));
end

% test whether Spearman correlations equal Pearson correlations after rank-transformation
% - they do!
[rho_Spear, p_Spear] = corr(eeg.data, bigv.data, 'rows', 'pairwise', 'type', 'Spearman');
[rho_Pears, p_Pears] = corr(eeg.datarnk, bigv.datarnk, 'rows', 'pairwise', 'type', 'Pearson');
isequal(round(rho_Spear,12),round(rho_Pears,12)) % should be 1
isequal(round(p_Spear,12),round(p_Pears,12)) % should be 1
    
% run correlations after data permutation 
p_exp_full = zeros(size(eeg.data,2), size(bigv.data,2), npermutations);
p_exp_partial = zeros(size(eeg.res,2), size(bigv.res,2), npermutations);

tic
parfor i = 1:size(u,2)
    [~, temp] = corr(eeg.datarnk(u(:,i),:), bigv.datarnk, 'rows', 'pairwise', 'type', 'Pearson');
    p_exp_full(:,:,i) = temp;
    
    [temp, ~] = corr(eeg.res(u(:,i),:), bigv.res(:,1:5), 'rows', 'pairwise', 'type', 'Pearson');
    p_exp_partial(:,:,i) = pncovs(temp,size(bigv.datarnk,1),size(covs.data,2));
end
toc 

% put into one structure
p_exp = struct();
p_exp.full = p_exp_full;
p_exp.partial = p_exp_partial;

% save expected and observed p-values
save('code/derivatives/03_permutations_bigv.mat', '-v7.3', 'NEO', 'eeg', 'bigv', 'covs', 'p_exp', 'p_obs', 'u');

%% Data Permutation - Facets
clear all

% load files
load('code/derivatives/02_bigv_arousal_results.mat', 'NEO', 'eeg', 'bigv', 'covs', 'facets', 'p_obs', 'rho_obs', 'FDR_obs', 'p_obs_facets', 'rho_obs_facets', 'FDR_obs_facets');

% create vector for permutation
npermutations = 1000000;
rng(68882,'twister')

u = zeros(size(eeg.res,1), npermutations);
for i = 1:npermutations
    u(:,i) = randperm(size(u,1));
end

% speed up Spearman correlations by ranking variables before loop
for i = 1:size(facets.data,2)
    facets.datarnk(:,i) = tiedrank(facets.data(:,i));
end

for i = 1:size(eeg.data,2)
    eeg.datarnk(:,i) = tiedrank(eeg.data(:,i));
end

% test whether Spearman correlations equal Pearson correlations after
% rank-transformation
[rho_Spear, p_Spear] = corr(eeg.data, facets.data, 'rows', 'pairwise', 'type', 'Spearman');
[rho_Pears, p_Pears] = corr(eeg.datarnk, facets.datarnk, 'rows', 'pairwise', 'type', 'Pearson');
isequal(round(rho_Spear,12),round(rho_Pears,12)) % should be 1
isequal(round(p_Spear,12),round(p_Pears,12)) % should be 1
    
% run correlations after data permutation 
p_exp_full = zeros(size(eeg.data,2), size(facets.data,2), npermutations);
p_exp_partial = zeros(size(eeg.res,2), size(facets.res,2), npermutations);

tic
parfor i = 1:size(u,2)
    [~, temp] = corr(eeg.datarnk(u(:,i),:), facets.datarnk, 'rows', 'pairwise', 'type', 'Pearson');
    p_exp_full(:,:,i) = temp;
    
    [temp, ~] = corr(eeg.res(u(:,i),:), facets.res, 'rows', 'pairwise', 'type', 'Pearson');
    p_exp_partial(:,:,i) = pncovs(temp,size(facets.datarnk,1),size(covs.data,2));
end
toc 

% put into one structure
p_exp_facets = struct();
p_exp_facets.full = p_exp_full;
p_exp_facets.partial = p_exp_partial;

% save expected and observed p-values
save('code/derivatives/03_permutations_facets.mat', '-v7.3', 'NEO', 'eeg', 'facets', 'covs', 'p_exp_facets', 'p_obs_facets');
            