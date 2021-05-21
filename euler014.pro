% Problem 14: Longest Collatz sequence
% ------------------------------------
% The following iterative sequence is defined for the set of positive ints:
%   n → n/2 (n is even)
%   n → 3n + 1 (n is odd)
%
% Using the rule above and starting with 13, we generate the following
%   sequence: 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
%
% It can be seen that this sequence (starting at 13 and finishing at 1)
%   contains 10 terms. Although it has not been proved yet (Collatz Problem),
%   it is thought that all starting numbers finish at 1.
%
% Which starting number, under one million, produces the longest chain? (Once
%   the chain starts the terms are allowed to go above one million).
%
% =============================================================================
%
% Surprisingly easy, but another problem that pushes the CPU hard and takes
%   quite some time to get the solution.

/** <examples>
?- euler014(1000000,X).
*/

:- use_module(library(clpfd)).
:- use_module(library(lists),[max_list/2,nth1/3]).
:- use_module(library(statistics),[time/1]).

test:-
    write("Testing for "),
    write(euler014(1000000,[837799])),
    writeln(" takes too long. A shorter test:"),
    writeln(euler014(10000,[6171])),
    time(euler014(10000,[6171])).

euler014(L,S):-
    findall(LL,czall(L,LL),X),
    max_list(X,M),
    findall(N,nth1(N,X,M),S).
    
czall(U,X):-
    between(1,U,N),
    collatz(N,RL),
    length(RL,X).

collatz(1,[1]):- !.
collatz(N,[N|T]):-
    mod(N,2) #= 0,
    !,
    N2 #= div(N,2),
    collatz(N2,T).
collatz(N,[N|T]):-
    N2 #= *(3,N)+1,
    collatz(N2,T).
