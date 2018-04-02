module Commands
    ( ls
    ) where


import           Data.List        (lines, unlines)
import           System.Directory (getAppUserDataDirectory)
import           System.IO        (readFile)


ls :: [String] -> IO ()
ls _ = do
    path <- getAppUserDataDirectory "timetrack"
    contents <- readFile $ path ++ "/timetrack.txt"
    let entries = lines contents
        numberedEntries = zipWith transformEntry [1..] entries
    putStrLn "#  Date        Description"
    putStrLn "-  ----------  -----------"
    putStr $ unlines numberedEntries


transformEntry :: Integer -> String -> String
transformEntry n entry =
    let
        (date, rest) = splitAt 10 entry
        content = drop 2 rest
    in
        show n ++ "  " ++ date ++ "  " ++ content
