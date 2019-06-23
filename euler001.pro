% Problem 1: Multiples of 3 and 5
% -------------------------------
% If we list all the natural numbers below 10 that are multiples of 3 or 5, we
%   get 3, 5, 6 and 9. The sum of these multiples is 23.
% Find the sum of all the multiples of 3 or 5 below 1000.
%
% =============================================================================
%
% I decided to solve this problem without hardcoding either the multiples list
%   [3,5] or the upper bound (1000), but instead taking them as parameters from
%   the input query.
% I liked how this is basically a FizzBuzz variation: if you can solve this
%   without Google you should also be able to solve FizzBuzz, and viceversa.
%
% Implementation notes:
% - testdiv/2 could return multiple solutions, but since we only need to know
%   if there is one I used limit/2.

/** <examples>
?- euler001([3,5],999,S).
*/ % S = 233168

euler001(LD,B,S):-
    must_be(positive_integer,B),
    maplist(must_be(positive_integer),LD),
    sort(LD,SD),
    findall(X,(between(1,B,X),limit(1,modql(SD,X))),LM),
    sum_list(LM,S).

modql([D|T],X):-
    X mod D =:= 0;
    testdiv(T,X).