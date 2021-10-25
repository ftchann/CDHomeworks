define i64 @main(i64 %argc, i8** %argv) {
  %1 = alloca i64
  %2 = alloca i64
  store i64 1, i64* %2
  br label %guard
body:
  %3 = load i64, i64* %2
  %4 = mul i64 %3, 2
  store i64 %4, i64* %2
  br label %guard
end:
  ret i64 10
guard:
  %5 = load i64, i64* %2
  %6 = icmp slt i64 %5, 10
  br i1 %6, label %body, label %end
}

