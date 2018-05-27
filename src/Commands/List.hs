module Commands.List
    ( ls
    ) where


import           Entry   (parseLines, printEntries)
import           Helpers (loadLines)


ls :: [String] -> IO ()
ls _ =
    fmap parseLines loadLines >>= printEntries
