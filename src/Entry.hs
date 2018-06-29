module Entry
    ( Entry ( Entry
            , date
            , index
            , message
            )
    , listEntries
    , nextRowNum
    , parseLines
    , showEntry
    , showOutput
    ) where


data Entry = Entry
    { index   :: Integer
    , date    :: String
    , message :: String
    } deriving (Show)


showEntry :: Entry -> String
showEntry (Entry i d m) =
    prettyIndex i ++ "  " ++ d ++ "  " ++ m


prettyIndex :: Integer -> String
prettyIndex n
    | n < 10    = "0" ++ show n
    | otherwise = show n


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


listEntries :: [Entry] -> String
listEntries =
    unlines . fmap showEntry


showOutput :: Entry -> String
showOutput entry =
    date entry ++ " " ++ message entry
