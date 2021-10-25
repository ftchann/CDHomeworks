define i64 @ack(i64 %m, i64 %n) {
  %r = alloca i64
  %icm = icmp sgt i64 %m, 0
  br i1 %icm, label %mnonzero, label %mzero
mzero:
  %tmp = add i64 %n, 1
  store i64 %tmp, i64* %r
  br label %end
mnonzero:
  %icn = icmp sgt i64 %n, 0
  br i1 %icn, label %nnonzero, label %nzero
nzero:
  %msub = sub i64 %m, 1
  %tmp2 = call i64 @ack(i64 %msub, i64 1)
  store i64 %tmp2, i64* %r
  br label %end
nnonzero:
  %msub2 = sub i64 %m, 1
  %nsub = sub i64 %n, 1
  %newn = call i64 @ack(i64 %m, i64 %nsub)
  %tmp3 = call i64 @ack(i64 %msub2, i64 %newn)
  store i64 %tmp3, i64* %r
  br label %end
end:
  %rv1 = load i64, i64* %r
  ret i64 %rv1
}

define i64 @main(i64 %argc, i8** %argv) {
  %ans = call i64 @ack(i64 2, i64 2)
  ret i64 %ans
}
