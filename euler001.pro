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
% - If we let modql/2 backtrack, every number can be counted more than once (at
%   most length(LD) times), altering the final sum.

/** <examples>
?- euler001([3,5],999,S).
*/ % S = 233168

:- use_module(library(clpfd)).

euler001(LD,B,S):-
    LD ins 1..sup,
    B in 1..sup,
    X in 1..B,
    findall(X,(indomain(X),modql(LD,X)),LM),
    sum_list(LM,S).

modql([D|T],X):-
    (X mod D #= 0, !); modql(T,X).
