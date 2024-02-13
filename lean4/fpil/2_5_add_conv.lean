-- Additional Conveniences

--- Nested Actions
partial def dump (stream : IO.FS.Stream) : IO Unit := do
  -- let buf <- stream.read 1024
  -- if buf.isEmpty then
  --   pure ()
  -- else
  --   let stdout <- IO.getStdout
  --   stdout.write buf
  --   dump stream
  let buf <- stream.read 1024
  if buf.isEmpty then
    pure ()
  else
    (<- IO.getStdout).write buf
    dump stream

def fileStream (filename : System.FilePath) : IO (Option IO.FS.Stream) := do
  -- let fileExists <- filename.pathExists
  -- if not fileExists then
  --   let stderr <- IO.getStderr
  --   stderr.putStrLn s!"File not found: {filename}"
  --   pure none
  -- else
  --   let handle <- IO.FS.Handle.mk filename IO.FS.Mode.read
  --   pure (some (IO.FS.Stream.ofHandle handle))
  if not (<- filename.pathExists) then
    (<- IO.getStderr).putStrLn s!"File not found: {filename}"
    pure none
  else
    pure (some (IO.FS.Stream.ofHandle (<- IO.FS.Handle.mk filename IO.FS.Mode.read)))

def getNumA : IO Nat := do
  (<- IO.getStdout).putStrLn "A"
  pure 5

def getNumB : IO Nat := do
  (<- IO.getStdout).putStrLn "B"
  pure 7

def test : IO Unit := do
  let a : Nat := if (← getNumA) == 5 then 0 else (← getNumB)
  (← IO.getStdout).putStrLn s!"The answer is {a}"

def testEq : IO Unit := do
  let x <- getNumA
  let y <- getNumB
  let a : Nat := if x == 5 then 0 else y
  (<- IO.getStdout).putStrLn s!"The answer is {a}"


#eval test

-- Flexible Layouts for do

def mainBr : IO Unit := do {
  let stdin <- IO.getStdin;
  let stdout <- IO.getStdout;

  stdout.putStrLn "How would you like to be addressed?";
  let name := (← stdin.getLine).trim;
  stdout.putStrLn s!"Hello, {name}!"
}
