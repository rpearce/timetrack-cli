module Commands.NotFound
    ( notFound
    ) where


import           Commands.Help (help)


notFound :: String -> a -> IO ()
notFound cmd _ = do
    putStrLn $ "No such command: " ++ cmd
    help Nothing
