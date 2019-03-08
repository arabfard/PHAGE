function [FeatureMatrix, trueLabels] =  Prepare_Data(featureMatrix, positiveSet, mixedSet, allLabels)
numberOfFeatures = size(featureMatrix, 2);
% the number of columns is the number of features.

numberOfEntries = length(positiveSet) + length(mixedSet);

FeatureMatrix = zeros(numberOfEntries, numberOfFeatures);
trueLabels = zeros(numberOfEntries,1);

% we will label positives with 1, unlabeled with 0. Take care with NB
% classifier, will change their indexes by +1. 

FeatureMatrix(1:length(positiveSet), :) = featureMatrix( positiveSet, :);
% this will put the features of the positive set in the first
% length(positiveSet) rows of the new feature matrix.

trueLabels(1:length(positiveSet),1) = 1;
% The positive sample is definitely positive - left to find positives in MS

FeatureMatrix( (length(positiveSet)+1) : ( length(positiveSet) + length(mixedSet) ), : ) = featureMatrix(mixedSet, :);

trueLabels( (length(positiveSet)+1) : ( length(positiveSet) + length(mixedSet) )) = allLabels(mixedSet);
% what's left is to relabel all those that are not 1 into 0

% we need to binarize the feature matrix - data sets like reuters have
% labels different from 0/1 - so map all non-zeros to 1!
% To do this, we can reuse the binarizePosteriors method:
% This should be done in data pre-processing- too slow to do here!


for i = 1:length(trueLabels)
    if(trueLabels(i)~=1)
        trueLabels(i)=-1;
    end
end
    
