Base.show(io::IO, g::CxxWrap.StdLib.SharedPtrAllocated{Game}) = print(io, to_string(g))
Base.show(io::IO, s::CxxWrap.StdLib.UniquePtrAllocated{State}) = print(io, to_string(s))
Base.show(io::IO, gp::Union{GameParameterAllocated, GameParameterDereferenced}) = print(io, to_repr_string(gp))

GameParameter(x::Int) = GameParameter(Ref(Int32(x)))

Base.copy(s::CxxWrap.StdLib.UniquePtrAllocated{State}) = deepcopy(s)
Base.deepcopy(s::CxxWrap.StdLib.UniquePtrAllocated{State}) = clone(s)

if Sys.KERNEL == :Linux
    function apply_action(state, actions::AbstractVector{<:Number})
        A = StdVector{CxxLong}()
        for a in actions
            push!(A, a)
        end
        apply_actions(state, A)
    end
elseif Sys.KERNEL == :Darwin
    function apply_action(state, actions::AbstractVector{<:Number})
        A = StdVector{Int}()
        for a in actions
            push!(A, a)
        end
        apply_actions(state, A)
    end
else
    @error "unsupported system"
end

function deserialize_game_and_state(s::CxxWrap.StdLib.StdStringAllocated)
    game_and_state = _deserialize_game_and_state(s)
    first(game_and_state), last(game_and_state)
end
