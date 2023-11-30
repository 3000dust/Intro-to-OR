# Create necessary functions used in the model

# Function to convert degrees to radians
function deg2rad(deg)
    return deg * π / 180
end

# Haversine function to calculate distance
function haversine(lat1, lon1, lat2, lon2)
    R = 6371000 # Radius of the Earth in meters

    # Convert latitude and longitude from degrees to radians
    lat1_rad = deg2rad(lat1)
    lon1_rad = deg2rad(lon1)
    lat2_rad = deg2rad(lat2)
    lon2_rad = deg2rad(lon2)

    # Difference in coordinates
    dlat = lat2_rad - lat1_rad
    dlon = lon2_rad - lon1_rad

    # Haversine formula
    a = sin(dlat / 2)^2 + cos(lat1_rad) * cos(lat2_rad) * sin(dlon / 2)^2
    c = 2 * atan(sqrt(a), sqrt(1 - a))

    return R * c # Distance in meters
end

# Scoring function based on distance
function score_by_distance(distance)
    if distance <= 3000
        return 5
    elseif distance <= 7000
        return 4
    elseif distance <= 12000
        return 3
    elseif distance <= 18000
        return 2
    else
        return 1
    end
end