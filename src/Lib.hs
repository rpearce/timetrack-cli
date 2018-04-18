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
dispatch "-h"     = help
dispatch "--help" = help
dispatch cmd      = notFound cmd


timeTrack = do
    (cmd:argList) <- getArgs
    dispatch cmd argList
