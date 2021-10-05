#mod_use "x86/x86.ml";;
#load "nums.cma";;
#mod_use "util/assert.ml";;
#mod_use "simulator.ml";;
#mod_use "int64_overflow.ml";;

#use "simulator.ml";;
#use "gradedtests.ml";;

let () = 
  begin
    Simulator.debug_simulator := true;
  end