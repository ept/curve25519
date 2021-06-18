set table "curve25519.neg2.table"; set format "%.5f"
set samples 100.0; plot [x=0:1.6] -sqrt(x**3 - 1.9*x**2 + x)
