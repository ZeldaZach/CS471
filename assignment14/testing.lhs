> import Debug.Trace

> hLen :: (Num u, Eq t) => ([t] -> u) -> [t] -> u
> hLen = (\f x -> if x == [] then 0 else 1 + (f (tail x)))
> myLength ls = if ls == [] then 0 else 1 + myLength (tail ls)

> factorial :: Integral a => a -> a
> factorial n = if n == 0 then 1 else n * (factorial (n-1))

> hFact = (\f x -> if x == 0 then 1 else x * (f (x - 1)))

> factorial' = hFact factorial'

> fix f = f (fix f)
 
 > fix' f = f fix' f