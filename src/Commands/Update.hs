module Commands.Update
    ( update
    ) where


import           Commands.Add    (add)
import           Commands.Remove (rm)
import qualified Entry           as E
import           Helpers         (getFilePath, indentedOutput,
                                  updateFileContent)
import           Text.Read       (readMaybe)


forHelp :: String
forHelp =
    "For help: timetrack update --help"


noArgs :: String
noArgs =
    "No arguments provided.\n" ++ forHelp


lineNotFound :: String
lineNotFound =
    "Line not found.\n" ++ forHelp


usage :: String
usage =
    "Usage: timetrack update <LINE NUMBER> <DATE> <MESSAGE>"


validLineNum :: String
validLineNum =
    "Invalid line number provided.\n" ++ forHelp


update :: [String] -> IO String
update []                 = return noArgs
update ["-h"]             = return usage
update ["--help"]         = return usage
update [n, date, message] = handleUpdate (n, date, message)
update _                  = return usage


-- @TODO: safely do all this
handleUpdate :: (String, String, String) -> IO String
handleUpdate (n, date, message) = do
    path <- getFilePath
    _ <- rm [n]
    add [date, message]
