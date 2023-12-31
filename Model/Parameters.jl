# Parameter processing 

# Hospital level multiplier
level_multiplier = Dict(1 => 1, 2 => 4, 3 => 10, 4 => 20)

# Calculate scores S_l,k
S = Dict()
for location in eachrow(locations)
    for k in 1:nrow(hospital_levels)  # Assuming 4 levels of hospitals
        total_score = 0.0
        for cluster in eachrow(population_clusters)
            distance = haversine(location.Latitude, location.Longitude, cluster.Latitude, cluster.Longitude)
            dist_score = score_by_distance(distance)
            weighted_score = dist_score * cluster.Elderly_Rate * cluster.Total_Population
            total_score += weighted_score
        end
        S[(location.Location_Index, k)] = total_score * level_multiplier[k]
    end
end



# Calculate leveling cost
leveling_cost_per_sqm = 59 # Assume $59 per square meter
locations.Leveling_Cost = locations.Area_sqm .* leveling_cost_per_sqm



# Distance justification for location pairs
num_locations = nrow(locations)
distance_matrix = zeros(num_locations, num_locations)

# Populate the distance matrix
for l in 1:num_locations
    for l_prime in 1:num_locations
        if l != l_prime
            distance_matrix[l, l_prime] = haversine(locations.Latitude[l], locations.Longitude[l], 
                                                    locations.Latitude[l_prime], locations.Longitude[l_prime])
        end
    end
end

# Distance thresholds for each level
distance_thresholds = Dict(1 => 2000, 2 => 5000, 3 => 10000, 4 => 15000)

# Initialize justification matrices for each level
justification_matrices = Dict(k => zeros(Bool, num_locations, num_locations) for k in 1:nrow(hospital_levels))

# Populate the justification matrices using the distance matrix
for k in keys(justification_matrices)
    for l in 1:num_locations
        for l_prime in 1:num_locations
            if distance_matrix[l, l_prime] <= distance_thresholds[k]
                justification_matrices[k][l, l_prime] = true
            end
        end
    end
end



# Distance justification for location-population cluster pairs
num_population_clusters = nrow(population_clusters)
loc_pop_distance_matrix = zeros(num_locations, num_population_clusters)

# Populate the distance matrix
for l in 1:num_locations
    for p in 1:num_population_clusters
        loc_pop_distance_matrix[l, p] = haversine(locations.Latitude[l], locations.Longitude[l], 
                                                  population_clusters.Latitude[p], population_clusters.Longitude[p])
    end
end

# Threshold for the justification matrix (Assume 20km now)
distance_threshold = 20000

# Initialize the justification matrix
justification_matrix = zeros(Bool, num_locations, num_population_clusters)

# Populate the justification matrix
for l in 1:num_locations
    for p in 1:num_population_clusters
        justification_matrix[l, p] = loc_pop_distance_matrix[l, p] <= distance_threshold
    end
end



# Minimum ratio requirements
ratio_level_1 = 0.2 # Assume Level 1 facilities should be at least 20% of all new facilities
ratio_level_2 = 0.1 # Assume Level 2 facilities should be at least 10% of all new facilities



# Capacity factor
Capacity_factor = 250 # 4 people will share 1000 beds
Existing_hospital_capacity = Capacity_factor*6620 # Total 6620 beds for existing lv2,3,4 hospital