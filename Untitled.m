
[pcaCoefficients, pcaScores, ~, ~, explained, pcaCenters] = pca(E_Data);
cs1 = cumsum(explained);
subplot(4,2,1);
plot(cs1);
title('Line Plot of POV & #Features in E_Data')
ylabel('cumulative POV') 
xlabel('Features') 
[pcaCoefficients, pcaScores, ~, ~, explained, pcaCenters] = pca(GA_Data);
cs2 = cumsum(explained);
subplot(4,2,2);
plot(cs2);
title('Line Plot of POV & #Features in GA_Data')
ylabel('cumulative POV') 
xlabel('Features') 
[pcaCoefficients, pcaScores, ~, ~, explained, pcaCenters] = pca(GO_Data);
cs3 = cumsum(explained);
subplot(4,2,3);
plot(cs3);
title('Line Plot of POV & #Features in GO_Data')
ylabel('cumulative POV') 
xlabel('Features') 
[pcaCoefficients, pcaScores, ~, ~, explained, pcaCenters] = pca(I_Data);
cs4 = cumsum(explained);
subplot(4,2,4);
plot(cs4);
title('Line Plot of POV & #Features in I_Data')
ylabel('cumulative POV') 
xlabel('Features') 
[pcaCoefficients, pcaScores, ~, ~, explained, pcaCenters] = pca(Int_Data);
cs5 = cumsum(explained);
subplot(4,2,5);
plot(cs5);
title('Line Plot of POV & #Features in Int_Data')
ylabel('cumulative POV') 
xlabel('Features') 
[pcaCoefficients, pcaScores, ~, ~, explained, pcaCenters] = pca(P_Data);
cs6 = cumsum(explained);
subplot(4,2,6);
plot(cs6);
title('Line Plot of POV & #Features in P_Data')
ylabel('cumulative POV') 
xlabel('Features') 
[pcaCoefficients, pcaScores, ~, ~, explained, pcaCenters] = pca(Pa_Data);
cs7 = cumsum(explained);
subplot(4,2,7);
plot(cs7);
title('Line Plot of POV & #Features in Pa_Data')
ylabel('cumulative POV') 
xlabel('Features') 
[pcaCoefficients, pcaScores, ~, ~, explained, pcaCenters] = pca(R_Data);
cs8 = cumsum(explained);
subplot(4,2,8);
plot(cs8);
title('Line Plot of POV & #Features in R_Data')
ylabel('cumulative POV') 
xlabel('Features') 




% [filename1, pathname1] = uigetfile({'*.*';'*.xlsx';'*.xls'}, 'Select Positive or all data');
% All_data= xlsread([pathname1,filename1]);
% features=All_data(:,1:end-1);% input features

% [pcaCoefficients, pcaScores, ~, ~, explained, pcaCenters] = pca(features);
% cs_1 = cumsum(explained);

% filename1='All Fusion';
% plot(csAll)
% title(['Line Plot of POV & #Features in ',filename1])
% ylabel('cumulative POV') 
% xlabel('Features') 



