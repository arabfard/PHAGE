[E90,E95,E98,E99,EX]=MasoudPCA2(E_Data);
[GA90,GA95,GA98,GA99,EGA]=MasoudPCA2(GA_Data);
[GO90,GO95,GO98,GO99,EGO]=MasoudPCA2(GO_Data);
[I90,I95,I98,I99,EI]=MasoudPCA2(I_Data);
[IN90,IN95,IN98,IN99,EInt]=MasoudPCA2(Int_Data);
[P90,P95,P98,P99,EP]=MasoudPCA2(P_Data);
[PA90,PA95,PA98,PA99,EPa]=MasoudPCA2(Pa_Data);
[R90,R95,R98,R99,ER]=MasoudPCA2(R_Data);


   disp('                                Landa for Every Features                           ')
   disp('|---------------------------------------------------------------------------------|')
   disp('| Feature           | Number of Features |  NFL90  |  NFL95  |  NFL98  |  NFL98   |')
   disp('|---------------------------------------------------------------------------------|')
fprintf('| Experssion        | %18s | %7s | %7s | %7s | %7s  |\r',num2str(size(E_Data,2)),num2str(E90),num2str(E95),num2str(E98),num2str(E99))
fprintf('| Gene Annotation   | %18s | %7s | %7s | %7s | %7s  |\r',num2str(size(GA_Data,2)),num2str(GA90),num2str(GA95),num2str(GA98),num2str(GA99))
fprintf('| Gene Ontology     | %18s | %7s | %7s | %7s | %7s  |\r',num2str(size(GO_Data,2)),num2str(GO90),num2str(GO95),num2str(GO98),num2str(GO99))
fprintf('| Interaction       | %18s | %7s | %7s | %7s | %7s  |\r',num2str(size(I_Data,2)),num2str(I90),num2str(I95),num2str(I98),num2str(I99))
fprintf('| Intrinsic         | %18s | %7s | %7s | %7s | %7s  |\r',num2str(size(Int_Data,2)),num2str(IN90),num2str(IN95),num2str(IN98),num2str(IN99))
fprintf('| Phenotype&Disease | %18s | %7s | %7s | %7s | %7s  |\r',num2str(size(P_Data,2)),num2str(P90),num2str(P95),num2str(P98),num2str(P99))
fprintf('| Pathway           | %18s | %7s | %7s | %7s | %7s  |\r',num2str(size(Pa_Data,2)),num2str(PA90),num2str(PA95),num2str(PA98),num2str(PA99))
fprintf('| Requlatory        | %18s | %7s | %7s | %7s | %7s  |\r',num2str(size(R_Data,2)),num2str(R90),num2str(R95),num2str(R98),num2str(R99))
   disp('|_________________________________________________________________________________|')