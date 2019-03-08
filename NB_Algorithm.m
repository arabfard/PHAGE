function [finalClass, iterations,prior,NBClassifier] = NB_Algorithm(FeatureMatrix,Temp_labels)

% We want to return the posterior probabiliteies of labels of the unlabeled cases, 
% once the iterations of creating the Naive Bayesian classifiers have converged.

% Positive set contains the array indices of positive elements in the Feature Vector

% MixedSet represents array indices of unlabeled elements
% This method returns the posteriorProbabilities of the final classifier.

% First, we build the initial Naive Bayesian classifier, by labeling
% Positive elements as 1, and the negative ones as -1:

% In input data we set label 1 for Positive (PositiveSet) and 0 for Unlabel (MixedSet)
% NB: We are always handling indexes of PositiveSet, MixedSet - no need for
% these to be contiguous, but they do cover all of the feature matrix rows
% between them...
PositiveSet=find(Temp_labels==1);% P
MixedSet=find(Temp_labels==0);% U
labelCount = (length(PositiveSet)+length(MixedSet));
% the total number of labels

initialLabels = zeros(labelCount,1);
initialLabels(PositiveSet) = 1;
% this array of initial labels will be used subsequently to override NB
% classifiers when assigning labels to members of positive set
  
InitialNBClassifier = fitcnb(FeatureMatrix, initialLabels);%

[~,posteriorProbabilities]=predict(InitialNBClassifier,FeatureMatrix);
oldLabels = initialLabels;

newLabels = Posteriors_to_label(posteriorProbabilities(:, 2));

newLabels(PositiveSet) = 1;

% Repeated iterations of creating new classifiers until their label assignements converge. 
% They will have converged when oldLabels == newLabels - as these are used to generate posteriors, 
% that means that the posterior probabilities will have converged as well.

iterationCount = 1;
% we might be interested at some stage to see how long it takes for this step to converge

NBClassifier = InitialNBClassifier;

while( not(isequal(oldLabels, newLabels)) ) 
    
    if(iterationCount>30)  % this is probably close to converging within 2,3 iterations, let alone 20, no need to continue
            diff  = sum(abs(oldLabels - newLabels)); 
            break;
    end
    
    NBClassifier = fitcnb(FeatureMatrix, newLabels);
    
    % create the New NB classifier according to the new labels
    [~,posteriorProbabilities]=predict(NBClassifier,FeatureMatrix);
    % obtain its new posterior probabilities...

    % NB: 1 is label for P, -1 is label for N. However, classifier will have
    % the probs for 1 in 2, and probs for -1 in 1. Source of confusion!!
        
    oldLabels = newLabels;
    % remember the labels used for creating this classifier
   
    % NB: Reset newLabels to -1s, changed to vector operations here, works

    newLabels = Posteriors_to_label(posteriorProbabilities(:,2));
    
    newLabels(PositiveSet) = 1;
    
    % ...and then use posterior probabilities to obtain new labels.
    iterationCount = iterationCount + 1;
    
end
 
iterations = iterationCount;
[finalClass,prior] =predict(NBClassifier,FeatureMatrix);
finalClass(PositiveSet)=1;
end

