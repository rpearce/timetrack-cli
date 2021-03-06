module Timetrack
    ( timeTrack
    ) where


import           Commands.Add       (add)
import           Commands.Dir       (dir)
import           Commands.Help      (help)
import           Commands.List      (ls)
import           Commands.NotFound  (notFound)
import           Commands.Remove    (rm)
import           Commands.Update    (update)
import           Helpers            (mConst)
import           System.Environment (getArgs)


dispatch :: String -> [String] -> IO String
dispatch "add"       = add
dispatch "directory" = dir
dispatch "dir"       = dir
dispatch "list"      = ls
dispatch "ls"        = ls
dispatch "remove"    = rm
dispatch "rm"        = rm
dispatch "update"    = update
dispatch "u"         = update
dispatch "help"      = mConst help
dispatch "-h"        = mConst help
dispatch "--help"    = mConst help
dispatch cmd         = mConst $ notFound cmd ++ "\n" ++ help


parse :: [String] -> IO String
parse (cmd:argList) = dispatch cmd argList
parse _             = return help


timeTrack :: IO ()
timeTrack =
    putStr =<< parse =<< getArgs
