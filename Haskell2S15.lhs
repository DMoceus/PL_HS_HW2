> module Haskell2S15
>     where

Problem 1: 
On the first Haskell homework Problem 4: you defined replicate' using primative 
recursion. Now define replicate' using only list comprehension notation.
 eg.
     ....> replicate' [5,1,3,2,8,1,2]
  [5,5,5,5,5,1,3,3,3,2,2,8,8,8,8,8,8,8,8,1,2,2]

> replicate' lst = concat [ [ x |y<-[1..x]] | x<-lst]

Problem 2: 
Define a function member that takes an item and a list and returns True if the
item is in the list and false otherwise.   
 

     ... > member 4 [1,4,3,8]
     True
     ... > member 4 [4,3,8]
     True
     ... > member 4 [3,8]
     False

a) use primitive recursion and (||) :: Bool -> Bool -> Bool in your solution.

> member _ [] 		= False
> member a (h:t)	= (a == h) || (member a t)

b) use list comprehension notation

> member2 _ []		= False
> member2 a lst		= any (True==) [x==a|x<-lst]

Problem 3: Use list comprehension notation )
(From Thompson 17.23)  Give a definition of the function

    factor :: Integral a => a -> [a]

which returns a list containing the factors of a positive integer.  For instance

    factors 12 = [1,2,3,4,6,12]

> factors n	= [a | a <- [1..n], (n `mod` a) == 0]

Problem 4: 
More tree problems ..  
Given the data type Tree a make it an instance of Eq.

> data Tree a = Leaf  | Node a (Tree a) (Tree a) deriving Show

Make Tree type an instance of Eq.  To accomplish this we must overload the (==)
operator. The type variable of Tree be also be an instance of Eq.    
So the first line of code must be
  ... > instance Eq a => Eq (Tree a)
      >   where

A tree is considered equal if the shape is the same and the values are 
the same. 
Complete the definition of (==) for Tree.   
Below is some test data:

> tree1 = Node 5 (Node 10 Leaf (Node 12 Leaf (Node 15 Leaf Leaf) ) ) Leaf
> tree2 = Node 5 (Node 10 Leaf (Node 99 Leaf (Node 15 Leaf Leaf) ) ) Leaf
> tree3 = Node 5 (Node 10 (Node 12 Leaf (Node 15 Leaf Leaf) ) Leaf ) Leaf

Example results:

  .... > tree1 == tree1
  True
  .... > tree1 /= tree2
  True
  .... > tree3 == tree1
  False

> instance Eq a => Eq (Tree a)
> 	where
>		Leaf == Leaf = True
>		(Node _ _ _) == Leaf = False
>		Leaf == (Node _ _ _) = False
>		(Node a tLA tRA) == (Node b tLB tRB) = (a==b) && (tLA == tLB) && (tRA == tRB)

Problem 5: 
 Please implement a function which returns mirror of a Tree a.
 (http://codercareer.blogspot.com/2011/10/no-12-mirror-of-binary-trees.html)
i.e.

  ... > mirror tree1
  Node 5 Leaf (Node 10 (Node 12 (Node 15 Leaf Leaf) Leaf) Leaf)
  ... > mirror (Node "abc" Leaf (Node "x" Leaf Leaf))
  Node "abc" (Node "x" Leaf Leaf) Leaf

> mirror Leaf 			= Leaf
> mirror (Node a lT rT)	= (Node a (mirror rT) (mirror lT))
