### A Medallion Achitectural Data Warehouse Project
Encompasses a structured data warehouse using SQL to consolidate hotel reservation data, enabling crisp analytical reporting, business intelligence and informed decision making

#### PROJECT ARCHITECTURE
<div align="center">
  <img src="https://github.com/fredie7/sql_data_warehouse/blob/main/images/sql%20warehouse%20workflow.png?raw=true" />
  <br>
   <sub><b></b> </sub>
</div>

#### PROCEDURE
The project follows through with the above predefined architecture, which begins with importing the datasets provided as CSV files into the staging area, before being exported to the bronze layer. Data cleaning at the silver layer becomes imperative to resolve inconsistencies to ensure that every record adheres to standard quality practices. Afterward, a detailed data quality check is conducted to verify that the datasets conformed to the defined schema, maintained completeness, and reflected accuracy in line with the overall business context. \


#### DATA MODEL

<div align="center">
  <img src="https://github.com/fredie7/sql_data_warehouse/blob/main/images/model.png?raw=true" />
  <br>
   <sub><b></b> </sub>
</div>

#### THE ANALYSIS EXPLORES: 
-Measures such as: Report to show key metrics of big numbers,
-Magnitude analysis : To compare measure values accross different dimensions, identifying key contributors.
Revenue trends: Revenue By Customers
Seasonality analysis: Monthly Revenue Breakdown
Room occupancy trends:  Total bookings by room type or Most frequently booked rooms
Customer behaviour analysis: Total bookings by customer
Ranking analysis: Top 10 Customers By Average Spend
Cumlative analysis: aggregates the progress of data over time
Performance analysis: Compare Average Perfromance By Year
Part to whole analysis: Areas of highest impact
Segmentation analysis: Customer segmentaton, Room segmentation

And others such as:
Total Number of Reservations By Nationality
Top 5 Most Frequent Customers By Reservation
Percentage trend of booked rooms
Non-repeat customers By Name


#### VISUALIZATION

<div align="center">
  <img src="https://github.com/fredie7/sql_data_warehouse/blob/main/images/sql_visualization.png?raw=true" />
  <br>
   <sub><b></b> </sub>
</div>


