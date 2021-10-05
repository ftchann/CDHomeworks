open Big_int

type t = { value : int64; overflow : bool }

let ok i = { value = i; overflow = false }

exception Overflow

let with_overflow1 g f i =
  let res = f i in 
  { value = res
  ; overflow = not @@ eq_big_int (big_int_of_int64 res) (g @@ big_int_of_int64 i)
  } 
  
let with_overflow2 g f i j =
  let res = f i j in
  { value = res
  ; overflow = not @@ eq_big_int (big_int_of_int64 res) 
		                 (g (big_int_of_int64 i) (big_int_of_int64 j))
  } 

let neg = with_overflow1 minus_big_int Int64.neg
let succ = with_overflow1 succ_big_int Int64.succ
let pred = with_overflow1 pred_big_int Int64.pred

let lognot (x:int64) : t = 
  let res = Int64.lognot x in
  { value = res; overflow = false} 

let add = with_overflow2 add_big_int Int64.add
let sub = with_overflow2 sub_big_int Int64.sub
let mul = with_overflow2 mult_big_int Int64.mul
let logor (x:int64) (y:int64) : t = 
  let res = Int64.logor x y in
  { value = res; overflow = false} 

let logxor (x:int64) (y:int64) : t = 
  let res = Int64.logxor x y in
  { value = res; overflow = false} 

let logand (x:int64) (y:int64) : t = 
  let res = Int64.logand x y in
  { value = res; overflow = false} 

let shift_left (x:int64) (y:int) =
  let ans = Int64.shift_left x y in
  let compans = Int64.compare ans 0L in
  let compx = Int64.compare x 0L in
  let overflow = (y = 1) && ((compx < 0) && (compans > 0) || (compx > 0) && (compans < 0)) in
  { value = ans; overflow = overflow} 

let shift_right (x:int64) (y:int) =
  let ans = Int64.shift_right x y in
  let overflow = (y = 1) in
  { value = ans; overflow = overflow} 
  
let shift_right_logical (x:int64) (y:int) =
  let ans = Int64.shift_right_logical x y in
  let compans = Int64.compare ans 0L in
  let overflow = (y = 1) && (compans < 0) in
  { value = ans; overflow = overflow} 