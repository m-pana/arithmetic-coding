# Arithmetic coding
MATLAB implementation of a binary encoding app that makes use of [Arithmetic coding](https://en.wikipedia.org/wiki/Arithmetic_coding). Includes a MATLAB GUI.

## MATLAB functions
- `arit_encoder.m` The main script of the program. Parses the alphabet as individual characters from a given char array and again defines the given probability distribution as a symbol-probability Map. Removes all spaces within the message and calls the encoding function.
Returns the encoded message and the plaintext message (devoid of spaces)
- `arithmetic_encode_recursive.m` Recursively implements the arithmetic coding algorithm. Takes as parameters the extremes of and interval (`a`, `b`), a probability distribution of the input alphabet (`p`), and a message to encode (`msg`)
- `float_mant_to_binary.m` Given a float, computes the binary expansion of its fractional part. The conversion is done by taking the fractional part, multiplying it by two and adding its whole part (either a 0 or a 1) to the output expansion.
Since the binary expansion might be infinite, the function also takes a `max_iter` parameter that
truncates the expansion after a certain number of iterations, if the conversion has not yet reached
an end
- `val_between_bin_range.m` Given two (potentially infinite, but truncated) binary expansions `a` and `b` (such that `a`<`b`), returns a binary value contained within the interval [`a`,`b`)
- `encoder_gui_exported.m` The GUI of the program. Checks for errors in the input values and displays the result of the conversion. Automatically normalizes the input probability vector
