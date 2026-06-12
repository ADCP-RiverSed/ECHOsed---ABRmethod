function character = fAddChar0(somevalue)
% this function returns a char with '0' (zero) appended if somevalue (numeric or char) is
% less than 10, else returns somevalue as char

if isnumeric(somevalue)
    if somevalue<10
        character=['0' num2str(somevalue)];
    else
        character=num2str(somevalue);
    end
else
    aux=str2num(somevalue);
    if aux<10
        character=['0' somevalue];
    else
        character=num2str(somevalue);
    end
end

