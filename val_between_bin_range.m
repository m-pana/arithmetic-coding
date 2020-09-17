function out = val_between_bin_range(a,b)
% VAL_BETWEEN_BIN_RANGE selects a binary values in between binary values a
% and b (assuming a<b), such that:
% - its first n bits are the first n bits of both a and b when binary
% expanded
% - if b is not n+1 long, the n+1 digit is 1
% - if b is n+1 long, we keep scanning a, truncate at the first 0 we
% find, turn it into a 1, and return that

% Take the first same n digits
out = [];
i = 1;
while length(a)>=i && length(b) >= i && a(i) == b(i)
    out = [out a(i)];
    i = i+1;
end
% Check for the last digit
if length(out)+1 ~= length(b)
    out = [out 1];
else
    % We do not want the output to be equal to b
    out = [out 0];
    i = length(out)+1;
    while length(a)>=i && a(i) == 1
        % So now we're adding a 1
        out = [out a(i)];
        i = i+1;
    end
    % Out of the loop, we encoutered a 0. We add a 1 to make sure we are
    % within the interval
    out = [out 1];
end
end
        