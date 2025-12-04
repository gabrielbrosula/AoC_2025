-module(day3).
-export([p1/0, p2/0, voltage/2]).

p1() ->
    Lines = util:read_file("input/3.txt"),
    Voltages = lists:foldl(
        fun(Line, Acc) ->
            % First occurrence of the maximum number that is not at the end
            LineWithoutEnd = string:slice(Line, 0, length(Line) - 1),
            Max1 = lists:max(LineWithoutEnd),
            Max1Index = util:find_index(Max1, Line),
            %io:format("Line: ~p, Max1: ~c, Max1Index: ~p, ", [Line, Max1, Max1Index]),

            Later = string:slice(Line, Max1Index + 1),
            Max2 = lists:max(Later),
            %io:format("Later: ~p, Max2: ~c~n", [Later, Max2]),


            Num = list_to_integer([Max1,Max2]),
            [Num|Acc]
        end,
        [],
        Lines
    ),
    %io:format("~p~n", [Lines]),
    %io:format("~w~n", [Voltages]),
    erlang:display(lists:sum(Voltages)).

p2() ->
    Lines = util:read_file("input/3.txt"),
    Voltages = get_voltages(Lines),
    erlang:display(lists:sum(Voltages)).

get_voltages(Lines) -> 
    lists:foldl(
        fun(Line, Acc) ->
            Acc ++ [list_to_integer(voltage(Line, 12))]
        end,
        [],
        Lines
    ).

% Largest subsequence of length K
voltage(String, K) -> max_subsequence(String, K, []).

max_subsequence(String, K, Acc) when length(String) > K, K > 0 ->
    SearchStr = string:slice(String, 0, length(String) - K + 1),
    Max = lists:max(SearchStr),
    MaxIdx = util:find_index(Max, String),
    NewStr = string:slice(String, MaxIdx + 1),
    NewAcc = Acc ++ [Max],
    % io:format("String: ~p, K: ~p, Acc: ~p, Max: ~c, MaxIdx: ~p, NewStr: ~p, NewAcc: ~p~n", [String, K, Acc, Max, MaxIdx, NewStr, NewAcc]),
    max_subsequence(NewStr, K - 1, NewAcc);
max_subsequence(String, K, Acc) when length(String) == K, K > 0 ->
    Acc ++ String;
max_subsequence(_, 0, Acc) -> Acc;
max_subsequence(_, K, _) when K < 0 -> error.


