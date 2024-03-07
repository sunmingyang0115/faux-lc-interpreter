# Faux lambda Calculus Interpreter
A simple interpreter made using Racket.
### What is Lambda Calculus?
In simple terms it is a model of computation that has a sets of rules of which can compute anything.
Here is the grammar:
```
<expr> = <num>
      | (abs <expr>)
      | (app <expr>1 <expr>2)
```
Basically, an expression in this model can be one of three things:

A `num` is a number that represents a variable. A number is easier to work with than letters since the latter can cause naming collisions between scopes. 
The value of a `num` represents where it is bound (basically the definition of the variable). This convention is called [De Bruijn indices](https://en.wikipedia.org/wiki/De_Bruijn_index).

An abstraction, denoted by `(abs <expr>)` is essentially another `<expr>` wrapped around a binder. In simple terms, when `<expr>` is given a definition, `<expr>2`, through application,
it will change all variables in `<expr>` that references `<expr>` to `<expr>2` to that expression. Mathematically, it is represented as `λx.[expr]` where `x`
is a variable and `[expr]` being the `<expr>`. It uses `λ` (lambda) which is where the name Lambda Calculus comes from. 

Lastly there is application, `(app <expr>1 <expr>2)`, which means we pass `<expr>1` the definition `<expr>2`. Whenever `<expr>1` is evaluated, it will be in the form `(abs <expr>)`,
which expects a definition, which will be `<expr>2`. This is how abstractions are given definitions.

### Some Simple Computations:
We can define `True` and `False` as:
```
True := (abs (abs 2))
False := (abs (abs 1))
```
When `True` and `False` are given two arguments, `True` will output the first one and `False` the second one.

From then the logical operator `And` can be derived:
```
And := (abs (abs (app (app 2 1) False)))
```
