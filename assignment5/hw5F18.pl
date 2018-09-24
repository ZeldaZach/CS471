/* Zachary Halpern
   Homework Assignment 5 - Prolog 3
   Programming Languages
   CS471, Fall 2018
   Binghamton University */

/* Instructions */

/* After you change the filename to 'hw5F18.pl', You will be able to code
in and run this file in the Prolog interpreter directly.

We will be using swipl for our Prolog environment: To load/reload this file,
cd to its directory and run swipl. Then, in the prompt, type [hw5F18].

From then on you may execute queries (goals) in the prompt. As usual, you
should provide your answers in the designated spot. Once you have added some
code to the file, rerun [hw5F18]. in the swipl prompt to reload.

In addition, there are "unit tests" provided for each problem. These are 
there to help you better understand what the question asks for, as well as
check your code. They are included in our knowledge base as queries
and are initially commented out (% denotes a Prolog line comment).

%:- member_times(4,[3,3,2,3],0). 		% This test succeeds if
						% member_times(4, [3,3,2,3], 0)
						% unifies (and returns true).
%:- member_times(4,[1,2,3],3) -> fail ; true.   % This test succeeds if
						% member_times(4,[1,2,3],3)
						% fails to unify (false).

After you have finished a problem and are ready to test, remove the
initial % for each test for the associated problem and reload the
assignment file ([hw5F18].).
If any of the tests do not pass, you will get a warning.
If you pass the tests there is a good chance that your code
is correct, but not guaranteed; the tests are meant as guided feedback
and are not a check for 100% correctness.
*/

/* Submission */

/* For this assignment -- and the remaining Prolog assignments -- your
submission should only include this source file -- there is no need
to add an additional text file with answers. Please tar and gzip
this file as normal with a name like eway1_hw5.tar.gz. */

/* Homework 5 */

/* Due: Tuesday, 9/25 at 11:59 PM */

/* Purpose: To get comfortable with unification and pattern matching in Prolog. 
   To become familiar with reflective mechanism of Prolog, and Prolog as a 
   symbolic programming language.  More practice with recursion.
*/

/* Problem 0A (NOT GRADED):
   Each line is an individual Prolog query; it's a good idea type them in your
   prompt (not the file itself) to get a feel for the way Prolog works. You
   should think about whether or not each query will succeed, and if so how the
   variables will be initialized (unified). It will help in doing some of the
   problems.

?- help(arg).
?- arg(3, foo(a,b,c),A).
?- help('=..').
?- T =.. [foo,x, y, z].
?- E =.. ['+',2,3], R is E.
?- foo(who, what) =.. T.
?- foo(who, what) =.. [A, B,C].
?- X =.. [+,2,3], Y is X.
?- S = 19, V = 3, C is S div V.
?- S = 19, V = 3, C is S // V.
?- S = 19, V = 3, C is S / V.
?- A = zzz, atom(A).
?- N = 23, number(N).
?- A = 12, atom(A).
?- X is pi.
?- cos(pi,X).
?- X is cos(pi).
*/

/* Problem 0B (NOT GRADED):
 We will encode a mini-AST in Prolog using complex data structures. 
 A "node" will consist of either a ast(Functor,LeftExpr,RightExpr), 
 ast(Functor,Expr) or ast(Number).  Note a Number can be a number, pi or e.

 ast(Functor,LeftExpr,RightExpr) -- "abstract syntax tree binary node", Functor 
 is guaranteed to be a binary arithmetic predicate that can be evaluated with 
 `is`. LeftExpr and RightExpr are recursively defined "nodes".

 ast(Functor,Expr) -- "abstract syntax tree node unary", Functor is guaranteed 
 to be a unary arithmetic predicate that can be evaluated with `is`. Expr is a 
 recursively defined "node".

 ast(Number) -- "node number", Number or pi or e is guaranteed to be just that.

 Hence, the following AST
          *
        /   \
      min    -
      / \   / \
    -3   2 5  -
              /
             2
 would be encoded as ast('*', 
                     ast(min, ast(-3), ast(2)), 
                     ast('-',ast(5), ast('-', ast(2)))
                    )

 Draw the AST for the following encoding:
    ast(+, ast('*', ast(min, ast('-', ast(-3)), ast(4)), ast(2)), ast(10) ) 
*/

