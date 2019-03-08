function [RN_List,positiveCentroid, negativeCentroid] = Rocchio(FeatureMatrix,Temp_labels, alpha, beta)

% Rocchio will return a (sorted) list of indexes that are identified as
% being in the Reliable Negative set.

% FeatureMatrix : features matrix 
% Temp_labels contains the 1 for positive labeles and 0 for Unlabel in the Feature Vector
% MixedSet represents array indices of unlabeled elements
% alpha, beta are the parameters used in the centroid calculation

%implements the Rocchio classifier which identifies the RN set.

% We are to calculate the positive and the negative centroid, and then
% classify those documents in MixedSet more similar to the negative one
% than to the positive ones as reliable negatives. 
PositiveSet=find(Temp_labels==1);% P index
MixedSet=find(Temp_labels==0);% U index
if( nargin < 3) 
    alpha = 16; beta = 4; 
end

[positiveCentroid, negativeCentroid] = calc_Centroids(FeatureMatrix, PositiveSet, MixedSet, alpha, beta);

% What is left is to determine which of the unlabeled documents belong in RN
% To do this, we need to compute the cosine similarity with each centroid
% cos (theta) = A dot B / (|A| * |B|)
% we can do this with a single matrix multiplication, first calculate the
% dot product and then divide by (calculated) norm products of vectors,
% and then by the norms of centroids as well.

% we'll need the norms of all the entries, we'll filter out positives later
featureNorms = sqrt(sum(FeatureMatrix.^2,2));

% calculate the dot product of Centroids 
similarityPositives = (sum(FeatureMatrix .* repmat(positiveCentroid, size(FeatureMatrix, 1), 1), 2));
similarityNegatives = (sum(FeatureMatrix .* repmat(negativeCentroid, size(FeatureMatrix, 1), 1), 2));


% now, divide the dot product by the norm of the respective document:
similarityPositives = similarityPositives ./  featureNorms;
similarityNegatives = similarityNegatives ./ featureNorms;

% in order to complete the cosine similarity calculation, we need to divide by norm of centroid:
similarityPositives  = similarityPositives / norm(positiveCentroid);
similarityNegatives = similarityNegatives / norm(negativeCentroid);

% Now, we need to iterate through the list and identify the RN set:
similarity_Difference = similarityNegatives - similarityPositives;
 similarity_Difference(PositiveSet) = -1;

% once we sort, we'll also remove positives from the list, as they'll all
% have the value of -1 representing their final similarity score:
[sortedList, indexes] = sort(similarity_Difference);

% Those elements with similarity_Difference > 0 belong in RN.
% idx will be the break-off point
idx = -1;
for i=1:length(sortedList)
    if(sortedList(i)>=0)
        idx = i; break;
    end
end


% if there are entries to be put into RN
if(idx~=-1) 
    RN_List( 1:(length(sortedList)-idx+1) ) = sort(indexes( idx:length(sortedList)));
else
    RN_List = single.empty;
end
