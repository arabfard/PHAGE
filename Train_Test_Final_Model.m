clc
clear
close all
warning off
load 'All_Index.mat';

LB=[Positive;Negative]; % target (real labels)
Xfeat_out=0.98;
NewAll = All(LB,:);
All_labels=[ones(size(Positive,1),1);-ones(size(Negative,1),1)];
All_features = MasoudPCA_X(NewAll,Xfeat_out);

num_folds=5; %you can change it as you wish  Use  num_folds-fold stratified cross validation
CV = cvpartition(All_labels,'k',num_folds);
cont=0;
for i = 1:CV.NumTestSets
    
    tr_index = CV.training(i);
    ts_index = CV.test(i);
    %===== we here select num_folds-1 of all folds
    features=All_features(tr_index,:);
    labels=All_labels(tr_index,:);
    % 1 remain for test
    ts_features=All_features(ts_index,:);
    ts_labels=All_labels(ts_index,:);

    % this part as always but we save all run folds in cell vector format and
    % all result of them
    trainmodel_org{i,1}=fitcnb(features,labels);

    %% num_fold-1 part ================================================
     % more static info
    display_moreInfo_result_Final(trainmodel_org{i,1},features,labels,['NB','#Train ','#fold ',num2str(i)]);
    %% AUC ROC FPR TPR
    [nb_org_tpr{i,1},nb_org_fpr{i,1},nb_org_AUC{i,1}] =plot_roc_auc_detect_result_Final(trainmodel_org{i,1},features,labels,['Train#NB','#fold ',num2str(i)]);
    %% remain Fold part
    % more static info
    display_moreInfo_result_Final(trainmodel_org{i,1},ts_features,ts_labels,['NB','#Test ','#fold ',num2str(i)]);
    %% AUC ROC FPR TPR
    [nb_org_tpr_ts{i,1},nb_org_fpr_ts{i,1},nb_org_AUC_ts{i,1}] =plot_roc_auc_detect_result_Final(trainmodel_org{i,1},ts_features,ts_labels,['Test#NB','#fold ',num2str(i)]);
    disp(['fold ',num2str(i),' of ',num2str(CV.NumTestSets),' Done!'])
    disp('--------------------------------------------------------------------')
    disp('********************************************************************')
    disp('--------------------------------------------------------------------')
end