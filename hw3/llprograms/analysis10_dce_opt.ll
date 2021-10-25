define i64 @main(i64 %argc, i8** %argv) {
  %1 = alloca i64
  %2 = alloca i64
  %3 = alloca i64
  %4 = alloca i64
  store i64 3, i64* %4
  %5 = alloca i64
  %6 = alloca i64
  %7 = alloca i64
  store i64 12, i64* %7
  br i1 1, label %then, label %else
then:
  %8 = alloca i64
  %9 = alloca i64
  %10 = load i64, i64* %7
  %11 = sub i64 %10, 10
  store i64 %11, i64* %7
  br label %merge

else:
  %12 = load i64, i64* %7
  %13 = add i64 %12, 10
  store i64 %13, i64* %7
  br label %merge
merge:
  %14 = load i64, i64* %7
  %15 = mul i64 %14, 30
  ret i64 %15
}
