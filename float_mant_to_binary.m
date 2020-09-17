function res = float_mant_to_binary(x, max_iter)
% FLOAT_TO_BINARY Takes the fractional part of the float (i.e. the so
% called "mantissa") and converts that number to base 2. Outputs the
% mantissa of that resulting number as a binary vector.
% If the result does not converge withing max_iter iterations, the number
% is truncated.
m = x - floor(x);
if m == 0
    % If an integer was given, just return the integer itself
    res = x;
    return
end
res = [];
i = 0;
while m ~= 0 & i < max_iter
    m = m*2;
    % Add the whole part to the output vector
    res = [res floor(m)];
    % Update number
    m = m - floor(m);
    i = i+1;
end
end