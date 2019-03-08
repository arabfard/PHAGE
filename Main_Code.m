clc
clear
close all
warning off
%% load saved data from Mat file
load send.mat
% % remove features with zero variance
% constant_or_zero_feature_index_P=find(var(Positive)==0);
% save(['Index of ',num2str(size(constant_or_zero_feature_index_P,2)),' columns with zero variance ( Removed from P and U features).mat'],'constant_or_zero_feature_index_P')
% 
 Positive=Positive(:,var(Positive)~=0);% it means in all sample this feature is zero or have a constant value
 Unlabeled=Unlabeled(:,var(Positive)~=0);
 Nfeat_out=400;% number of features to reduce% you can change it as you wish
 All_data=[Positive;Unlabeled];
% %[uniq_data,ia,ic] = unique(Positive,'rows');
Pca_fea = pca_feature_reduction(All_data,Nfeat_out);
save(['Data (Dim = ',num2str(Nfeat_out),') reduce by PCA.mat'],'Pca_fea')
%============================================================
%%  P data
% load Data_reduce_by_PCA.mat;
 P = Pca_fea(1:size(Positive,1),:); % P : Pca features
%% U data
 U = Pca_fea(size(Positive,1)+1:end,:);% U : Pca features
%% The Naive Bayes Technique
% setting initial labels (1 for P ans 0 for U)
LB=[ones(size(Positive,1),1);zeros(size(U,1),1)];
[finalClass_nb, iterations,prior,NBClassifier] = NB_Algorithm([P;U],LB);
% save some Workspace results in root of main code
save([DataType '_NaiveBayes_FinalClassifier.mat'],'NBClassifier')
save([DataType '_Labeles_NaiveBayes_Technique.mat'],'finalClass_nb')
%% Roc-SVM
[~, reliableNegatives, svmClassifierFinal, svmFirstResults, SVMFirstClassifier] = Rocchio_SVM_Algorithm([P;U],LB);
save([DataType '_RocchioSVM_FinalClassifier.mat'], 'svmClassifierFinal')
finalClass_rocsvm=predict(svmClassifierFinal,[P;U]);
finalClass_rocsvm(1:size(P,1))=1;% P orginal labels
save([DataType '_Labeles_Roc-SVM_Technique.mat'], 'finalClass_rocsvm')
%% Spy-NB
[finalClass_snb,Spy_NBClassifier,P_indx,U_indx,N_indx,iterationCount]= Spy_EM_Algorithm([P;U],LB);
save([DataType '_SPY_FinalClassifier.mat'], 'Spy_NBClassifier')
save([DataType '_Labeles_SPY_Technique.mat'], 'finalClass_snb')

%================================================