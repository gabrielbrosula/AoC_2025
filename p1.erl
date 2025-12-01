-module('p1').
-export([part_one/0, part_two/0]).

% Solution:
% Do the additions and subtractions mod 100 according to the list.
% When the result is zero, increment the counter.

part_one() -> 
    FileName = "input/1-1.txt",
    Lines = util:read_file(FileName),

    p1_solver(50, 0, Lines).

p1_solver(Begin, Count, []) -> 
    io:format("Begin: ~p, Count: ~p~n", [Begin, Count]),
    Count;
p1_solver(Begin, Count, [Line|T]) ->
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

    p1_solver(Result, NewCount, T).

part_two() ->
    FileName = "input/1-1.txt",
    Lines = util:read_file(FileName),
    p2_solver(50, 0, Lines).


p2_solver(Begin, Count, []) -> 
    io:format("Begin: ~p, Count: ~p~n", [Begin, Count]),
    Count;
p2_solver(Begin, Count, [Line|T]) ->
    % Parse the string
    Dir = string:slice(Line, 0, 1),
    ParsedNum = list_to_integer(string:slice(Line, 1)),

    case Dir of
        "L" -> Num = -1 * ParsedNum;
        "R" -> Num = ParsedNum
    end,

    % Do the calculations
    Intermediate = Begin + Num,
    Result = util:mod(Intermediate, 100),

    if 
        Intermediate < 0, Begin /= 0 -> NewCount = Count + abs(Intermediate div 100) + 1;
        Intermediate < 0, Begin == 0 -> NewCount = Count + abs(Intermediate div 100);
        Intermediate > 0 -> NewCount = Count + Intermediate div 100;
        Intermediate == 0 -> NewCount = Count + 1
    end,
    
    io:format("Begin: ~p, Num: ~p, Intermediate: ~p, Count: ~p, Result: ~p~n", [Begin, Num, Intermediate, NewCount, Result]),

    p2_solver(Result, NewCount, T).

