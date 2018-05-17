#use "topfind"
#require "topkg-jbuilder"

open Topkg

let () =
  let files_to_watermark () =
    Pkg.files_to_watermark () >>| fun files ->
    List.filter (fun p -> Fpath.get_ext p <> ".eps") files in
  let exclude_paths () =
    Pkg.exclude_paths () >>| fun ps -> (
      "src/crlibm/docs"
      :: "src/crlibm/maple"
      :: "src/crlibm/gappa"
      :: "src/crlibm/tests" :: ps) in
  Topkg_jbuilder.describe ()
    ~distrib:(Pkg.distrib () ~files_to_watermark ~exclude_paths)
