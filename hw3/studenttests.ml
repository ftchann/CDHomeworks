open Assert
open Gradedtests
   
(* These tests are provided by you -- they will not be graded *)

(* You should also add additional test cases here to help you   *)
(* debug your program.                                          *)

let read_whole_file filename =
    let ch = open_in filename in
    let s = really_input_string ch (in_channel_length ch) in
    close_in ch;
    s

let contains s1 s2 =
    let re = Str.regexp_string s2
    in
        try ignore (Str.search_forward re s1 0); true
        with Not_found -> false


let compare_clang_to_ours () =
  let open Driver in
  let files = Array.to_list @@ Sys.readdir "llprograms" in
  let files = List.map ((^) "llprograms/") files in
  let files = (List.filter (fun s -> Filename.check_suffix s ".ll" && not @@ Sys.is_directory (s)) files) in
  let files2 = Array.to_list @@ Sys.readdir "llprograms/sp20_hw3" in
  let files2 = List.map ((^) "llprograms/sp20_hw3/") files2 in
  let files2 = (List.filter (fun s -> Filename.check_suffix s ".ll" && not @@ Sys.is_directory (s)) files2) in
  List.iter (fun f ->
    try 
      print_endline @@ "Processing file " ^ f;

      let file_content = read_whole_file f in
      if (String.equal f "llprograms/args1.ll") then 
        print_endline "Skipping file because it contains @puts - thus is some broken program" else
      if contains file_content "@ll_puts" then () else 
      if contains file_content "@program" then begin
        print_endline "Skipping file because it contains @program - thus is some broken program";
        ()
      
      end else begin



        let files_to_process = [f] in
        let args = "arg1 arg2" in

        link_files := ["cinterop.c"; "c_weighted_sum.c"];
        clang := false;
        (* let interpretation_result = int_of_string (Driver.interpret (Driver.parse_ll_file f) []) in *)
        process_files files_to_process;
        Platform.link (List.rev !link_files) !executable_filename;
        let compilation_result = run_executable args !executable_filename in

        link_files := ["cinterop.c"; "c_weighted_sum.c"];
        clang := true;

        process_files files_to_process;
        Platform.link (List.rev !link_files) !executable_filename;
        let clang_result = run_executable args !executable_filename in
        if compilation_result <> clang_result then
          failwith (f ^"Clang: " ^ (string_of_int clang_result) ^", Comp: " ^ (string_of_int compilation_result));
        
        ()
      end
    with
      | Failure a -> failwith a
      | a -> print_endline ("error happened with file: " ^ f);
             print_endline (Printexc.to_string a)
  ) (files2 @ files);
  ()


let arithmetic_tests =
  [ "llprograms/add_twice.ll", 29L 
  ; "llprograms/sub_neg.ll", 255L (* Why, oh why, does the termianl only report the last byte? *)
  ; "llprograms/arith_combo.ll", 4L
  ; "llprograms/gcd_euclidian.ll", 2L
  ; "llprograms/return_intermediate.ll", 18L ]



let c_link_tests = 
  [ ["c_weighted_sum.c"], "llprograms/weighted_sum.ll", [], 204L 
  ; ["c_mine_c_conv_argpos.c"], "llprograms/mine_c_conv_argpos.ll", [], 204L ]

let binary_search_tests =
  [ "llprograms/binarysearch.ll", 8L]

let provided_tests : suite = [
    Test ("Binary Search Tests",
                executed binary_search_tests
    );
    Test ("Arithmetic Tests",
                executed arithmetic_tests
    );
    Test ("C Interoperability / System V AMD64 ABI Tests",
                Gradedtests.executed_c_link c_link_tests
    );
    Test ("Clang same as ours", [
      ("testing all files", compare_clang_to_ours)
    ]);
  ]
