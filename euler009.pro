% Problem 6: Special Pythagorean triplet
% --------------------------------------
% A Pythagorean triplet is a set of three natural numbers a < b < c for which
%   a^2 + b^2 = c^2.
% There exists exactly one Pythagorean triplet for which a+b+c = 1000. Find
%   the product a*b*c.
%
% =============================================================================
%
% A brute force approach with clpfd.
%
% Implementation notes:
% - Thanks to #=/2 (and #</2) my solution works in every direction: you can
%   find T and P with set S (as required), P and S with set T, and even T and S
%   with set P;
% - Changing the default labeling/2 options makes this complete in milliseconds
%   instead of almost a minute.

/** <examples>
?- once(euler009(T,P,1000)).
*/

:- use_module(library(clpfd)).
:- use_module(library(apply),[foldl/4]).
:- use_module(library(statistics),[time/1]).

test:-
    writeln(euler009([200,375,425],31875000,1000)),
    time(once(euler009([200,375,425],31875000,1000))).

euler009(T,P,S):-
    T = [A,B,C],
    T ins 1..sup,
    chain(T,#<),
    A^2+B^2 #= C^2,
    sum(T,#=,S),
    foldl([X,Y,Z]>> #=(X*Y,Z),T,1,P),
    labeling([max,bisect],T).
