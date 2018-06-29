module Commands.List
    ( ls
    ) where


import           Entry   (listEntries, parseLines)
import           Helpers (loadLines)


ls :: [String] -> IO String
ls _ =
    fmap (listEntries . parseLines) loadLines
