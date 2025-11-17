# 🚕 Uber Data Analysis using SQL & Power BI

![🔍 Dashboard Preview](https://github.com/Sohelnur/uber-data-analysis-sql-powerbi/blob/main/Ovarall.png)

## 📌 Overview

This project analyzes Uber ride data to understand booking behavior, ride patterns, cancellations, payment trends, revenue insights, and customer/driver performance.
The analysis is carried out using SQL for data querying and Power BI for interactive visual dashboards.

The goal is to derive actionable insights into operational efficiency, customer usage patterns, and revenue trends.

## 📚 Table of Contents

## Dataset

## Dataset Columns
**Database Schema**
**SQL Analysis**
**Power BI Dashboard**
**Key Insights**
**Conclusion**
**Author**

🗂️ Dataset

The dataset consists of Uber booking records, capturing ride operations, customer activity, cancellations, fare details, and ratings.

🧾 Dataset Columns

****Date****

****Time****

**Booking_ID**

Booking_Status

Customer_ID

Vehicle_Type

Pickup_Location

Drop_Location

V_TAT

C_TAT

Canceled_Rides_by_Customer

Canceled_Rides_by_Driver

Incomplete_Rides

Incomplete_Rides_Reason

Booking_Value

Payment_Method

Ride_Distance

Driver_Ratings

Customer_Rating


🧱 Database Schema
```sql
CREATE TABLE bookings (
    Date DATE,
    Time TIME,
    Booking_ID VARCHAR(50),
    Booking_Status VARCHAR(50),
    Customer_ID VARCHAR(50),
    Vehicle_Type VARCHAR(50),
    Pickup_Location VARCHAR(255),
    Drop_Location VARCHAR(255),
    V_TAT INT,
    C_TAT INT,
    Canceled_Rides_by_Customer VARCHAR(100),
    Canceled_Rides_by_Driver VARCHAR(100),
    Incomplete_Rides VARCHAR(10),
    Incomplete_Rides_Reason VARCHAR(255),
    Booking_Value FLOAT,
    Payment_Method VARCHAR(50),
    Ride_Distance FLOAT,
    Driver_Ratings FLOAT,
    Customer_Rating FLOAT
);
```

## 🧠 SQL Analysis

### 1. Retrieve all successful bookings:
```sql
SELECT * FROM bookings
WHERE Booking_Status = 'Success';
```
### 2. Find the average ride distance for each vehicle type:
```sql
 SELECT Vehicle_Type, AVG(Ride_Distance)
 as avg_distance FROM bookings
 GROUP BY Vehicle_Type;
 ```
### 3. Get the total number of cancelled rides by customers:
 ```sql
 SELECT COUNT(*) AS CancelByCust FROM bookings
 WHERE Booking_Status = "Canceled by Customer";
 ```
### 4. List the top 5 customers who booked the highest number of rides:
  ```sql
 SELECT Customer_ID, COUNT(Booking_ID) as total_rides
 FROM bookings
 GROUP BY Customer_ID
 ORDER BY total_rides DESC LIMIT 5;
 ```
### 5. Get the number of rides cancelled by drivers due to personal and car-related issues:
```sql
 SELECT COUNT(*) AS cancelByDriver FROM bookings
 WHERE Canceled_Rides_by_Driver = 'Personal & Car related issue';
 ```
### 6. Retrieve all rides where payment was made using UPI:
 ```sql
 SELECT * FROM bookings
 WHERE Payment_Method = 'UPI';
```
### 7. Find the average customer rating per vehicle type:
 ```sql
 SELECT Vehicle_Type, AVG(Customer_Rating) as avg_customer_rating
 FROM bookings
 GROUP BY Vehicle_Type;
  ```
### 8. Calculate the total booking value of rides completed successfully:
 ```sql
 SELECT SUM(Booking_Value) as total_successful_ride_value
 FROM bookings
 WHERE Booking_Status = 'Success';
 ```
### 9. List all incomplete rides along with the reason:
 ```sql
 SELECT Booking_ID, Incomplete_Rides_Reason
 FROM bookings
 WHERE Incomplete_Rides = 'Yes';
 ```
### 10.What are the top 10 busiest pickup locations by ride count:
```sql
SELECT Pickup_Location, COUNT(*) AS Ride_Count
FROM bookings
GROUP BY Pickup_Location
ORDER BY Ride_Count DESC LIMIT 10;
```
### 11.Which hours of the day have the highest number of rides:
```sql
SELECT HOUR(Time) AS Hour, COUNT(*) AS Ride_Count
FROM bookings
WHERE Time IS NOT NULL
GROUP BY Hour
ORDER BY Ride_Count DESC;
 ```
 ### 12.What is the cumulative revenue per day over time:
 ```sql
 SELECT
    DATE(Date) AS Booking_Date,
    SUM(Booking_Value) AS Daily_Revenue,
    SUM(SUM(Booking_Value)) OVER (ORDER BY DATE(Date)) AS Cumulative_Revenue
FROM bookings
WHERE Booking_Status = 'Success'
GROUP BY DATE(Date)
ORDER BY Booking_Date;
```
### 13.Daily revenue and its change compared to previous and next day:
```sql
WITH daily_revenue AS (
    SELECT
        DATE(Date) AS Booking_Date,
        SUM(Booking_Value) AS Daily_Revenue
    FROM bookings
    WHERE Booking_Status = 'Success'
    GROUP BY DATE(Date)
)

SELECT
    Booking_Date,
    Daily_Revenue,
    LAG(Daily_Revenue) OVER(ORDER BY Booking_Date) AS Previous_Day_Rev,
    LEAD(Daily_Revenue) OVER(ORDER BY Booking_Date) AS Next_Day_Rev
FROM daily_revenue
ORDER BY Booking_Date;
```

# 📊 Power BI Dashboard
## 1️⃣ Overall Metrics & Ride Trends
![Ovarall](https://github.com/Sohelnur/uber-data-analysis-sql-powerbi/blob/main/Ovarall.png)

2️⃣ Ride Status Distribution

3️⃣ Payment Method Analysis

4️⃣ Booking Value by Day

5️⃣ Top Customers

6️⃣ Top Pickup Locations

7️⃣ Customer & Driver Cancellations

8️⃣ Ratings Analysis

⭐ Key Insights

Cash (₹19.3M) + UPI (₹14.2M) contribute 95% of total revenue

Tuesday shows the highest booking value, Sunday the lowest

Customer cancellations mostly occur when driver is not moving

Driver cancellations mostly due to personal/car issues

RT Nagar, Nagarbhavi, Banashankari are the top performing pickup areas

Ratings remain consistently strong (around 4.0)

Daily rides maintain a stable trend (3k–3.4k per day)

🏁 Conclusion

This project demonstrates:

SQL data transformation

Analytical query writing

KPI and metric creation

Data visualization mastery in Power BI

Insights extraction from real-world ride-hailing data

A strong end-to-end analytics case study combining both SQL and BI tools.

👨‍💼 Author

Nur Md. Sohel
🔗 LinkedIn: www.linkedin.com/in/nur-md-sohel-67a567340
