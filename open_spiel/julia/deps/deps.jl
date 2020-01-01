const LIB_OPEN_SPIEL = begin
    lib_path = "$(dirname(@__FILE__))/../../../build/julia/libspieljl"
    if !isfile(lib_path)
        @error "libspieljl not found. Please check the build status!"
    end
    lib_path
end