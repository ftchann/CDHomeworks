define i64 @foo(i64 %p1, i64 %p2) {
  ret i64 %p1
}

define i64 @bar(i64 %x, i64 %y) {
  %sx = alloca i64
  store i64 %x, i64* %sx
  %sy = alloca i64
  store i64 %y, i64* %sy
  %i1 = add i64 0, 2
  %i2 = add i64 0, 3
  %v1 = add i64 %x, %y
  %v2 = sub i64 %v1, 2
  %v3 = mul i64 %v2, 3
  br label %l1
l1:
  %a1 = alloca i64
  store i64 0, i64* %a1
  %arg1 = add i64 0, 12
  %v4 = call i64 @foo(i64 12, i64 2)
  ret i64 %v3
}

define i64 @main(i64 %argc, i8** %arcv) {
  %res = call i64 @bar(i64 5, i64 9)
  ret i64 %res
}


