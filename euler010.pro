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
% - Low performance and high stack space consumption. ¯\_(ツ)_/¯

/** <examples>
?- euler003(2000000,X).
*/

:- use_module(library(clpfd)).
:- use_module(library(yall)).
:- use_module(library(lists),[numlist/3,sum_list/2,subtract/3]).
:- use_module(library(apply),[maplist/3]).
:- use_module(library(listing),[portray_clause/1]).
:- use_module(library(statistics),[time/1]).

test:-
    portray_clause(euler010(2000000,142913828922)),
    time(euler010(2000000,142913828922)).

euler010(L,SP):-
    L in 2..sup,
    numlist(2,L,LN),
    sieve(L,LN,LP),
    sum_list(LP,SP).

sieve(X,[H|P],[H|P]):-
    H*H #> X,
    !.
sieve(X,[H|TN],[H|TP]):-
    maplist({H}/[N,D]>> #=(D,H*N),[H|TN],LD),
    subtract(TN,LD,R),
    sieve(X,R,TP).
