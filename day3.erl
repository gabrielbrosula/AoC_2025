-module(day3).
-export([p1/0]).

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
