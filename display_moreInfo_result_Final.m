function [stats_tr] =display_moreInfo_result_Final(trainmodel_org,x_train,tr_label,subject_name)
tr_forcast_labels=predict(trainmodel_org,x_train);
[stats_Tr] = confusionmatStatsFinal(tr_label,tr_forcast_labels);
stats_tr=struct2cell(stats_Tr);
%=================
  disp('======================')
    disp(['    Confusion matrix for Classification on orginal data  '])
   disp('|---------------------------------------|')
   disp('| Real\Predict  | Positive   Negative   |')
   disp('|---------------------------------------|')
fprintf('| Positive      | %8s   %8s   |\r',num2str(stats_tr{1}(1,1)),num2str(stats_tr{1}(1,2)))
fprintf('| Negative      | %8s   %8s   |\r',num2str(stats_tr{1}(2,1)),num2str(stats_tr{1}(2,2)))
  disp('|---------------------------------------|')
disp('    ')
   disp('|-----------------------------------------------|')
   disp('|S.No Parameters    |  Value  |')
   disp('|-----------------------------------------------|')
fprintf('| 1  True positive  | %10s   |\r',num2str(stats_tr{1}(1,1)))
fprintf('| 2  False negative | %10s   |\r',num2str(stats_tr{1}(1,2)))
fprintf('| 3  False positive | %10s   |\r',num2str(stats_tr{1}(2,1)))
fprintf('| 4  True negative  | %10s   |\r',num2str(stats_tr{1}(2,2)))
   disp('|-----------------------------------------------|')
fprintf('| 5  TPR            | %10s   |\r',num2str(100*stats_Tr.sensitivity))
fprintf('| 6  FPR            | %10s   |\r',num2str((1-stats_Tr.specificity)))
fprintf('| 7  Precision      | %10s   |\r',num2str(100*stats_Tr.precision))
fprintf('| 8  Recall         | %10s   |\r',num2str(100*stats_Tr.recall))
fprintf('| 9  Accuracy       | %10s   |\r',num2str(100*stats_Tr.accuracy))
fprintf('|10  F1_score       | %10s   |\r',num2str(stats_Tr.Fscore))
fprintf('|11  Gmean          | %10s   |\r',num2str(stats_Tr.Gmean))
   disp('|_______________________________________________|')

end

