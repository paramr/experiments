import Lake
open Lake DSL

package «Greeting» where
  -- add package configuration options here

lean_lib «Greeting» where
  -- add library configuration options here

@[default_target]
lean_exe «greeting» where
  root := `Main

-- build with `lake build`
-- run with `lake exe greeting`
