function Prod=fproduct(A)
% this function multiplies every column of a matrix.

Prod=ones(size(A,1),1);
for i=1:size(A,1)
    Prod=A(:,i).*Prod;
end