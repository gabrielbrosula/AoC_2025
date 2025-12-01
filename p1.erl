-module('p1').
-export([solve/0]).

% Solution:
% Do the additions and subtractions mod 100 according to the list.
% When it is zero, increment the counter.

solve() -> 
    FileName = "input/1-1.txt",
    Lines = util:read_file(FileName),

    solver(50, 0, Lines).

solver(Begin, Count, []) -> 
    io:format("Begin: ~p, Count: ~p~n", [Begin, Count]),
    Count;
solver(Begin, Count, [Line|T]) ->
    % Parse the string
    Dir = string:slice(Line, 0, 1),
    ParsedNum = list_to_integer(string:slice(Line, 1)),

    case Dir of
        "L" -> Num = -1 * ParsedNum;
        "R" -> Num = ParsedNum
    end,

    % Do the calculations
    Result = util:mod(Begin + Num, 100),
    
    io:format("Begin: ~p, Line: ~p, Num: ~p, Result: ~p, Count: ~p~n", [Begin, Line, Num, Result, Count]),

    if 
        Result == 0 -> NewCount = Count + 1;
        true -> NewCount = Count
    end,

    solver(Result, NewCount, T).

