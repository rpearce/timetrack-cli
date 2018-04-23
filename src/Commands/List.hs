module Commands.List
    ( ls
    ) where


import           Entry   (parseLines, printEntries)
import           Helpers (loadLines)


ls :: [String] -> IO ()
ls _ = do
    loadedLines <- loadLines
    putStrLn "#  Date        Description"
    putStrLn "-  ----------  -----------"
    printEntries $ parseLines loadedLines