/* Problem 1:
   Write the predicate prodPartialR(N, ProdLst), which succeeds as follows:
   given a number N, ProdLst is a sequence of prods such that first number in
   ProdLst is the prod of all the numbers from N to 1 (IE N!), the second number
   is the prod of all the numbers from N-1 down to 1 (IE (N-1)!), and so on.
   In other words, ProdLst = [N*(N-1)*..*1, (N-1)*(N-2)*..*1, ..., 1].
   For example:

     ?- prodPartialR(5,P).
     S = [120, 24, 6, 2, 1] .

   This problem can be solved in 2 clauses.
*/

/* Problem 1 Answer */
prodPartialR(1, [1]).
prodPartialR(N, [H1, H2 | T]) :-
	Nnew is N - 1,
	prodPartialR(Nnew, [H2 | T]),
	H1 is N * H2.

/* Problem 1 Test */
 :- prodPartialR(1, [1]).
 :- prodPartialR(1, []) -> fail ; true.
 :- prodPartialR(3, [6, 2, 1]).
 :- prodPartialR(5, [120, 24, 6, 2, 1]).


/* Problem 2:
   Write the predicate prodPartialL(N, ProdLst). This problem is very similar to
   Problem 1, but with one key difference: the prod totals accumulate from left
   to right, so the ProdLst generated will be different. For example, the first
   value will be N, the second value will be N * (N-1), and so on.
   In other words, ProdLst = [N, N*(N-1), ..., N*(N-1)*(N-2)*...*1].
   For example,

     ?- prodPartialL(5,P).
     P = [5, 20, 60, 120, 120]

   It could be helpful to follow the idea to use an auxiliary predicate used in
   problem 4. So your first clause should be:

       prodPartialL(N,Lst):-prodPartialL(N,N,Lst).

   You need to add 2 additional clauses.
*/

/* Problem 2 Answer */
prodPartialL(N, List) :-
	prodPartialL(N, N, List).

prodPartialL(1, Prior, [Prior]).

prodPartialL(N, Prior, [H1, H2 | T]) :-
	Nnew is N - 1,
	H1 = Prior,
	NewPrior is Nnew * H1,
	prodPartialL(Nnew, NewPrior, [H2 | T]).

/* Problem 2  Test */
:- prodPartialL(1, [1]).
:- prodPartialL(1, []) -> fail ; true.
:- prodPartialL(5, [5, 20, 60, 120, 120]).


/* Problem 3:
   Write a predicate computeS/4. computeS(Op, Arg1, Arg2, Result) succeeds if
   Result is the value after computing Arg1 Op Arg2. Use the insight you gained
   in Problem 0B. Op is assumed to be a builtin Prolog operator.
*/

/* Problem 3 Answer: */
computeS(Op, Arg1, Arg2, Result) :-
	T =.. [Op, Arg1, Arg2],
	Result is T.

/* Problem 3 Test: */
:- computeS(-, 19, 7, 12).
:- computeS(div, 19, 7, 2).
:- computeS(div, 19, 7, R), R = 2.

:- computeS(/, 19, 7, 2) -> fail ; true.
:- catch((computeS(sin, 90, 1, _), fail), error(_Err, _Context), true).


/* Problem 4:
   In class we discussed the 'is' predicate for evaluating expressions. Write a
   predicate results/2.
   result(Elst,RLst) succeeds if Rlst is unifies with the values computed from
   the list of expressions, Elst.
*/

/* Problem 4 Answer: */
result([], []).

result([He | Te], [Ha | Ta]) :-
	Ha is He,
	result(Te, Ta).

/* Problem 4 Test */
 :- result([],[]).
 :- result([+(3,7), mod(104,7),-(5)],[10, 6, -5]).
 :- result([+(3,7), +(15, -(3,11))],X), X = [10, 7].

 :- result([+(3,7), mod(104,7)],[10,13]) -> fail ; true.


/* Problem 5:
   A good example of symbolic computation is symbolic differentiation. Below
   are the rules for symbolic differentiation where U, V are mathematical
   expressions, C is a number constant, N is an integer constant and x is a
   variable:

        dx/dx = 1
        d(C)/dx = 0.
        d(Cx)/dx = C
        d(-U)/dx = -(dU/dx)
        d(U+V)/dx = dU/dx + dV/dx
        d(U-V)/dx = dU/dx - dV/dx
        d(U*V)/dx = U*(dV/dx) + V*(dU/dx)
        d(U^N)/dx = N*U^(N-1)*(dU/dx)

   Translate these rules into Prolog. (Please keep the order of the rules the
   same for testing purposes).
*/

/* Problem 5 Answer: */
d(x, x, 1).
d(C, x, 0) :- number(C).
d(C, x, R) :- 
	C =.. [Op, Num, Sym | _],
	Op = '*',
	Sym = x,
	R = Num.

