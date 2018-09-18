-- !!! testing hGetLine

import System.IO

-- one version of 'cat'
main = do
  let loop h = do b <- hIsEOF h
                  if b then return ()
                       else do l <- hGetLine h; putStrLn l; loop h
  loop stdin

  h <- openFile "hGetLine001.hs" ReadMode

  hSetBinaryMode stdout True

  hSetBuffering h NoBuffering
  loop h

  hSeek h AbsoluteSeek 0
  hSetBuffering h LineBuffering
  loop h

  hSeek h AbsoluteSeek 0
  hSetBuffering h (BlockBuffering (Just 83))
  loop h
