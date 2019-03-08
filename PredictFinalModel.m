clc
clear
close all
warning off
load 'All_Index.mat';
load 'RowData_PCA98_Predictor.mat';
load 'Model.mat';
load 'GeneList.mat';

 All_features = PCATeData;

num_folds=10; 
for i = 1:num_folds    
    Predict_labels{i,1}=predict(trainmodel_org{i,1},All_features);

    disp(['Predict ',num2str(i),' of ',num2str(num_folds),' Done!'])
    disp('--------------------------------------------------------------------')
    disp('********************************************************************')
end

PPI=(Predict_labels>0);
PPI(1,:)=(Predict_labels{1}>0);
PPI(2,:)=(Predict_labels{2}>0);
PPI(3,:)=(Predict_labels{3}>0);
PPI(4,:)=(Predict_labels{4}>0);
PPI(5,:)=(Predict_labels{5}>0);
PPI(6,:)=(Predict_labels{6}>0);
PPI(7,:)=(Predict_labels{7}>0);
PPI(8,:)=(Predict_labels{8}>0);
PPI(9,:)=(Predict_labels{9}>0);
PPI(10,:)=(Predict_labels{10}>0);
PPI=PPI';
SP=find(sum(PPI')==10);
CI=TeI(SP);
selected_Candid_Gene=GeneList(CI);
selected_Candid_Features=All(CI,:);
Positive_Features=All(PI,:);

W=zeros(size(selected_Candid_Features));


for i=1:size(W,1)
   for j=1:size(W,2)
       for k=1:size(Positive_Features,1)
           W(i,j)=W(i,j)+( selected_Candid_Features(i,j)*Positive_Features(k,j));
       end      
   end
end

SW=sum(W');
[value,index]=sort(SW,'desc');

Sort_Candidate_Gene=selected_Candid_Gene(index);








