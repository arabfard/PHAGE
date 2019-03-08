% load 'send.mat';
% All=[Positive;Unlabeled];
% load 'RowData.mat';
labels=RowData(:,end); % target (real labels)
labels(labels~=1)=-1;%
PI=find(labels==1);
UI=find(labels==-1);
All_Index=[PI;UI];
Positive=RowData(PI,:);
Unlabeled=RowData(UI,:);
All=[Positive;Unlabeled];

% 1-Experssion Data
E_Data=All(:,[1:3101 9604:9679 9926:10035 109104:11033]);
% 2-Gene Ontology Data
GO_Data=All(:,[3127:3131 3590:6985]);
% 3-Intrinsic Data
Int_Data=All(:,[3102:3126 3132:3314 3559:3589 9163:9283 9368:9427 10887:10903 11230:11243]);
% 4-Phenotype & Disease Data
P_Data=All(:,[3315:3558 10036:10804 11244:11698]);
% 5-Interaction Data
I_Data=All(:,6986:9162);
% 6-Annotation Data
GA_Data=All(:,[9284:9367 9680:9925 10805:10886]);
% 7-Requlatory Data
R_Data=All(:,9428:9603);
% 8-Phatway Data
%Pa_Data=All(:,[11034:11229 11699:11723]);
Pa_Data=All(:,11034:11229);
