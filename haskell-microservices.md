% Tutorial: Microservices in Haskell
% Alexander Abushkevich
% March 2015

---

# REST and DB access

## [alexanderaa.github.io/haskell-microservices](https://alexanderaa.github.io/haskell-microservices/)

---

# Agenda

* Microservices - definition and introductory notes
* Quick overview - request/response cycle and associated type conversions
* Focus on a variety of libraries, which help to (de)serialize JSON/XML/... 

. . .

* Focus on a variety of libraries, which help to (de)serialize DB data
* REST in Haskell
* Putting all pieces together - compile and run the resulting microservice

<div class="notes">
This is my note.

- It can contain markdown
- like this list

</div>

---

# Microservices - definition

``` {.haskell .numberLines startFrom="1"}
    val range f t =
        let 
            fun range' acc f t =
                if (f >= t)
                    then acc
                    else (range' (f :: acc) (f+1) t)
        in
            range' [] f t
        end
```

---

# Yesod


---

# Applicative functors

``` {.haskell}
Prelude> import Control.Applicative
Prelude Control.Applicative> :t (<$>)
(<$>) :: Functor f => (a -> b) -> f a -> f b

```


---

# Declare data types

## Message, which contains text s
``` {.haskell}
data MId           = MId Integer                deriving (Eq, Ord, Show)
data EmailAddress  = EmailAddress String        deriving (Eq, Ord, Show)
data MText         = MText String               deriving (Eq, Ord, Show)
data MStatus = MNew
             | MRead
             | MDeleted
                    deriving (Eq, Ord, Show)
                    
data Message = Message { mId      :: MId
                       , mText    :: MessageText 
                       , mStatus  :: MessageStatus
                       , mDated   :: UTCTime }
                            deriving  (Eq, Ord, Show, Typeable)

```


---


# Aeson conversions

``` {.haskell .numberLines startFrom="1"}
instance AE.FromJSON Message where
    parseJSON (AE.Object v) = 
        Message <$> (v AE..: "id"      ) 
                <*> (v AE..: "message" ) 
                <*> (v AE..: "status"  ) 
                <*> (v AE..: "dated"   ) 
```

---

# Add simple quickcheck test


``` {.haskell}
prop_OptionJSON :: Option -> Bool
prop_OptionJSON o = (((AE.decode . AE.encode) (Just o)) == (Just o))
```





---

# PostgreSQL-simple



---



## Questions?









