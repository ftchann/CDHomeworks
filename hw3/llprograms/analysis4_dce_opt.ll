define i64 @main(i64 %argc, i8** %arcv) {
  %1 = alloca i64
  %2 = add i64 42, %argc
  %3 = alloca i64
  store i64 49, i64* %3
  br label %l1
l1:
  %4 = alloca i64
  %5 = load i64, i64* %3
  %6 = bitcast i64* %3 to i8*
  %7 = alloca i64
  %8 = sub i64 %5, 3
  store i64 %8, i64* %3
  %9 = icmp sgt i64 %8, 0
  br i1 %9, label %l1, label %l2
l2:
  %10 = load i64, i64* %3
  ret i64 %10
}

