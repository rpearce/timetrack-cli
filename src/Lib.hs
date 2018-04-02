module Lib
    ( timeTrack
    ) where


import           Commands           (ls)
import           System.Environment (getArgs)

cmdNotFound :: String -> [String] -> IO ()
cmdNotFound cmd _ =
    putStrLn $ "The `" ++ cmd ++ "` command does not exist."

dispatch :: String -> [String] -> IO ()
dispatch "ls"   = ls
dispatch "list" = ls
dispatch cmd    = cmdNotFound cmd

timeTrack = do
    (cmd:argList) <- getArgs
    dispatch cmd argList
