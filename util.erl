-module(util).
-export([
    mod/2,
    read_file/1
]).

% rem in Erlang != modulo for negative numbers
% -10 rem 7 gives -3, while mod(-10, 7) should give 4, since -10 = -2 * 7 + 4.
mod(X, Y) when X > 0 -> X rem Y;
mod(X, Y) when X < 0 -> Y + X rem Y;
mod(0, _) -> 0.

read_file(FileName) -> 
    {ok, Binary} = file:read_file(FileName),
    BinaryList = binary:split(Binary, ~"\n", [trim, global]),
    [binary_to_list(BinLine) || BinLine <- BinaryList].