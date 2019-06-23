% Problem 3: Largest prime factor
% ---------------------------------
% The prime factors of 13195 are 5, 7, 13 and 29.
% What is the largest prime factor of the number 600851475143 ?
%
% =============================================================================
%
% Nothing special about this problem, just straight number crunching. I could
%   afford being somewhat inefficient since the problem number is not huge, but
%   even minimal optimization efforts can have a really high payoff:
%
%   ?- time(euler003(600851475143,X)).
%   Before: 55,011,006 inferences, 5.611 CPU in 6.296 seconds
%   Now: 67,150 inferences, 0.012 CPU in 0.012 seconds
%
% Implementation notes:
% - 1 does not have any prime factors;
% - In divisors/2 I do not really require the divisors list to be sorted, but
%   rather to not have duplicates (and sort/2 is shorter than list_to_set/2),
%   while unfortunately I really do need that stupid append/2;
% - nextprime/2 is what happens when a programmer is too lazy to write multiple
%   similar predicates and too prone to conditional operators abuse :).

/** <examples>
?- euler003(600851475143,X).
*/ % X = 6857

euler003(N,MF):-
    must_be(positive_integer,N),
    pfactor(N,2,LF),
    last(LF,MF).

pfactor(1,_,[]):- !.
pfactor(N,F,[F|LF]):-
    N mod F =:= 0,
    NN is N//F,
    pfactor(NN,F,LF),
    !.
pfactor(N,F,LF):-
    nextprime(F,NP),
    (NP^2 =< N -> pfactor(N,NP,LF); pfactor(N,N,LF)).

nextprime(N,P):-
    (N =:= 2 -> Y is 3; Y is N+2),
    (isprime(Y) -> P is Y; nextprime(Y,P)).

isprime(N):-
    divisors(N,D),
    length(D,2).

divisors(N,L):-
    M is floor(sqrt(N)),
	findall([X,Y],(between(1,M,X),N mod X =:= 0,Y is N//X),LLD),
    append(LLD,LD),
    sort(LD,L).