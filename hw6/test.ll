define i64 @program(i64 %_argc4, { i64, [0 x i8*] }* %_argv1) {
  %_x8 = alloca i64
  %_y11 = alloca i64
  store i64 12, i64* %_x8
  store i64 800, i64* %_y11
  %_x13 = load i64, i64* %_x8
  %_y14 = load i64, i64* %_y11
  %_bop15 = sub i64 %_x13, %_y14
  %_bop16 = icmp sle i64 %_bop15, 0
  br i1 %_bop16, label %_then26, label %_else25
_else25:
  %_x21 = load i64, i64* %_x8
  %_y22 = load i64, i64* %_y11
  %_bop23 = sub i64 %_x21, %_y22
  ret i64 %_bop23
_merge24:
  ret i64 0
_then26:
  %_x17 = load i64, i64* %_x8
  %_unop18 = sub i64 0, %_x17
  %_y19 = load i64, i64* %_y11
  %_bop20 = sub i64 %_unop18, %_y19
  ret i64 %_bop20
}


declare i64* @oat_malloc(i64)
declare i64* @oat_alloc_array(i64)
declare void @oat_assert_not_null(i8*)
declare void @oat_assert_array_length(i64*, i64)
declare { i64, [0 x i64] }* @array_of_string(i8*)
declare i8* @string_of_array({ i64, [0 x i64] }*)
declare i64 @length_of_string(i8*)
declare i8* @string_of_int(i64)
declare i8* @string_cat(i8*, i8*)
declare void @print_string(i8*)
declare void @print_int(i64)
declare void @print_bool(i1)