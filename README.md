# New York Restaurant Association Webinar
Ironhack Final Project: Data Analytics End to End Project

# Overview

This project analyzes NYC foodservice inspection data to identify common violations, trends in inspection scores, and provide insights for improving food safety standards.

The following was created for the purpose of storytelling during the presentation: 

- **Rima Consulting Co.** is a dedicated team of foodservice specialists and data analysts committed to providing guidance and assistance to the foodservice industry. Our mission is to help establishments maintain high standards of food safety and compliance through data-driven insights and expert advice.

# Data Source

Data is sourced from NYC Open Data. 

- You can find it in the following [link](https://data.cityofnewyork.us/Health/DOHMH-New-York-City-Restaurant-Inspection-Results/43nn-pn8j/about_data).

# Data Cleaning and Processing

- Missing Values: Identified missing data and addressed them by either filling with appropriate values or dropping them when necessary.
- Duplicates: Removed duplicated rows to maintain data integrity.
- Column Management: Removed unnecessary columns and renamed those kept for consistency and better data interpretation.
- Data Transformation: Converted raw data into a structured and usable format.
- Feature Engineering: Created new columns to improve insights and support analytical goals.

The final cleaned data is found in this repository in the CSV Files folder under 'inspections_df.csv'.

Other DataFrames:
- inspections_raw_df.csv (some columns were kept in this particular data set to be used for visualizations and SQL analysis)

# Data Analysis

- Exploratory Data Analysis (EDA): Conducted using Python to understand the data's structure, uncover patterns, and identify anomalies.
- MySQL: Prepared SQL queries to extract and manipulate relevant data subsets and create new tables for further analysis.
  - Tables Created in SQL Query:
    - establishment_analysis.csv
    - violation_cat_analysis.csv
    - violation_code_analysis.csv
- Visualization: Created visual representations of the data using Tableau to effectively communicate insights and findings.

# Visualizations

This project includes visualizations such as:

- Heatmap with Inspections by Borough
- Line Graph to Interpret Trend of Average Score and Number of Inspections Over the Years
- Bar Charts of:
  - Most Common Violations by Violation Category
  - Average Score by Violation Category
  - Top Violation Codes (descriptions can be found in the Violation Codes with Descriptions URL at the end of this page)
 
You can find these and other visualizations in the following [Tableau Page](https://public.tableau.com/views/RestaurantInspectionsAnalysis/HeatMapwithInspectionsbyBorough?:language=en-US&:sid=&:display_count=n&:origin=viz_share_link).

# Conclusions and Takeaways

- The most common violations are for Cleaning and Sanitation as well as Food Handling (Foor Preparation, Temperature Control and Food Storage or Source).
- Scores may vary greatly even within a Category; foodservice establishments must keep track of all possible violations, not just those that are more common.
- Establishments must train and keep staff up to date with practices to prevent common violations related to cleanliness and food handling.
- Establishments must implement and adhere to Standard Operating Procedures (SOPs) to ensure food safety and sanitation practices are consistently followed.

# What's Next?

- Categorize food establishments by type, such as chain restaurants, independent restaurants or fast food for further analysis
- Machine Learning: Create a model that provides recommendations on standard practices based on location, type of restaurant and its surroundings

## Other URLs

[Violation Codes with Descriptions](https://www.nyc.gov/assets/doh/downloads/pdf/rii/ri-violation-penalty.pdf)

[Storytelling Presentation](https://docs.google.com/presentation/d/1t3SiOgre6eyy6l_FwQXzXMALnjYZsr7-cSDprI5xZUQ/edit?usp=sharing)

[Trello Page](https://trello.com/c/Az4CNEii/5-prepare-a-readme-file)

# Contributions

Contributions are welcome! Please submit a pull request or open an issue for any changes. 

**THANK YOU**
