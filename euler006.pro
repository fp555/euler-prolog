% Problem 6: Sum square difference
% --------------------------------
% Find the difference between the sum of the squares of the first one hundred
%   natural numbers and the square of the sum.
%
% =============================================================================
%
% There are closed formulas for this:
%   ∑ k = n(n+1)/2
%   ∑ k^2 = n(n+1)(2n+1)/6

/** <examples>
?- euler006(100,R).
*/

:- use_module(library(clpfd)).
:- use_module(library(statistics),[time/1]).

test:-
    writeln(euler006(100,25164150)),
    time(euler006(100,25164150)).

euler006(N,R):-
    [N,R] ins 1..sup,
    SSQ #= (N*(N+1)//2)^2,
    SQS #= N*(N+1)*(2*N+1)//6,
    R #= SSQ-SQS.
