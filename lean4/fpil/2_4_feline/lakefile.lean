import Lake
open Lake DSL

package «feline» where
  -- add package configuration options here

@[default_target]
lean_exe «feline» where
  root := `Main

-- build with `lake build`
-- run with `lake exe feline lakefile.lean`