/*

?- help(arg).
?- arg(3, foo(a,b,c),A).
?- help('=..').
?- T =.. [foo,x, y, z].
?- E =.. ['+',2,3], R is E.
?- foo(who, what) =.. T.
?- foo(who, what) =.. [A, B,C].
?- X =.. [+,2,3], Y is X.
?- S = 19, V = 3, C is S div V.
?- S = 19, V = 3, C is S // V.
?- S = 19, V = 3, C is S / V.
?- A = zzz, atom(A).
?- N = 23, number(N).
?- A = 12, atom(A).
?- X is pi.
?- cos(pi,X).
?- X is cos(pi).*/


/* Problem 5 Test: */
:- d(x,x,R), R = 1 .
:- d(7,x,R), R = 0 .
:- d(7*x,x,R), R = 7 .
%:- d(x +2*(x^3 + x*x),x,Result), Result = 1+ (2* (3*x^2*1+ (x*1+x*1))+ (x^3+x*x)*0) .
% :- d(-(1.24*x -x^3),x,Result), Result = - (1.24-3*x^2*1) .
% :- d(-(1.24*x -2*x^3),x,Result), Result = - (1.24- (2* (3*x^2*1)+x^3*0)) .

% Pay careful attention to why this fails.
% :- d(x +2*(x^3 + x*x),x,Result), Result = 1+ (2* (3*x^(3-1)*1+ (x*1+x*1))+ (x^3+x*x)*0) -> fail ; true.


/* Problem 6:
Write a predicate change/2 that given the change amount, computes the way in which 
exact change can be given. Use the following USA's coin facts at your solution. */

coin(dollar, 100).
coin(half, 50).
coin(quarter, 25).
coin(dime, 10).
coin(nickel, 5).
coin(penny, 1).

/* The predicate change(S,CL) succeeds if given a positive integer S, CL is a 
   list of tuples that contains the name of the coin and the number of coins 
   needed to return the correct change.
   The change should be in the smallest number of coins, IE if we have 5 cents,
   the first output should be (nickel, 1) not (penny, 5).
   However, it is okay if alternative change combinations still unify, that is,
   different combinations come up if you use a semicolon:
?- change(5,CL).
CL=[(nickel,1)] ;
CL=[(penny,5)].
?- change(5,[(penny,5)]).
true.

The Coin Changing problem is an interesting problem usually studied in Algorithms.
http://condor.depaul.edu/~rjohnson/algorithm/coins.pdf has a nice discussion.
Think about (no need to turn in)
   1) How could we generalize this problem to handle coins from other currencies?
   2) What are the different techniques to find the change with the fewest number of coins ?
   3) What happens if the order of the "coin" facts change?
*/

/* Problem 6 Answer: */
change(Total, Tuple) :-
	Total >= 100,
	TotalOfCoin is Total // 100,
	NewTotal is Total - 100 * TotalOfCoin,
	change(NewTotal, RestOfTuple),
	Tuple = [(dollar, TotalOfCoin) | RestOfTuple].

change(Total, Tuple) :-
	Total >= 50,
	TotalOfCoin is Total // 50,
	NewTotal is Total - 50 * TotalOfCoin,
	change(NewTotal, RestOfTuple),
	Tuple = [(half, TotalOfCoin) | RestOfTuple].

change(Total, Tuple) :-
	Total >= 25,
	TotalOfCoin is Total // 25,
	NewTotal is Total - 25 * TotalOfCoin,
	change(NewTotal, RestOfTuple),
	Tuple = [(quarter, TotalOfCoin) | RestOfTuple].

change(Total, Tuple) :-
	Total >= 10,
	TotalOfCoin is Total // 10,
	NewTotal is Total - 10 * TotalOfCoin,
	change(NewTotal, RestOfTuple),
	Tuple = [(dime, TotalOfCoin) | RestOfTuple].

change(Total, Tuple) :-
	Total >= 5,
	TotalOfCoin is Total // 5,
	NewTotal is Total - 5 * TotalOfCoin,
	change(NewTotal, RestOfTuple),
	Tuple = [(nickel, TotalOfCoin) | RestOfTuple].

change(Total, Tuple) :-
	Total >= 1,
	Tuple = [(penny, Total)].

change(Total, []) :- Total = 0.

/* Problem 6 Tests: */
:- change(168,C), C = [ (dollar, 1), (half, 1), (dime, 1), (nickel, 1), (penny, 3)] .  %SUCCEED
:- change(75,C),  C = [ (half, 1), (quarter, 1)] .                                     %SUCCEED

