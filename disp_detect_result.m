function nothing =disp_detect_result(trainmodel_org,trainmodel_pu,model_type,x_train,tr_label,explain,subject_name)
nothing=[];
switch model_type
    case 'SVM'
tr_forcast_labels=predict(trainmodel_org,x_train);
ts_forcast_labels=predict(trainmodel_pu,x_train);

stats_tr = confusionmatStats(tr_label,tr_forcast_labels);
stats_tr=struct2cell(stats_tr);
stats_ts = confusionmatStats(tr_label,ts_forcast_labels);
%[value1,gorder] = confusionmat(ts_label,ts_forcast_labels);
stats_ts=struct2cell(stats_ts);
%=================
disp(['   Report: ', subject_name]) 
 disp('==============')
 disp('     ')
disp(['  machine learning algorithms  =  ',explain,'+',model_type])
disp('======================')
disp('      ')
   disp('|---------------------------------------------|')
   disp('| Measure      |  orginal LB  | We detect LB  |')
   disp('|---------------------------------------------|')
fprintf('| Accuracy     | %12s | %12s  |\r',num2str(mean(stats_tr{2})*100),num2str(mean(stats_ts{2})*100))
fprintf('| Specificity  | %12s | %12s  |\r',num2str(mean(stats_tr{4})),num2str(mean(stats_ts{4})))
fprintf('| Recall       | %12s | %12s  |\r',num2str(mean(stats_tr{6})),num2str(mean(stats_ts{6})))
fprintf('| F1_score     | %12s | %12s  |\r',num2str(mean(stats_tr{7})),num2str(mean(stats_ts{7})))
fprintf('| Gmean        | %12s | %12s  |\r',num2str(mean(stats_tr{8})),num2str(mean(stats_ts{8})))
   disp('|__________________________________________________|')
  disp('    ')
   %disp('   Confusion Matrix: ') 
 %disp('=================')
 %disp(' On Orginal data : ')
 %disp(' ')
 %disp(num2str(stats_tr{1}))
 %disp('__________________')
 %disp(' On Unmixed data : ')
 %disp(' ')
 %disp(num2str(stats_ts{1}))
 %disp('__________________') 

    case 'NB'
      tr_forcast_labels=predict(trainmodel_org,x_train);
      ts_forcast_labels=predict(trainmodel_pu,x_train);
      %ts_forcast_labels=nb_Pred(trainmodel_pu,x_train);

stats_tr = confusionmatStats(tr_label,tr_forcast_labels);
stats_tr=struct2cell(stats_tr);
stats_ts = confusionmatStats(tr_label,ts_forcast_labels);
%[value1,gorder] = confusionmat(ts_label,ts_forcast_labels);
stats_ts=struct2cell(stats_ts);
%=================
disp(['   Report: ', subject_name]) 
 disp('==============')
 disp('     ')
disp(['  machine learning algorithms  =  ',explain,'+',model_type])
disp('      ')
   disp('|---------------------------------------------|')
   disp('| Measure      | orginal data |    We detect  |')
   disp('|---------------------------------------------|')
fprintf('| Accuracy     | %12s | %12s  |\r',num2str(mean(stats_tr{2})*100),num2str(mean(stats_ts{2})*100))
fprintf('| Specificity  | %12s | %12s  |\r',num2str(mean(stats_tr{4})),num2str(mean(stats_ts{4})))
fprintf('| Recall       | %12s | %12s  |\r',num2str(mean(stats_tr{6})),num2str(mean(stats_ts{6})))
fprintf('| F1_score     | %12s | %12s  |\r',num2str(mean(stats_tr{7})),num2str(mean(stats_ts{7})))
fprintf('| Gmean        | %12s | %12s  |\r',num2str(mean(stats_tr{8})),num2str(mean(stats_ts{8})))
   disp('|__________________________________________________|')
  disp('    ')
  
  % disp('   Confusion Matrix: ') 
 %disp('=================')
 %disp(' Train data : ')
 %disp(' ')
 %disp(num2str(stats_tr{1}))
 %disp('__________________')

 %disp(' Test data : ')
 %disp(' ')
 %disp(num2str(stats_ts{1}))
 %disp('__________________') 

   case 'Spy'
      tr_forcast_labels=predict(trainmodel_org,x_train);
      ts_forcast_labels=predict(trainmodel_pu,x_train);
      %ts_forcast_labels=nb_Pred(trainmodel_pu,x_train);

stats_tr = confusionmatStats(tr_label,tr_forcast_labels);
stats_tr=struct2cell(stats_tr);
stats_ts = confusionmatStats(tr_label,ts_forcast_labels);
%[value1,gorder] = confusionmat(ts_label,ts_forcast_labels);
stats_ts=struct2cell(stats_ts);
%=================
disp(['   Report: ', subject_name]) 
 disp('==============')
 disp('     ')
disp(['  machine learning algorithms  =  ',explain,'+',model_type])
disp('      ')
   disp('|---------------------------------------------|')
   disp('| Measure      | orginal data |    We detect  |')
   disp('|---------------------------------------------|')
fprintf('| Accuracy     | %12s | %12s  |\r',num2str(mean(stats_tr{2})*100),num2str(mean(stats_ts{2})*100))
fprintf('| Specificity  | %12s | %12s  |\r',num2str(mean(stats_tr{4})),num2str(mean(stats_ts{4})))
fprintf('| Recall       | %12s | %12s  |\r',num2str(mean(stats_tr{6})),num2str(mean(stats_ts{6})))
fprintf('| F1_score     | %12s | %12s  |\r',num2str(mean(stats_tr{7})),num2str(mean(stats_ts{7})))
fprintf('| Gmean        | %12s | %12s  |\r',num2str(mean(stats_tr{8})),num2str(mean(stats_ts{8})))
   disp('|__________________________________________________|')
  disp('    ')
 %  disp('   Confusion Matrix: ') 
 %disp('=================')
 %disp(' Train data : ')
 %disp(' ')
 %disp(num2str(stats_tr{1}))
 %disp('__________________')
 %disp(' Test data : ')
 %disp(' ')
 %disp(num2str(stats_ts{1}))
 %disp('__________________') 

end

