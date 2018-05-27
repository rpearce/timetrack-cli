module Entry
    ( Entry ( Entry
            , date
            , index
            , message
            )
    , nextRowNum
    , parseLines
    , printEntries
    , showEntry
    , showOutput
    ) where


import           System.IO (readFile)


data Entry = Entry
    { index   :: Integer
    , date    :: String
    , message :: String
    } deriving (Show)


showEntry :: Entry -> String
showEntry (Entry index date message) =
    prettyIndex index ++ "  " ++ date ++ "  " ++ message


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


printEntries :: [Entry] -> IO ()
printEntries =
    putStrLn . unlines . fmap showEntry


showOutput :: Entry -> String
showOutput entry =
    date entry ++ " " ++ message entry
