module OpenSpiel

include("$(@__DIR__)/../deps/deps.jl")
libspieljl = LIB_OPEN_SPIEL 
# using OpenSpiel_jll
# libspieljl = "/root/test/Yggdrasil/O/OpenSpiel/products/lib/libspieljl.so"

using CxxWrap
import CxxWrap:argument_overloads
import Base: step, first, last

@wrapmodule(libspieljl)

include("patch.jl")

# export all
for n in names(@__MODULE__(); all=true)
    if Base.isidentifier(n) &&
        !startswith(String(n), "_") &&
        n ∉ (Symbol(@__MODULE__()), :eval, :include)
        @eval export $n
    end
end


function __init__()
    @initcxx
end

end
