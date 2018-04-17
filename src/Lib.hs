module Lib
    ( timeTrack
    ) where


import           Commands           (add, ls)
import           System.Environment (getArgs)


cmds :: String
cmds =
    "usage: timetrack <command>\n\n" ++
        "  add  Add entry\n" ++
        "  ls   List entries"


cmdNotFound :: String -> [String] -> IO ()
cmdNotFound cmd _ = do
    putStrLn $ "No such command: " ++ cmd
    putStrLn cmds


help :: [String] -> IO ()
help _ =
    putStrLn cmds


dispatch :: String -> [String] -> IO ()
dispatch "add"    = add
dispatch "list"   = ls
dispatch "ls"     = ls
dispatch "-h"     = help
dispatch "--help" = help
dispatch cmd      = cmdNotFound cmd


timeTrack = do
    (cmd:argList) <- getArgs
    dispatch cmd argList
