{-# language BlockArguments #-}
{-# language DeriveAnyClass #-}
{-# language DeriveGeneric #-}
{-# language DerivingStrategies #-}
{-# language DerivingVia #-}
{-# language DuplicateRecordFields #-}
{-# language GeneralizedNewtypeDeriving #-}
{-# language OverloadedStrings #-}
{-# language StandaloneDeriving #-}
{-# language TypeApplications #-}
{-# language TypeFamilies #-}

module Rel8models where

import Data.Text
import GHC.Generics
import Rel8 hiding (Order)
import Data.Int
import Hasql.Connection ( Connection, acquire, release )

data Order f = Order
  { orderId :: Column f OrderId
  , shipName     :: Column f Text
  }
  deriving stock (Generic)
  deriving anyclass (Rel8able)

newtype OrderId = OrderId { toInt64 :: Int64 }
  deriving newtype (DBEq, DBType, Eq, Show)

deriving stock instance f ~ Result => Show (Order f)

orderSchema :: TableSchema (Order Name)
orderSchema = TableSchema
  { name = "orders"
  , schema = Nothing
  , columns = Order
      { orderId = "order_id"
      , shipName = "ship_name"
      }
  }

data OrderDetails f = OrderDetails
  { orderDetailsId :: Column f OrderId
  , orderProductId     :: Column f ProductsId
  }
  deriving stock (Generic)
  deriving anyclass (Rel8able)


deriving stock instance f ~ Result => Show (OrderDetails f)

orderDetailsSchema :: TableSchema (OrderDetails Name)
orderDetailsSchema = TableSchema
  { name = "order_details"
  , schema = Nothing
  , columns = OrderDetails
      { orderDetailsId = "order_id"
      , orderProductId = "product_id"
      }
  }

data Products f = Products
  { productsId :: Column f ProductsId
  , productUnitPrice     :: Column f Int64
  }
  deriving stock (Generic)
  deriving anyclass (Rel8able)

newtype ProductsId = ProductsId { toInt64 :: Int64 }
  deriving newtype (DBEq, DBType, Eq, Show)

deriving stock instance f ~ Result => Show (Products f)

productsSchema :: TableSchema (Products Name)
productsSchema = TableSchema
  { name = "products"
  , schema = Nothing
  , columns = Products
      { productsId = "product_id"
      , productUnitPrice = "unit_price"
      }
  }
