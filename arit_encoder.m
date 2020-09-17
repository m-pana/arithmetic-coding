function [code, msg] = arit_encoder(alphabet_str, probs, msg)
% ARIT_ENCODER Main function of the program. Receives a message msg, an
% alphabet in character array form, and a probability distribution.
% Parses the alphabet into individual characters and starts the recursive
% encoding function. Removes spaces from the message.

% Instantiate new alphabet as series of strings
alphabet = [];
for c = alphabet_str
    alphabet = [alphabet string(c)];
end
% Prepare probability function
p = containers.Map(alphabet, probs);
% Remove spaces
msg = strrep(msg, ' ', '');
% Encode
code = arithmetic_encode_recursive(0,1,p,msg);
end