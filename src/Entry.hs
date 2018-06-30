module Entry
    ( Entry ( Entry
            , date
            , index
            , message
            )
    , lastEntryFromString
    , listEntries
    , loadEntries
    , nextRowNum
    , parseLines
    , showEntry
    , showOutput
    ) where


import           Helpers (loadLines)


data Entry = Entry
    { index   :: Integer
    , date    :: String
    , message :: String
    } deriving (Show)


lastEntryFromString :: String -> String
lastEntryFromString =
    showEntry . last . parseLines . lines


listEntries :: [Entry] -> String
listEntries =
    unlines . fmap showEntry


loadEntries :: FilePath -> IO [Entry]
loadEntries path =
    fmap parseLines (loadLines path)


nextRowNum :: [Entry] -> Integer
nextRowNum =
    succ . fromIntegral . length


parse :: Integer -> String -> Entry
parse n line =
    let
        (date, rest) = splitAt 10 line
        message = drop 1 rest
    in
        Entry { index = n, date = date, message = message }


parseLines :: [String] -> [Entry]
parseLines =
    zipWith parse [1..]


prettyIndex :: Integer -> String
prettyIndex n
    | n < 10    = "0" ++ show n
    | otherwise = show n


showEntry :: Entry -> String
showEntry (Entry i d m) =
    prettyIndex i ++ "  " ++ d ++ "  " ++ m


showOutput :: Entry -> String
showOutput entry =
    date entry ++ " " ++ message entry
