declare i64 @ll_calls_foo()

; this is clang -emit-llvm -S c_weighted_sum.c and simplified
define i64 @foo(i64 %0, i64 %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6, i64 %7) {
  %9 = alloca i64
  %10 = alloca i64
  %11 = alloca i64
  %12 = alloca i64
  %13 = alloca i64
  %14 = alloca i64
  %15 = alloca i64
  %16 = alloca i64
  %17 = alloca i64
  store i64 %0, i64* %9
  store i64 %1, i64* %10
  store i64 %2, i64* %11
  store i64 %3, i64* %12
  store i64 %4, i64* %13
  store i64 %5, i64* %14
  store i64 %6, i64* %15
  store i64 %7, i64* %16
  store i64 0, i64* %17
  %18 = load i64, i64* %9
  %19 = mul i64 %18, 1
  %20 = load i64, i64* %17
  %21 = add i64 %20, %19
  store i64 %21, i64* %17
  %22 = load i64, i64* %10
  %23 = mul i64 %22, 2
  %24 = load i64, i64* %17
  %25 = add i64 %24, %23
  store i64 %25, i64* %17
  %26 = load i64, i64* %11
  %27 = mul i64 %26, 3
  %28 = load i64, i64* %17
  %29 = add i64 %28, %27
  store i64 %29, i64* %17
  %30 = load i64, i64* %12
  %31 = mul i64 %30, 4
  %32 = load i64, i64* %17
  %33 = add i64 %32, %31
  store i64 %33, i64* %17
  %34 = load i64, i64* %13
  %35 = mul i64 %34, 5
  %36 = load i64, i64* %17
  %37 = add i64 %36, %35
  store i64 %37, i64* %17
  %38 = load i64, i64* %14
  %39 = mul i64 %38, 6
  %40 = load i64, i64* %17
  %41 = add i64 %40, %39
  store i64 %41, i64* %17
  %42 = load i64, i64* %15
  %43 = mul i64 %42, 7
  %44 = load i64, i64* %17
  %45 = add i64 %44, %43
  store i64 %45, i64* %17
  %46 = load i64, i64* %16
  %47 = mul i64 %46, 8
  %48 = load i64, i64* %17
  %49 = add i64 %48, %47
  store i64 %49, i64* %17
  %50 = load i64, i64* %17
  ret i64 %50
}

define i64 @main(i64 %argc, i8** %argv) {
  %result = call i64 @ll_calls_foo()
  ret i64 %result
}