:- (change(75,C), C = [(half, 2)]) -> fail ; true.             %FAIL


/* Problem 7:
 We will encode a mini-AST in Prolog using complex data structures. 
 This structure is described in Problem 0B at the beginning of this file.


 Write a predicate run(X,Y) that succeeds if Y is the result obtained from 
 "running" (evaluating) X. You will need to use the =.. predicate. It may be 
 helped to view some of the binary and unary arithmetic predicates 
  -- http://www.swi-prolog.org/man/arith.html. If you write your predicate 
 correctly, you do not need to concern yourself with the actual arithmetic 
 functor supplied in the nodes. */

/* Problem 7 Answer: */
run(ast(Functor, LeftExpr, RightExpr), Result) :-
	run(LeftExpr, LEResult),
	run(RightExpr, REResult),
	Total =.. [Functor, LEResult, REResult],
	Result is Total.

run(ast(Functor, Expr), Result) :-
	run(Expr, EResult),
	Total =.. [Functor, EResult],
	Result is Total.

run(ast(Number), Result) :-
	Number = Result. 

/* Problem 7 Tests: */
:- run(ast(float, ast(sin, ast('/', ast(pi), ast(2))) ),E), E = 1.0. %SUCCEED
:- run(ast(+,ast(*,ast(2),ast(3)),ast(random,ast(5))),_).   %SUCCEED
:- run(ast(+,ast(*,ast(2),ast(3)),ast(3)),E), E=9.   %SUCCEED
:- run(ast(+,ast(*,ast(2),ast(3)),ast(-,ast(6),ast(3))),E), E=9.   %SUCCEED
:- run(ast(2),E), E=2.   %SUCCEED
:- run(ast(abs,ast(-2)),E), E=2.   %SUCCEED

:- (run(ast(+,ast(*,ast(2),ast(3)),ast(-,ast(6),ast(3))),E), E=8) -> fail ; true.  %FAILS


/* Problem 8:
 Using the AST described in problem 0B, write a predicate binaryAP/2.  
 binaryAP(AST, BPlst) succeeds if all the binary arithmetic predicates that 
 occur in AST are collected into BPlst.  Use an inorder traversal of AST.  */

/* Problem 8 Answer: */


/* Problem 8 Tests: */
%:- T = ast(+,ast(*,ast(2),ast(3)),ast(random,ast(5))), binaryAP(T,L), L = [*, +].  %SUCCEED
%:- T = ast(+, ast(*, ast(2), ast(3)), ast(-,ast(3), ast(5))),  binaryAP(T,L), L = [*, +, -]. %SUCCEED
%:- T = ast(+, ast(*, ast(2),  ast(-,ast(3), ast(//, ast(2), ast(5)))),ast(9)) ,  binaryAP(T,L), L = [*, -, //, +]. %SUCCEED

%:- (T = ast(+,ast(*,ast(2),ast(3)),ast(random,nn(5))), binaryAP(T,L), L = [+,*]) -> fail ; true.      %FAIL
%


/* Problem 9:
   Write a predicate numAtoms/2.  numAtoms(+NestedLists, -C) that counts all the atoms in the
   NestedLists. The NestedLists contains only lists or atoms.  You may assume no numbers
   or variables are in any of the lists.

   ?- numAtoms([[r,ss,[a,b,c]],[a,b,c],[],[s,t,a,b]],C).
   C = 12.
   ?- numAtoms([[r,ss,[a,b,c]],[a,b,c],[],[s,t,[[]],b]],C).
   C = 11.

   Think What NOT how.  */

 /* Problem 9 Answer: */
 numAtoms([H | T], Sum) :-
    numAtoms(H, HSubSum),
    numAtoms(T, TSubSum),
    Sum is HSubSum + TSubSum.
 
 numAtoms([], 0).
 numAtoms(Atom, 1) :- atom(Atom).

/* Problem 9 Tests: */
:- numAtoms([[r,ss,[a,b,c]],[a,b,c],[],[s,t,a,b]],12).
:- numAtoms([[r,ss,[a,b,c]],[a,b,c],[],[s,t,a,b]],19) -> fail ; true.
:- numAtoms([[r,ss,[a,b,c]],[a,b,c],[],[s,t,a,b]],10) -> fail ; true.
:- numAtoms([[r,ss,[a,b,c]],[a,b,c],[],[s,t,[[]],b]],11).
:- numAtoms([r], 1).
:- numAtoms([r], 3) -> fail ; true.
:- numAtoms([[[r]]], 1).

# TODO: 4 & 7
