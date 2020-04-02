__precompile__()

module IRKGaussLegendre

using Reexport
@reexport using DiffEqBase

using LinearAlgebra,StaticArrays
using Parameters
using OrdinaryDiffEq
using Printf
using DoubleFloats

const CompiledFloats = Union{Float32,Float64}

include("IRKGL16Solver.jl")

export IRKGL16,IRKAlgorithm
export tcoeffs, CompiledFloats

end # module