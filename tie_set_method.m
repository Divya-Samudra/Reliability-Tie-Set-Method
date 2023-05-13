%Program to evaluate system reliability using tie-set method
%Step-1: Minimal paths
%Step-2: Tie diagram
%Step-3: Reliability = P(T1 U T2 U T3....)
clc;
clear;
%Inputs: Incidencematrix and reliability of individual elements
incidence_matrix = [1 0 1 0 0;
                    0 1 0 1 0;
                    1 0 0 1 1;
                    0 1 1 0 1];
 reliability = [0.98 0.98 0.98 0.98 0.98];
 sizeof_incidence_matrix=size(incidence_matrix);
 system_reliability=0;
 %Tie elements
 for i1 = 1:sizeof_incidence_matrix(1);
     %if element exists that has to be considered for tie diagram
     element = 1;
     for j1=1:sizeof_incidence_matrix(2)
         if (incidence_matrix(i1,j1)==1)
             tie(i1,element)=j1;
             element=element+1;
         end
     end
 end
 tie
 sizeof_tie = size(tie);
 % All possible combinations of minimal paths for finding 'UNION'
 com=1;
 for com=1:sizeof_tie(1)
     combinations=combntns(1:sizeof_tie(1),com);
     sizeof_combinations=size(combinations);
     combinations
     for i2=1:sizeof_combinations(1)
         table=[];
         table=tie(combinations(i2,1),:);
         for j2 = 2:sizeof_combinations(2)
             table = [table,tie(combinations(i2,j2),:)];
         end
         sizeof_table=size(table);
         %Tie elements should be non-zero and non-repeated
         table1=[];
         table1=table;
         sizeof_table1=size(table1);
         table2=[];
         for i3=1:sizeof_table1(2)
             if(table1(1,i3)~=0) %avoid elements that are '0'
                 count=0;
                 for j3=i3:sizeof_table1(2)
                     if(table(1,j3)==table1(1,i3))
                         count=count+1;
                     end
                 end
             if (count==1)  %avoid repetition
                 table2 =[table2,table1(1,i3)];
             end
             end
         end
         table=[];
         table=table2;
         sizeof_table=size(table);
         union_terms=table
         %Reliability of individual tie blocks
         tie_reliability=1;
         for rel=1:sizeof_table(2)
             tie_reliability=tie_reliability * reliability(table(rel));
         end
         tie_reliability
         %Reliability of the system
         system_reliability=system_reliability+(((-1)^(com+1))*tie_reliability);
     end
 end
 system_reliability
             
             
         