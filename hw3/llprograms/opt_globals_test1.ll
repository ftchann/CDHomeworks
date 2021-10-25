@x = global i64 1
@y = global i64 2

define i64 @main(i64 %argc, i8** %arcv) {
  store i64 5, i64* @y
  ret i64 5
}

