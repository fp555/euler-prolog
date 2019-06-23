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
% While I admit my approach does not make one gaze upon its beauty or elegance,
%   I like how straightforward it looks (and also, it works!).
% I also liked how this is basically a FizzBuzz variation: if you can solve
%   this without Google you should also be able to solve FizzBuzz, and
%   viceversa.
%
% Implementation notes:
% - The cut in testdiv/2 prevents a number from being counted more than once if
%     if it is evenly divisible by multiple divisors in the list. Since we
%     only care about the first successful test we have to prevent Prolog from
%     backtracking from ;/2 and trying again.

/** <examples>
?- euler001([3,5],999,S).
*/ % S = 233168

euler001(LD,B,S):-
    append([B],LD,L),
    forall(member(D,L),must_be(positive_integer,D)),
    sort(LD,SD),
    findall(X,(between(1,B,X),testdiv(SD,X)),LM),
    sum_list(LM,S).

testdiv([D|T],X):-
    (X mod D =:= 0,!);
    testdiv(T,X).
