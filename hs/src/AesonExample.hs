{-# LANGUAGE OverloadedStrings #-}

import           Control.Applicative
import           Data.Aeson
import           Data.Aeson.Types
import qualified Data.ByteString.Lazy.Char8 as L
import           Test.QuickCheck                       as  QC

-- | Our internal data type
data Message = Message { id    :: Int
                       , text  :: String}    deriving (Eq, Show)

-- | Will help us to generate JSON, 
--   e.g. {"id": 1, "text": "example"}
instance ToJSON Message where
    toJSON (Message id text) = object
        [ "id"    .= id
        , "text"  .= text]

instance FromJSON Message where
    parseJSON (Object v) = 
        Message <$> (v .: "id"     )
                <*> (v .: "text"   )

-- Test whether the conversion works

instance QC.Arbitrary Message where
    arbitrary = Message <$> QC.arbitrary <*> QC.arbitrary <*> QC.arbitrary

prop_MessageJSON :: Message -> Bool
prop_MessageJSON o = (((decode . encode) (Just o)) == (Just o))


main :: IO ()
main = do
    L.putStrLn $ encode $ Message 1 "message text" ""
    QC.quickCheck prop_MessageJSON
