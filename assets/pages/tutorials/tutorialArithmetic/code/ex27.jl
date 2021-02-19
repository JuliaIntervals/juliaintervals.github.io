# This file was generated, do not modify it. # hide
a = sqrt(2) .. sqrt(3)
@show a

setformat(:full)
@show a

setformat(:midpoint)
@show a
setformat(:standard)

setformat(sigfigs=10)
@show a