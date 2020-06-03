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
*/

:- use_module(library(apply)).
:- use_module(library(statistics)).

test:-
    writeln("euler005([1,20],232792560) should be true."),
    time(euler005([1,20],232792560)).

euler005([L,H],R):-
    numlist(L,H,LX),
    foldl(lcm,LX,1,R).

lcm(X,Y,Z):-
    Z is X*Y//gcd(X,Y).
