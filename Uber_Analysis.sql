#1. Retrieve all successful bookings:
 SELECT * FROM bookings
 WHERE Booking_Status = 'Success';
 
#2. Find the average ride distance for each vehicle type:
 SELECT Vehicle_Type, AVG(Ride_Distance)
 as avg_distance FROM bookings
 GROUP BY Vehicle_Type;
 
#3. Get the total number of cancelled rides by customers:
 SELECT COUNT(*) AS CancelByCust FROM bookings
 WHERE Booking_Status = "Canceled by Customer";
 
#4. List the top 5 customers who booked the highest number of rides:
 SELECT Customer_ID, COUNT(Booking_ID) as total_rides
 FROM bookings
 GROUP BY Customer_ID
 ORDER BY total_rides DESC LIMIT 5;
 
#5. Get the number of rides cancelled by drivers due to personal and car-related issues:
 SELECT COUNT(*) AS cancelByDriver FROM bookings
 WHERE Canceled_Rides_by_Driver = 'Personal & Car related issue';
 
#6. Retrieve all rides where payment was made using UPI:
 SELECT * FROM bookings
 WHERE Payment_Method = 'UPI';
 
#7. Find the average customer rating per vehicle type:
 SELECT Vehicle_Type, AVG(Customer_Rating) as avg_customer_rating
 FROM bookings
 GROUP BY Vehicle_Type;
 
#8. Calculate the total booking value of rides completed successfully:
 SELECT SUM(Booking_Value) as total_successful_ride_value
 FROM bookings
 WHERE Booking_Status = 'Success';
 
#9. List all incomplete rides along with the reason:
 SELECT Booking_ID, Incomplete_Rides_Reason
 FROM bookings
 WHERE Incomplete_Rides = 'Yes';
 
#10.What are the top 10 busiest pickup locations by ride count:
SELECT Pickup_Location, COUNT(*) AS Ride_Count
FROM bookings
GROUP BY Pickup_Location
ORDER BY Ride_Count DESC LIMIT 10;


#11.Which hours of the day have the highest number of rides:
SELECT HOUR(Time) AS Hour, COUNT(*) AS Ride_Count
FROM bookings
WHERE Time IS NOT NULL
GROUP BY Hour
ORDER BY Ride_Count DESC;
 
#12.What is the cumulative revenue per day over time:
 SELECT
    DATE(Date) AS Booking_Date,
    SUM(Booking_Value) AS Daily_Revenue,
    SUM(SUM(Booking_Value)) OVER (ORDER BY DATE(Date)) AS Cumulative_Revenue
FROM bookings
WHERE Booking_Status = 'Success'
GROUP BY DATE(Date)
ORDER BY Booking_Date;
 
#13.Daily revenue and its change compared to previous and next day:
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