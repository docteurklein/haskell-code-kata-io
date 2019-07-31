{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Scotty

import Control.Monad
import Control.Monad.Trans
import Data.Monoid
import qualified Data.ByteString.Lazy.Char8 as BT
import Data.Text.Lazy.Encoding (decodeUtf8)
import qualified Data.Text.Lazy as LT
import Data.Algorithm.Diff
import Data.Algorithm.DiffOutput


--main = scotty 3000 $
--  get "/:word" $ do
--    beam <- param "word"
--    html $ mconcat ["<h1>Scotty, ", beam, " me up!</h1>"]

main = scotty 3000 $ do
  get "/exercises/:exercise" $ do
    exercise <- param "exercise"
    --html $ mconcat ["exercises/", exercise]
    file $ mconcat ["exercises/", exercise, "/explanation"]

  get "/exercises/:exercise/input" $ do
    exercise <- param "exercise"
    file $ mconcat ["exercises/", exercise, "/input"]

  put "/exercises/:exercise/output" $ do
    exercise <- param "exercise"
    actual <- body
    let path = mconcat ["exercises/", exercise, "/expected"]
    expected <- liftIO $ readFile path
    html $ LT.pack $ ppDiff $ getGroupedDiff (lines expected) (lines $ BT.unpack actual)
    --html $ "test"
