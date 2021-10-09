#mod_use "x86/x86.ml";;
#load "nums.cma";;
#mod_use "int64_overflow.ml";;
#mod_use "util/assert.ml";;
#mod_use "simulator.ml";;

#use "simulator.ml";;
#use "gradedtests.ml";;
#use "providedtests.ml";;
#use "studenttests.ml";;
let () = 
  begin
    Simulator.debug_simulator := true;
  end