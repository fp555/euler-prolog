% Problem 1: Multiples of 3 and 5
% -------------------------------
% If we list all the natural numbers below 10 that are multiples of 3 or 5, we
%   get 3, 5, 6 and 9. The sum of these multiples is 23.
% Find the sum of all the multiples of 3 or 5 below 1000.
%
% =============================================================================
%
% I decided to solve this problem without hardcoding either the divisors list
%   [3,5] or the upper bound (1000), but instead taking them as parameters.
%   This is basically a FizzBuzz variation: if you can solve this without
%   Google you should also be able to solve the original version and viceversa.
%
% Implementation notes:
% - If we take more than one solution from modql/2, every number can be
%   counted more than once (at most length(LD) times), altering the final sum.
%   For the sake of declarativeness I would rather use once/1 instead of a
%   (red) cut in modql/2.

/** <examples>
?- euler001([3,5],999,S).
*/

:- use_module(library(clpfd)).
:- use_module(library(statistics),[time/1]).
:- use_module(library(lists),[member/2,sum_list/2]).

test:-
    writeln(euler001([3,5],999,233168)),
    time(euler001([3,5],999,233168)).

euler001(LD,B,S):-
    LD ins 1..sup,
    B in 1..sup,
    X in 1..B,
    findall(X,(indomain(X),once(modql(LD,X))),LM),
    sum_list(LM,S).

modql(LD,X):-
    member(D,LD),
    X mod D #= 0.
