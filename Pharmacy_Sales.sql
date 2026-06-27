use PharmacySales

create table pharmacy_sales(
    datum nvarchar(50),
	M01AB FLOAT,
    M01AE FLOAT,
    N02BA FLOAT,
    N02BE FLOAT,
    N05B FLOAT,
    N05C FLOAT,
    R03 FLOAT,
    R06 FLOAT,
    Year INT,
    Month INT,
    Hour INT,
    Weekday_Name NVARCHAR(20)

);


bulk insert pharmacy_sales
from 'C:\Users\MKcomputer\Documents\Pharmacy_Sales\salesdaily.csv'
with(
      firstrow=2,
	  fieldterminator= ',',
	  rowterminator= '0x0a',
	  tablock
);

select count(*)
from pharmacy_sales;

select top 5 * 
from pharmacy_sales;

select
     sum(M01AB) as Total_MO1AB,
	 sum(M01AE) as Total_M01AE,
	 sum(N02BA) as Total_N02BA,
	 sum(N02BE) as Total_N02BE,
	 sum(N05B) as Total_N05B,
	 sum(N05C) as Total_N05C,
	 sum(R03) as Total_R03,
	 sum(R06) as Total_R06
from pharmacy_sales;

select sum(M01AB) as Total_M01AB_Aceclofenac,
       sum(M01AE) as Total_M01AE_Ibuprofen,
	   case
	        when sum(M01AB)> sum(M01AE)
			then 'M01AB is Higher'
			else 'M01AE is Higher'
	   end as Winner
from pharmacy_sales;

select * from pharmacy_sales;

select 
     sum(N02BA) as Total_N02BA_Aspirin,
	 sum(N02BE) as Total_N02BE_Paracetaoml,
	 case
	     when sum(N02BA) > sum(N02BE)
		 then 'N02BA is higher'
		 else 'N02BE is higher'
	end as Winner
from pharmacy_sales;


select weekday_name,
       sum(M01AB+M01AE+N02BA+N02BE+N05B+N05C+R03+R06) as Total_Sales
from pharmacy_sales
group by Weekday_Name
order by Total_Sales desc;

select Month,
       sum(M01AB+M01AE+N02BA+N02BE+N05B+N05C+R03+R06) as Total_Sales
from pharmacy_sales
group by Month
order by Total_Sales desc;

select Year,
       sum(M01AB+M01AE+N02BA+N02BE+N05B+N05C+R03+R06) as Total_Sales
from pharmacy_sales
group by Year
order by Total_Sales desc;

