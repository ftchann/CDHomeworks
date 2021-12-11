define i64 @program(i64 %_argc4, { i64, [0 x i8*] }* %_argv1) {
  %_x7 = alloca { i64, [0 x i64] }*
  %_z9 = alloca i64
  store { i64, [0 x i64] }* null, { i64, [0 x i64] }** %_x7
  store i64 0, i64* %_z9
  %_x11 = load { i64, [0 x i64] }*, { i64, [0 x i64] }** %_x7
  %_cast15 = icmp eq { i64, [0 x i64] }* %_x11, null
  br i1 %_cast15, label %_null18, label %_notnull17
_merge16:
  %_z20 = load i64, i64* %_z9
  ret i64 %_z20
_notnull17:
  store i64 4, i64* %_z9
  br label %_merge16
_null18:
  store i64 5, i64* %_z9
  br label %_merge16
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