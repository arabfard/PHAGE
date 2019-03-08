clc
% clearA
% close all
warning off
%%  P data
% load Data_reduce_by_PCA.mat;
DataType='Pa_Data';
Positive=Pa_Data(1:303,:);% it means in all sample this feature is zero or have a constant value
Unlabeled=Pa_Data(304:end,:);

Xfeat_out=0.98;
Pca_fea = MasoudPCA([Positive;Unlabeled],Xfeat_out);
%Nfeat_out=size(P,2);
%Pca_fea = pca_feature_reduction([Positive;Unlabeled],Nfeat_out);
%% P_label=ones(size(Positive,1),1); % P labels
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