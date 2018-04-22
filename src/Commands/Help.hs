module Commands.Help
    ( help
    ) where


cmds :: String
cmds =
    "usage: timetrack <command>\n\n" ++
        "  add  Add entry\n" ++
        "  ls   List entries"


help :: IO ()
help =
    putStrLn cmds
