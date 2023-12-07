# Strategic Decision for Potential Healthcare Facility Expansion in Baltimore County and Baltimore City

## Motivation
Access to healthcare, a fundamental human right, is impacted by disparities between rural and urban areas. Studies show significant health inequities linked to social determinants of health (SDOH). Rural areas often suffer from a 'mortality penalty,' with residents facing shorter lifespans and higher disease rates than urban counterparts. This is due to factors like socioeconomic status, healthcare accessibility, and ambulatory care quality. Urban areas, despite better healthcare infrastructure, face challenges like economic disparities and cultural barriers. Our project seeks to mitigate these disparities by optimizing healthcare facility placement, ensuring equitable access for all population groups.

## Project Description
Focused on Baltimore County, this project aims to enhance healthcare access by strategically expanding medical facilities. It utilizes an optimization model to ensure fair distribution of healthcare resources, especially in underserved areas. The model considers location, capacity, budget constraints, and population needs to guide the establishment of new facilities. Our approach provides actionable insights for equitable healthcare infrastructure, ensuring fair access to essential health services.

This README file outlines the project, its goals, and instructions for system use.

## Running Process
Navigate to the Model folder and run the `Run.jl` script. This will include the necessary Julia files and generate results. Ensure all required packages are installed beforehand. The dependencies are detailed below:

### Functions.jl
Contains functions for calculating distances from coordinates, location scoring, and result recording.

### Set parameters.jl
Stores parameters for the model. The `parameters.jl` file includes variables like land cost (C_l), capacity factor (F_k), and minimum facility ratios (R_k) that can be adjusted for different scenarios.

### Hospital_Model.jl
Houses the mathematical model formulation.

### Output Results
Execute `run.jl` to set or use the existing budget (B_i). The results are stored in the result folder, categorized by each scenario.

## Documentation
### Data
Includes CSV files detailing hospital configurations, potential locations, and population distribution. These files provide parameters like required land area (A_k) for each hospital level and construction costs (C_k).

### Model
`Function.jl` creates essential functions, including distance calculations (`haversine`) and scoring based on distance (`score_by_distance`). It also includes a function to output results (`record_result`).

`Parameter.jl` processes parameters for use in `Hospital_Model.jl`, which initializes the JuMP model with the Gurobi solver. It sets constraints for budget, facility spacing, capacity, and area. The Gurobi optimizer is used to solve the model and output results.
