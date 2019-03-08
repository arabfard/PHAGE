%%% temp is Negative excel file in sheet1
A=temp(:);
B=unique(A);
for i=1:size(B,1)
B(i,2)=sum(A==B(i,1));
end
[~,idx] = sort(B(:,2),'desc');
sortedB = B(idx,:);