module Lib
    ( timeTrack
    ) where


import           Commands.Add       (add)
import           Commands.Help      (help)
import           Commands.List      (ls)
import           Commands.NotFound  (notFound)
import           System.Environment (getArgs)


dispatch :: String -> [String] -> IO ()
dispatch "add"    = add
dispatch "list"   = ls
dispatch "ls"     = ls
dispatch "-h"     = const help
dispatch "--help" = const help
dispatch cmd      = const $ notFound cmd


parse :: [String] -> IO ()
parse (cmd:argList) = dispatch cmd argList
parse _             = help


timeTrack =
    getArgs >>= parse
