function [stats] = confusionmatStatsFinal(group,grouphat)
% INPUT
% group = true class labels
% grouphat = predicted class labels|
% stats.accuracy = (TP + TN)/(TP + FP + FN + TN)    ; for each class label
% stats.precision = TP / (TP + FP)                  % for each class label
% stats.sensitivity = TP / (TP + FN)                % for each class label
% stats.specificity = TN / (FP + TN)                % for each class label
% stats.recall = sensitivity                        % for each class label
% stats.Fscore = 2*TP /(2*TP + FP + FN)             % for each class label
% stats.Gmean = sqrt(sensitivity*specificity)      % for each class label
%
% TP: true positive, TN: true negative, 
% FP: false positive, FN: false negative
% 

field1 = 'confusionMat';
if nargin < 2
    value1 = group;
else
    [value1,gorder] = confusionmat(group,grouphat);
end





%[TP,TN,FP,FN,accuracy,sensitivity,specificity,precision,f_score,gmean] = deal(zeros(numOfClasses,1));

   TP = value1(1,1);
   tempMat = value1;
   tempMat(:,1) = []; % remove column
   tempMat(1,:) = []; % remove row
   TN = sum(sum(tempMat));
   FP = sum(value1(:,1))-TP;
   FN = sum(value1(1,:))-TP;


    accuracy = (TP + TN)/(TP + FP + FN + TN);
    sensitivity = TP / (TP + FN);
    specificity = TN / (FP + TN);
    precision = TP / (TP + FP);
    f_score = 2*TP/(2*TP + FP + FN);
    gmean = sqrt(sensitivity*specificity);

% accuracy(numOfClasses+1)=sum(diag(value1))/sum(value1(:));
field2 = 'accuracy';  value2 = accuracy;
field3 = 'sensitivity';  value3 = sensitivity;
field4 = 'specificity';  value4 = specificity;
field5 = 'precision';  value5 = precision;
field6 = 'recall';  value6 = sensitivity;
field7 = 'Fscore';  value7 = f_score;
field8 = 'Gmean';  value8 = gmean;
%=========================
% TP: true positive, TN: true negative, 
% FP: false positive, FN: false negative
new_field1='true_positive'; new_value1=TP;
new_field2='true_negative'; new_value2=TN;
new_field3='false_positive'; new_value3=FP;
new_field4='false_negative'; new_value4=FN;
stats2=struct(new_field1,new_value1,new_field2,new_value2,new_field3,new_value3,new_field4,new_value4);
stats = struct(field1,value1,field2,value2,field3,value3,field4,value4,field5,value5,field6,value6,field7,value7);
if exist('gorder','var')
    stats = struct(field1,value1,field2,value2,field3,value3,field4,value4,field5,value5,field6,value6,field7,value7,field8,value8,'groupOrder',gorder);
end