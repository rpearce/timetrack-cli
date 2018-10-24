module Entry
    ( Entry ( Entry
            , date
            , message
            )
    , loadEntries
    , parse
    , position
    , outputEntry
    , showEntriesWithIndex
    , showEntryWithIndex
    , showEntry
    , sortByDate
    ) where


import           Data.List (elemIndex, sortOn)
import           Helpers   (loadLines)


data Entry = Entry
    { date    :: String
    , message :: String
    } deriving (Eq, Show)


loadEntries :: FilePath -> IO [Entry]
loadEntries path =
    fmap (fmap parse) (loadLines path)


outputEntry :: Entry -> String
outputEntry (Entry d m) =
    d ++ " " ++ m


parse :: String -> Entry
parse line =
    let
        (d, rest) = splitAt 10 line
        m = drop 1 rest
    in
        Entry { date = d, message = m }


position :: Entry -> [Entry] -> Integer
position entry =
    fromIntegral . maybe 0 (+1) . elemIndex entry


prettyIndex :: Integer -> String
prettyIndex n
    | n < 10    = "0" ++ show n
    | otherwise = show n


sortByDate :: [Entry] -> [Entry]
sortByDate =
    sortOn date


showEntriesWithIndex :: [Entry] -> [String]
showEntriesWithIndex =
    zipWith showEntryWithIndex [1..]


showEntryWithIndex :: Integer -> Entry -> String
showEntryWithIndex idx entry =
    prettyIndex idx ++ "  " ++ showEntry entry


showEntry :: Entry -> String
showEntry (Entry d m) =
    d ++ "  " ++ m
