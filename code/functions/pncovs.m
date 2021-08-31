function p = pncovs(rho, n, ncovs)

%PNCOVS(rho,n,ncovs) turns back the two-tailed probability for Pearson's
%linear correlation.
%
%       rho     - vector or matrix of correlation coefficients
%       n       - number of observations
%       ncovs   - number of covariates used to derive residualized
%                 variables
%  
%This function is supposed to be used on correlations coefficients that have
%been derived from Spearman / Pearson correlations between residualized
%variables. The function allows to specify the number of covariates that have
%been used to derive residuals. Degrees of freedom are adjusted accordingly.
%The resulting p-values correspond to those of partial correlations.
%This might be helpful in scenarios that involve permutation testing.

t = rho.*sqrt((n-2-ncovs)./(1-rho.^2)); % +/- Inf where rho == 1
p = 2*tcdf(-abs(t),n-2-ncovs);
end
