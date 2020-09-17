function code = arithmetic_encode_recursive(a, b, p, msg)
% ARITHMETIC_ENCODE_RECURSIVE Recursive function for arithmetic encoding.
% Takes a lower bound a, an upper bound b, a probability distribution p and
% a message. Returns the encoded message as a string of bits.
% One "interval selection" is made in each recursive call. Moreover, the
% message diminishes by 1 character at each recursive call.
% When the passed message is empty, recursion ends, upper and lower bounds
% of the current interval are converted into their binary expansion, and
% one value between them is selected.

if isempty(msg)
    % If the message is empty, we reached the end of the encoding. Any
    % value in the interval [a,b) can be returned. We choose a binary
    % expansion such that:
    % - its first n bits are the first n bits of both a and b when binary
    % expanded
    % - if b is not n+1 long, the n+1 digit is 1
    % - if b is n+1 long, we keep scanning a, truncate at the first 0 we
    % find, turn it into a 1, and return that
    bin_a = float_mant_to_binary(a, 100);
    bin_b = float_mant_to_binary(b, 100);
    % If the high interval is still exactly 1, we convert bin_b to the
    % closest possible representation of 0.999... in base 2, i.e. 0.111...
    % Thus, bin_b becomes just a vector of 1s.
    if b == 1
        bin_b = ones(1,100);
    end
    code = val_between_bin_range(bin_a, bin_b);
    return
end

L = b-a;
% Initialize the previous upper bound to a. This will be changed during the
% loop. We incrementally add steps to a to deduce the correct range.
previous_upper_bound = a;

% Construct the interval for each symbol starting from a (lower bound)
for symbol = keys(p)
    % Compute the length of the interval of  symbol
    symbol = char(symbol);
    Ls = L*p(symbol);
    lower_bound_s = previous_upper_bound;
    upper_bound_s = lower_bound_s + Ls;
    % Check if the next symbol to encode is the one that we just found the
    % boudaries of. If so, do the recursive call. Else, construct the next
    % interval.
    if msg(1) == symbol
       %Prints for debugging
       %fprintf('Encoding %c: ',symbol);
       %fprintf('lb=%.60f; ub=%.60f\n',lower_bound_s, upper_bound_s);
       %fprintf('difference=%.60f\n', upper_bound_s-lower_bound_s);
       code = arithmetic_encode_recursive(lower_bound_s, upper_bound_s, p, msg(2:end));
       % After return, it is no longer necessary to continue
       break
    else
        previous_upper_bound = upper_bound_s;
    end
end
end