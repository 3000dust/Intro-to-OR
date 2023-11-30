# Running process
using JuMP, DataFrames, CSV, Gurobi, Missings, Plots
# Define the data path
modelpath = joinpath(@__DIR__, "..", "Model")
inputpath = joinpath(@__DIR__, "..", "Data")
outputpath = joinpath(@__DIR__, "..", "Results")

# Read CSV files
locations = CSV.read(joinpath(inputpath, "Location.csv"), DataFrame)
population_clusters = CSV.read(joinpath(inputpath, "Population_cluster.csv"), DataFrame)
hospital_levels = CSV.read(joinpath(inputpath, "Hospital_level.csv"), DataFrame)

include(joinpath(modelpath, "Functions.jl"))
include(joinpath(modelpath, "Parameters.jl"))
include(joinpath(modelpath, "Hospital_Model.jl"))

Hospital_model()