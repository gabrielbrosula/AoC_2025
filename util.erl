-module(util).
-export([
    mod/2,
    read_file/1
]).

% rem in Erlang != modulo for negative numbers
% -10 rem 7 gives -3, while mod(-10, 7) should give 4, since -10 = -2 * 7 + 4.
mod(X, Y) when X > 0 -> X rem Y;

% The additional rem operation is needed when X rem Y is 0.
% This is because Y + X rem Y when X rem Y = 0 lets Y be part of the domain, when 
% answers for modulo should always be in the range [0, Y).
mod(X, Y) when X < 0 -> (Y + X rem Y) rem Y;
mod(0, _) -> 0.

read_file(FileName) -> 
    {ok, Binary} = file:read_file(FileName),
    BinaryList = binary:split(Binary, ~"\n", [trim, global]),
    [binary_to_list(BinLine) || BinLine <- BinaryList].