% Problem 10: Summation of primes
% -------------------------------
% The sum of all primes below 10 is 17.
% Find the sum of all primes below 2000000.
%
% =============================================================================
%
% The perfect job for an Erathosthenes sieve. Ancient greek knowledge to the
%   rescue!
%
% Implementation notes:
% - Low performance, high CPU usage and high stack space consumption (set to
% 	1GB). Prime numbers are hard;
% - That slightly terse convlist/3 is really an Euler's sieve: the k-th
% 	recursion leaves (after subtract/3) only numbers coprime with the first k
%   primes.

/** <examples>
?- euler010(2000000,X).
*/

:- set_prolog_flag(stack_limit, 1000000000).
:- use_module(library(clpfd)).
:- use_module(library(yall)).
:- use_module(library(lists),[numlist/3,sum_list/2,subtract/3]).
:- use_module(library(apply),[convlist/3]).
:- use_module(library(statistics),[time/1]).

test:-
    write("Testing for "),
    write(euler010(2000000,142913828922)),
    writeln(" takes too long. A shorter test:"),
    writeln(euler010(20000,21171191)),
    time(euler010(20000,21171191)).

euler010(L,SP):-
    L in 2..sup,
    numlist(2,L,LN),
    sieve(L,LN,LP),
    sum_list(LP,SP).

sieve(X,[H|P],[H|P]):-
    H*H #> X,
    !.
sieve(X,[H|TN],[H|TP]):-
    convlist({H,X}/[N,D]>> (D #= H*N, X #>= D),[H|TN],LD),
    subtract(TN,LD,R),
    sieve(X,R,TP).
