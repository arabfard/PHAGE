function [tr_tpr,tr_fpr,tr_AUC] =plot_roc_auc_detect_result_Final(trainmodel_org,x_train,real_label,explain)

      %Compute the posterior probabilities (scores).
        targets=ones(size(real_label,1),size(unique(real_label),1));% we have size(unique(real_label),1)=2
        % we set a mx2 matrix that each class has a logical 1x2 vector that
        % means sample label belong to whitch class (calss -1 in clumn 1  and class 1 in clumn 2)
        % example : for label=[-1;1;1;1;-1;1] we have
        % targets=[1 0;0 1;0 1;0 1;1 0;0 1]
        targets(real_label~=-1,1)=0;
        targets(real_label~=1,2)=0;
        %-------------------------------------
        % Estimate each-Sample Posterior Probabilities
        [~,tr_postProbs]=predict(trainmodel_org,x_train);
        % creat a vector to show axis 50-50 splits
        split_line=(0:0.001:1)';
         % Receiver operating characteristic function for calculate TPR :
         % True Positive Rate and FPR : False Positive Rate
        [tr_tpr,tr_fpr] = roc(targets',tr_postProbs');
        tr_fpr{1}=[tr_fpr{1},1];
        tr_fpr{2}=[tr_fpr{2},1];
        tr_tpr{1}=[tr_tpr{1},1];
        tr_tpr{2}=[tr_tpr{2},1];
        % show ROC plot
        figure(1),plot(split_line,split_line,'k',tr_fpr{1},tr_tpr{1},'b',tr_fpr{2},tr_tpr{2},'r','LineWidth',2)
        %figure(1),plotroc(targets',tr_postProbs');
        
        %box off
        axis equal
        xlim([-0.001 1.001])
        ylim([-0.001 1.001])
        grid on
        grid minor
        legend('50-50','class Negative','class postive','Location','southeast')
        xlabel('False positive rate') 
        ylabel('True positive rate')
        title([' NB classifier : ROC for Classification (orginal labels) '])
        saveas(gcf,[explain,' ',' NB classifier # ROC for Classification (orginal labels).png'])
%       saveas(gcf,[explain(end-6:end),' ',' NB classifier # ROC for Classification (orginal labels).png'])

        %=================================================================

        %===============================================================
        % calculate AUC by Trapezoidal numerical integration 
        tr_AUC = trapz(tr_fpr{1},tr_tpr{1}); % in 2 class classifier we always have AUC(class 1)= AUC(class 2)

        
        figure(2),area(tr_fpr{2},tr_tpr{2},'FaceColor','r','LineWidth',1.5,'FaceAlpha',0.3);
        
        axis equal
        xlim([-0.001 1.001])
        ylim([-0.001 1.001])
        grid on
        grid minor
        xlabel('False positive rate') 
        ylabel('True positive rate')
        title([' NB classifier : ROC for  orginal labels  :  AUC = ',num2str(tr_AUC)])
        saveas(gcf,[explain,' ',' NB classifier # ROC for orginal labels # AUC = ',num2str(tr_AUC),'.png'])
%       saveas(gcf,[explain(end-6:end),' ',' NB classifier # ROC for orginal labels # AUC = ',num2str(tr_AUC),'.png'])


end

