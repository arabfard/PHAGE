function [positiveCentroid, negativeCentroid] = calc_Centroids(FeatureMatrix, PositiveSet, MixedSet, alpha, beta)
if( nargin < 4) 
    alpha = 16; beta = 4; 
end

numPositives = length(PositiveSet);
numUnlabeled = length(MixedSet);
PositiveFeatures = FeatureMatrix(PositiveSet, :);
UnlabeledFeatures = FeatureMatrix(MixedSet, :);
positiveNorms = sqrt(sum(PositiveFeatures.^2,2));
unlabeledNorms = sqrt(sum(UnlabeledFeatures.^2,2));

PositiveFeatures =  PositiveFeatures ./ positiveNorms;%repmat(positiveNorms,1,size(PositiveFeatures,2));


UnlabeledFeatures =  UnlabeledFeatures ./ unlabeledNorms;%repmat(unlabeledNorms,1,size(UnlabeledFeatures,2));

positiveFactor =  sum(PositiveFeatures) ./ numPositives;
unlabeledFactor = sum(UnlabeledFeatures) ./ numUnlabeled;

positiveCentroid = (alpha .* positiveFactor - beta .* unlabeledFactor);
negativeCentroid = (alpha .* unlabeledFactor - beta .* positiveFactor);