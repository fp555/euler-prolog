% Problem 3: Largest prime factor
% -------------------------------
% The prime factors of 13195 are 5, 7, 13 and 29.
% What is the largest prime factor of the number 600851475143 ?
%
% =============================================================================
%
% Nothing special about this problem, just straight number crunching. Good
%   thing the problem number is not huge, because prime factorization is a
%   really inefficient operation.
%
% Implementation notes:
% - In nextprime/2, if a divisor is found (skipping 1) we need not bother
%   trying anything else. Praise failure-driven backtracking!
% - I was forced to use is/2 with floor/1, while using #=/2 inside the
%   negated goal brutally kills performance and I am not sure why.

/** <examples>
?- euler003(600851475143,X).
*/

:- use_module(library(clpfd)).
:- use_module(library(statistics)).

test:-
    writeln("euler003(600851475143,6857) should be true."),
    time(euler003(600851475143,6857)).

euler003(N,MF):-
    N in 1..sup,
    pfactor(N,2,LF),
    last(LF,MF).

pfactor(1,_,[]):- !.
pfactor(N,F,[F|LF]):-
    N mod F #= 0,
    NN #= N//F,
    pfactor(NN,F,LF),
    !.
pfactor(N,F,LF):-
    nextprime(F,NP),
    (NP^2 #=< N -> pfactor(N,NP,LF); pfactor(N,N,LF)).

nextprime(2,3):- !.
nextprime(N,P):-
    P #= N+2,
    M is floor(sqrt(P)),
    \+ (between(2,M,X),0 is P mod X),
    !.
nextprime(N,P):-
    NN #= N+2,
    nextprime(NN,P).
