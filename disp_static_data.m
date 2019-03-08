function [static_info] =disp_static_data(input_data,input_label,data_name)
disp('   ')
disp(['  Features Dim     =  ', num2str(size(input_data,2))])
   disp(['    Sample distributions of instances for ',data_name])
   disp('|--------------------------------------------------------------------------|')
   disp('| Category of class | Number of instances | Percentage of class occurrence |')
   disp('|--------------------------------------------------------------------------|')
fprintf('| Positive          | %19s | %29s  |\r',num2str(sum(input_label==1)),[num2str((sum(input_label==1)/size(input_data,1))*100),'%'])
fprintf('| Negative          | %19s | %29s  |\r',num2str(sum(input_label==-1)),[num2str((sum(input_label==-1)/size(input_data,1))*100),'%'])
fprintf('| Total             | %19s | %29s  |\r',num2str(size(input_data,1)),[num2str((size(input_data,1)/size(input_data,1))*100),'%'])
   disp('|__________________________________________________________________________|')
static_info='Done';
end

