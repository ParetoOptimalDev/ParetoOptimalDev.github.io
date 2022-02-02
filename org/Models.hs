{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}

module Models where

import           Database.Persist
import           Database.Persist.TH
import Data.Int

share [mkPersist sqlSettings] [persistLowerCase|
 Order sql=orders
    Id sql=order_id
    shipName String
    deriving Show
 OrderDetail sql=order_details
    Id OrderId
    Bar OrderId
    productId Int64
    deriving Show
 Product sql=products
    ProductId sql=product_id 
    unitPrice Double
|]
