# Hospital Model

function Hospital_model(B)
    # Initialize JuMP model with Gurobi solver
    model = Model(Gurobi.Optimizer)
    
    set_optimizer_attribute(model, "MIPGap", 0.01)
    set_optimizer_attribute(model, "TimeLimit", 91800)
    set_optimizer_attribute(model, "Method", 2)


    # Decision variable: whether to build a hospital of level k at location l
    @variable(model, b[l=1:nrow(locations), k=1:nrow(hospital_levels)], Bin)


    # Objective: Maximize total score
    @objective(model, Max, sum(b[l, k] * S[l, k] for l in 1:nrow(locations), k in 1:nrow(hospital_levels)) * 1e-3)


    # Budget Constraint
    @constraint(model, sum(b[l, k] * (hospital_levels.Construction_Cost_Million[k] * 1e6 + locations.Leveling_Cost[l]) for l in 1:nrow(locations), k in 1:nrow(hospital_levels)) <= B)

    # Unique Facility Level per Location Constraint
    @constraint(model, [l=1:nrow(locations)], sum(b[l, k] for k in 1:nrow(hospital_levels)) <= 1)

    # Facility Level Spacing Constraint for each level
    for k in 1:nrow(hospital_levels)
        for l in 1:nrow(locations)
            @constraint(model, sum(b[l_prime, k] for l_prime in 1:nrow(locations) if justification_matrices[k][l, l_prime]) <= 1)
        end
    end

    # Min Ratio Constraint
    @constraint(model, sum(b[l, 1] for l in 1:nrow(locations)) >= ratio_level_1 * sum(b[l, j] for l in 1:nrow(locations), j in 1:nrow(hospital_levels)))
    # @constraint(model, sum(b[l, 2] for l in 1:nrow(locations)) >= ratio_level_2 * sum(b[l, j] for l in 1:nrow(locations), j in 1:nrow(hospital_levels)))


    # # Capacity Contraint for Each Population Cluster
    # for p in 1:nrow(population_clusters)
    #     @constraint(model, sum(justification_matrix[l, p] * Capacity_factor * sum(hospital_levels.Bed_Capacity[k] * b[l, k] for k in 1:nrow(hospital_levels)) for l in 1:nrow(locations)) >= population_clusters.Total_Population[p])
    # end

    # Area Constraint
    for l in 1:nrow(locations)
        for k in 1:nrow(hospital_levels)
            @constraint(model, hospital_levels.Land_Use_sqm[k] * b[l, k] <= locations.Area_sqm[l])
        end
    end

    # Solve the model
    optimize!(model)

    # Output results
    total_cost = 0.0
    total_score = objective_value(model)
    println("Optimal Solution:")
    for l in 1:nrow(locations)
        for k in 1:nrow(hospital_levels)
            if value(b[l, k]) > 0.5
                println("Build facility level ", k, " at location ", l)
                total_cost += hospital_levels.Construction_Cost_Million[k] * 1e6 + locations.Leveling_Cost[l]
            end
        end
    end

    # Display the total score and total cost
    println("Total Score: ", total_score)
    println("Total Cost: ", total_cost)

    # Record the solution
    df_summary = DataFrame(
        "Total Cost" => [total_cost],
        "Total Score" => [total_score]
    )

    hospital_list = [(l, k) for l in 1:nrow(locations), k in 1:nrow(hospital_levels) if value(b[l, k]) > 0.5]
    df_hospitals = DataFrame(hospital_list, [:Location, :Level])
    return df_summary, df_hospitals
end
