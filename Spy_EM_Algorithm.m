function [finalClass,EM_NBClassifier,P,U,N,iterationCount] = Spy_EM_Algorithm(FeatureMatrix,Temp_labels,negativeThreshold)

PositiveSet=find(Temp_labels==1);% P index
MixedSet=find(Temp_labels==0);% U index
if( nargin < 3)
    negativeThreshold = 0.15;
end

% We want to return the labels of the unlabeled cases, once the iterations
% of creating the Naive Bayesian classifiers have converged. Or the
% posterior probabilities (maybe binarized) of the final classifier

% Positive set contains the array indices of positive elements in the Feature Vector
% MixedSet represents array indices of unlabeled elements
% We are implicitly assuming that P and MS cover all rows of FeatureMatrix

numPositives = length(PositiveSet);

permutationOfPositives = randperm(numPositives);

setPositives(1:numPositives) = PositiveSet(permutationOfPositives);

%s = 10% is used for the spy set.
reducedPositives = setPositives(1:round(numPositives*9/10));
spyPositives = setPositives( (round(numPositives*9/10)+1):numPositives);
mixedSet = zeros(1, length(spyPositives) + length(MixedSet) );
mixedSet(1:length(MixedSet)) = MixedSet;
mixedSet((length(MixedSet)+1):length(mixedSet) ) = spyPositives;
% mixedSet contains all of the mixed set + 10% of positives at the end
numberOfSpies = length(spyPositives);
% this is the number of elements included as spies at the end of (new) mixedSet

reorderedFeatureMatrix(1:length(reducedPositives), :) = FeatureMatrix(reducedPositives, :);
reorderedFeatureMatrix( length(reducedPositives)+1 : (length(reducedPositives) + length(mixedSet)), :) = FeatureMatrix(mixedSet, :);

initialEMLabels =Initial_EM_spy(reorderedFeatureMatrix, 1:length(reducedPositives), length(reducedPositives)+1: (length(reducedPositives) + length(mixedSet)));
% probability <= t, into the Reliable Negative set, and restore the
% original positive set - we can just use the old one, PositiveSet

initialEMLabels = initialEMLabels( (1+length(reducedPositives)) : (length(initialEMLabels) - numberOfSpies),1);
% ReducedPositives and Spypositives are at the beggining and at the end of 
% initialEMLabels, and there are numberOfSpies of them!! Therefore, we just 
% need to "truncate" this array to obtain the middle - which is mixedSet!

[valuesPosterior, valuesIndices] = sort(initialEMLabels);
% we sort by posterior probabilities so that we can easily identify the
% likely negatives set! No need for binary search

bound = length(valuesPosterior);

for i=1:length(valuesPosterior)
    if(valuesPosterior(i)>=negativeThreshold)
        bound = i - 1;
        break;
    end
end
negativeSet = MixedSet(sort(valuesIndices(1:bound)));
unlabeledSet = MixedSet(sort(valuesIndices((bound+1):(length(valuesIndices)))));


% the third set we need is the Positive Set - we can use the original one!

positiveSet = PositiveSet;
% just to achieve naming uniformity

P = positiveSet;
U = unlabeledSet;
N = negativeSet;


newLabels = zeros(1, length(positiveSet)+length(negativeSet)+length(unlabeledSet));
newLabels(1:length(positiveSet)) = 1;
% newLabels are the labels prepared for the new NB classifier, at first
% longer to survive prepareData which needs it to be of same lenght as FeatureMatrix

clear reorderedFeatureMatrix;

[reorderedFeatureMatrix, newLabels] = Prepare_Data(FeatureMatrix, positiveSet, negativeSet, newLabels);

% obtain the feature matrix just for P and N, get newLabel to resize to get
% rid of its elements from unusedSet.

PN_NBClassifier = fitcnb(reorderedFeatureMatrix, newLabels);
%train the classifier using only P and N

[~,posteriors] = predict(PN_NBClassifier,reorderedFeatureMatrix);
% Now, we need to classify all elements of U, N according to the new
% classifier, and then run the EM algorithm, fixing posteriors of P to 1.


labelsEM = zeros(1, length(positiveSet)+length(negativeSet)+length(unlabeledSet));
% this will be the list of labels for our EM algorithm

labelsEM(positiveSet) = 1;
% the elements in the positiveSet are fixed to have posterior probability 1

if(~isempty(negativeSet) )% if the negative set is NOT empty:
    labelsEM(negativeSet) = Posteriors_to_label(posteriors( length(positiveSet)+1:length(positiveSet)+length(negativeSet) ,1));
end

% the negative ones are free to be relabeled, as will be those from U
[~,posteriorsU ]= predict(PN_NBClassifier,FeatureMatrix(unlabeledSet, :));

if(size(posteriorsU, 2) < 2) % in case empty or fully determined
    finalClass = labelsEM; % if determined, U is all 0
    %disp('massive bug2')
    
    return;
end   
labelsEM(unlabeledSet) = Posteriors_to_label ( posteriorsU(:,1));
% Now, all that's left is to run EM until it converges: retrain NB given
% these labels, obtain posteriors, binarize, reset P to 1, repeat.

oldLabels = zeros(size(labelsEM));

numIterations = 0;
% TODO: have this as a return parameter.

while ( not(isequal(oldLabels, labelsEM)))

    if(numIterations > 30) % this is probably close to converging within 2,3 iterations, let alone 20, no need to continue
%         str = ['Cut SEM optimization after 30 iterations - the number of different labels is:', num2str(sum(abs(oldLabels - labelsEM)))];
%         disp(str)
        break;
    end
    
    EM_NBClassifier = fitcnb(FeatureMatrix, labelsEM);
    
    [finalClass_itr,posteriorProbabilities] = predict(EM_NBClassifier,FeatureMatrix);
    
    oldLabels = labelsEM;
    
    labelsEM = Posteriors_to_label(posteriorProbabilities(:,1));
    
    labelsEM(positiveSet) = 1;
    % make sure to keep these fixed to 1.
        
    numIterations = numIterations + 1;
    
    % The next two lines, and the realLabels that might be passed in as
    % argument, can be used to track how subsequent classifiers improve the
    % estimation metrics! will only write this if we pass these as argument
    
end
iterationCount = numIterations;
finalClass = finalClass_itr;
finalClass(positiveSet) = 1;
end

