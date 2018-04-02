module Commands
    ( ls
    ) where


import           Data.List        (intercalate, lines, unlines)
import           Data.List.Split  (splitOn)
import           Helpers          (showLineN)
import           System.Directory (getAppUserDataDirectory)
import           System.IO        (readFile)


ls :: [String] -> IO ()
ls _ = do
    path <- getAppUserDataDirectory "timetrack"
    contents <- readFile $ path ++ "/timetrack.txt"
    let entries = lines contents
        transform = intercalate "  " . splitOn ","
        transformed = fmap transform entries
        numberedEntries = zipWith showLineN [1..] transformed
    putStrLn "#  Date        Description"
    putStrLn "-  ----------  -----------"
    putStr $ unlines numberedEntries
