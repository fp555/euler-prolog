% Problem 2: Even Fibonacci numbers
% ---------------------------------
% Each new term in the Fibonacci sequence is generated by adding the previous
%   two terms. By starting with 1 and 2, the first 10 terms will be 1, 2, 3,
%   5, 8, 13, 21, 34, 55, 89, ...
% By considering the terms in the Fibonacci sequence whose values do not
%   exceed four million, find the sum of the even-valued terms.
%
% =============================================================================
%
% Quite similar to problem 1, but this took me way less time since I used the
%   same approach. I did not hardcode the "even-valued" condition, so you can
%   change it to "divisible-by-X" by passing a different number instead of 2.
%
% Implementation notes:
% - A Fibonacci generator is the classical use case of memoization, slashing
%   the complexity from exponential (2 recursions per call with the "textbook
%   definition") to linear (just tail recursion);
% - I am actually glad that the problem text explicitly said to start with 1
%   and 2, sparing me the bother of handling the special case;
% - Initially my solution did not have any cut. I admit Prolog surprised me a
%   bit when it said there were multiple solutions for this problem! genfib/4
%   can backtrack to a previous solution considering less Fibonacci numbers.
%   While the problem does not explicitly ask to consider ALL the terms below
%   the threshold, I assumed it does and added that cut.

/** <examples>
?- euler002(4000000,2,S).
*/ % S = 4613732

euler002(B,M,S):-
    maplist(must_be(positive_integer),[B,M]),
    genfib(0,1,B,LF),
    !,
    include(modq(M),LF,LN),
    sum_list(LN,S).

genfib(N1,N2,B,[N|LF]):-
    N is N1+N2,
    N =< B,
    genfib(N2,N,B,LF).
genfib(_,_,_,[]).

modq(M,X):- X mod M =:= 0.