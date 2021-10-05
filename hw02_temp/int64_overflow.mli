exception Overflow

type t = { value : int64; overflow : bool }

val ok : int64 -> t

val neg : int64 -> t
val succ : int64 -> t
val pred : int64 -> t
val lognot : int64 -> t

val add : int64 -> int64 -> t
val sub : int64 -> int64 -> t
val mul : int64 -> int64 -> t
val logor : int64 -> int64 -> t
val logxor : int64 -> int64 -> t
val logand : int64 -> int64 -> t
val shift_left : int64 -> int -> t
val shift_right : int64 -> int -> t
val shift_right_logical : int64 -> int -> t
