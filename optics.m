% [RD,CD,order]=optics(x,k)
% -------------------------------------------------------------------------
% Aim: 
% Ordering objects of a data set to obtain the clustering structure 
% -------------------------------------------------------------------------
% Input: 
% x - data set (m,n); m-objects, n-variables
% k - number of objects in a neighborhood of the selected object
% (minimal number of objects considered as a cluster)
% -------------------------------------------------------------------------
% Output: 
% RD - vector with reachability distances (m,1)
% CD - vector with core distances (m,1)
% order - vector specifying the order of objects (1,m)
% -------------------------------------------------------------------------
% Example of use:
% x=[randn(30,2)*.4;randn(40,2)*.5+ones(40,1)*[4 4]];
% [RD,CD,order]=optics(x,4)
% -------------------------------------------------------------------------
% References: 
% [1] M. Ankrest, M. Breunig, H. Kriegel, J. Sander, 
% OPTICS: Ordering Points To Identify the Clustering Structure, 
% available from www.dbs.informatik.uni-muenchen.de/cgi-bin/papers?query=--CO
% [2] M. Daszykowski, B. Walczak, D.L. Massart, Looking for natural  
% patterns in analytical data. Part 2. Tracing local density 
% with OPTICS, J. Chem. Inf. Comput. Sci. 42 (2002) 500-507
% -------------------------------------------------------------------------
% Written by Michal Daszykowski
% Department of Chemometrics, Institute of Chemistry, 
% The University of Silesia
% December 2004
% http://www.chemometria.us.edu.pl

function [RD,CD,order,D]=optics(x,k)

[m,~]=size(x);  
CD=zeros(1,m);
RD=ones(1,m)*10^10;

% Calculate Core Distances
for i=1:m    
    D=sort(dist(x(i,:),x));
    CD(i)=D(k+1);   % 第k+1个距离是密度的界限阈值
end

order=[];
seeds=[1:m];

ind=1;

while ~isempty(seeds)
    ob=seeds(ind);
    %disp(sprintf('aaaa%i',ind))
    seeds(ind)=[];      
    order=[order ob];   % 更新order
    var1 = ones(1,length(seeds))*CD(ob);
    var2 = dist(x(ob,:),x(seeds,:));
    mm=max([var1;var2]);    % 比较两个距离矩阵，选择较大的距离矩阵
    ii=(RD(seeds))>mm;
    RD(seeds(ii))=mm(ii);
    [~, ind]=min(RD(seeds));
    %disp(sprintf('bbbb%i',ind))
end   

RD(1)=max(RD(2:m))+.1*max(RD(2:m));

function [D]=dist(i,x)

% function: [D]=dist(i,x)
%
% Aim: 
% Calculates the Euclidean distances between the i-th object and all objects in x     
% Input: 
% i - an object (1,n)
% x - data matrix (m,n); m-objects, n-variables        
%                                                                 
% Output: 
% D - Euclidean distance (m,1)

[m,n]=size(x);
D=(sum((((ones(m,1)*i)-x).^2)'));   % 距离和

if n==1
   D=abs((ones(m,1)*i-x))';
end
