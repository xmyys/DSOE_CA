p_NSo_in_OS=[x0 y0 z0];
XVector_NS_in_OS=[x1 y1 z1];
YVector_NS_in_OS=[x2 y2 z2];
ZVector_NS_in_OS=[x3 y3 z3];
R_NS_in_OS=[XVector_NS_in_OS',YVector_NS_in_OS',ZVector_NS_in_OS'];
p_OSo_in_NS=-R_NS_in_OS'*p_NSo_in_OS';
% p_A_in_OS=[x y z];
fin=zeros(100276,3);
for i=1:100276
    p_A_in_OS=points(i,:);
    T=[R_NS_in_OS',p_OSo_in_NS;0,0,0,1];
    p_A_in_NS=T*[p_A_in_OS';1];
    p_A_in_NS=p_A_in_NS(1:3,:);
    fin(i,:)=p_A_in_NS';
end
p_A_in_NS=round(p_A_in_NS',4);