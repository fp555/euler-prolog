% Problem 5: Smallest multiple
% ----------------------------
% 2520 is the smallest number that can be divided by each of the numbers from
%   1 to 10 without any remainder.
% What is the smallest positive number that is evenly divisible (with no
%   remainder) by all of the numbers from 1 to 20?
%
% =============================================================================
%
% This problem becomes absolutely trivial if you remember that the least
%   common multiple operation is associative.
%
% Implementation notes:
% - Using 1 as initial value in foldl/4 does not alter the final result.

/** <examples>
?- euler005([1,20],R).
*/ % R = 232792560

euler005([L,H],R):-
    maplist(must_be(positive_integer),[L,H]),
    findall(X,between(L,H,X),LX),
    foldl(lcm,LX,1,R).

lcm(X,Y,Z):-
    Z is X*Y//gcd(X,Y).