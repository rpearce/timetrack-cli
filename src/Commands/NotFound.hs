module Commands.NotFound
    ( notFound
    ) where


import           Commands.Help (help)


notFound :: String -> IO ()
notFound cmd = do
    putStrLn $ "No such command: " ++ cmd
    help
