# Strategic Decision for Potential Healthcare Facility Expansion in Baltimore County and Baltimore City
## Motivation
Access to healthcare, a fundamental human right, is marred by disparities between different geographical locations. Studies have demonstrated significant health inequities between rural and urban settings, emphasizing the role of social determinants of health (SDOH) in shaping these disparities. Rural areas face a ’mortality penalty’ with residents experiencing shorter lifespans and higher rates of diseases compared to urban counterparts, attributable to socioeconomic factors, healthcare accessibility, and quality of ambulatory care. Urban areas, while better resourced in terms of healthcare infrastructure, are not immune to healthcare challenges. Economic disparities, cultural barriers, and a lack of awareness significantly influence healthcare access in both rural and urban landscapes, impacting marginalized communities the most. This project is motivated by the urgent need to address these disparities through optimized healthcare facility placement, ensuring equitable access to healthcare services for all population clusters.
## Project Description
This project, centred in Baltimore County, is dedicated to enhancing healthcare access through the strategic expansion of medical facilities. It involves developing an optimization model to maximize accessibility and fairness in healthcare facility distribution, particularly focusing on underserved areas within the county. By utilizing localized data and understanding the unique challenges and opportunities, the project aims to guide the construction of new healthcare facilities within a set budget. The model takes into account factors such as location, capacity, budget constraints, and population needs, all with the goal of bridging the healthcare accessibility gap in both rural and urban areas of Baltimore County. This approach is designed to provide actionable insights for the establishment of equitable healthcare infrastructures, ensuring that all residents have fair access to essential health services.

This README file provides an overview of the project, its objectives, and instructions for using the system.

## Installation
### Install Visual Studio Code:

Download VSCode: Visit the official Visual Studio Code website and download the installer for your operating system (Windows, macOS, or Linux).

Install VSCode: Follow the installation instructions for your operating system.

### Install Julia Extension for Visual Studio Code:

Open VSCode: Launch Visual Studio Code.

Go to Extensions: Click on the Extensions icon on the sidebar (or use Ctrl + Shift + X).

Search for Julia Extension: In the Extensions view, search for "julia" in the search bar.

Install Julia Extension: Find the "Julia Programming Language" extension, click on it, and then click the "Install" button.

### Open The Julia Package:
Open Project Folder in VSCode:
Open Visual Studio Code and click on "File" > "Open Folder...". Select the folder where the Julia project is located and click "Open."

Configure Julia Environment: 
Installing the required packages using Julia's package manager. 

Input 'using Pkg' in the terminal.
Use codes--Pkg.add("JuMP"), Pkg.add("DataFrames"), Pkg.add("CSV"), Pkg.add("Gurobi") make sure Gurobi is already installed with a license, Pkg.add("Missings"), Pkg.add("Plots")

### Run Julia Code:
#### Set parameters: 
Open the parameter.jl file in the folder. The following parameters are available for change in different scenarios:

C_l & Cost for land at location l.

F_k & Capacity factor of a level k facility.

R_k & Required minimum ratio for constructing new facilities at level k.

S_{l,k} & Evaluation score for a potential location l with a level k facility.
#### Output results: 
Open the run.jl file in the folder. Redefine B_i & Budget allocated for expansion scenario i or using existing one. Run the run.jl.
Output results are stored in the result folder in the project folder corresponding to each scenario.

## Documentation
### Data
This folder includes three CSV files. The hospital-level file includes the hospital configuration the team created. It is classified by its bed number, and construction cost is calculated based on the area required for each hospital level.
The Location file includes the potential locations with their coordinates and areas. The Population cluster file contains the population distribution. These files provide parameters for A_k, the required land area for a Level-k healthcare facility and A_l, the Land area of location l. Also, it provides value for C_k, the Construction cost for a healthcare facility at level k. The location of the population cluster is later used to give a score to each potential hospital.
### Model
Function.jl is used to create necessary functions used in the model. The checkpath() function checks if the output/input path exists, and the haversine(lat1, lon1, lat2, lon2) function is used to calculate the distance between two coordinates. The score_by_distance gives a scoring function based on distance, and the function record_result(scenario, df_summary, df_hospitals, outputpath) is used to output the result based on different scenarios.

Parameter.jl processes the parameters and stores them into variables that can be later called by Hosipital_Model.jl.

Hosipital_Model.jl initialize JuMP model with Gurobi solver. It sets constraints for Budget, Unique Facility Level per Location, Facility Level Spacing for each level, Facility Capacity for Each Population Cluster, minimum ratio for each hospital, and new Facilities area. This file will use the Gurobi optimizer to Solve the model and print the results.

The run.jl file acts like a user interface. It checks if the output/input path exists, and it's where people can define new budget scenarios for different cases.

## Troubleshooting
When running the run.jl file, if there is a not found error on the checkpath() function, please run the function.jl file first.

## License
[MIT](https://choosealicense.com/licenses/mit/)





