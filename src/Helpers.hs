module Helpers
    ( showLineN
    ) where


showLineN :: Integer -> String -> String
showLineN n line =
    show n ++ "  " ++ line
