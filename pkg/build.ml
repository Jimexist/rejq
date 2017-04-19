(* http://erratique.ch/software/topkg/doc/Topkg.html#basics *)

open Topkg

let () =
  let cmd c os files =
    let ocamlbuild = Conf.tool "rebuild" os in
    OS.Cmd.run @@ Cmd.(ocamlbuild % "-use-ocamlfind"
                                  %% (v "-I" % "src")
                                  %% of_list files)
  in
  let build = Pkg.build ~cmd () in
  Pkg.describe "rejq" ~build ~change_logs:[] ~licenses:[] ~readmes:[] (fun c ->
    Ok [
      Pkg.lib "pkg/META";
      Pkg.bin ~auto:true ~dst:"test" "src/test";
    ])
