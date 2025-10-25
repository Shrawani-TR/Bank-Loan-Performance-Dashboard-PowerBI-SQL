select * from [Bank Loan Data]

---Loan Applications

select count(id) AS Total_Loan_Applications from [Bank Loan Data]

select count(id) AS MTD_Toatal_Applications  from [Bank Loan Data] ----loan disbursement in last month of current year
where month (issue_date) =12 And year(issue_date) =2021

select count(id) AS PMTD_Toatal_Applications  from [Bank Loan Data] ----loan disbursement in previous month to last month of current year
where month (issue_date) =11 And year(issue_date) =2021


---Total Funded Amount 
select SUM(loan_amount) as Total_funded_Amount from [Bank Loan Data] ----Loan amount given to borrower


select SUM(loan_amount) as MTD_Total_Funded_Amount from [Bank Loan Data] ----Loan amount given to borrower in last month of current year
where month (issue_date) =12 And year(issue_date) =2021

select SUM(loan_amount) as PMTD_Total_Funded_Amount from [Bank Loan Data] ----Loan amount given to borrower in previous month to last month of current year
where month (issue_date) =11 And year(issue_date) =2021


---total amount received from borrower

select * from [Bank Loan Data]

select SUM(total_payment) as Total_Amount_Received from [Bank Loan Data] ---total amount given back to bank

select SUM(total_payment) as MTD_Total_Amount_Received from [Bank Loan Data] ---total amount given back to bank in  last month of current year
where month (issue_date) =12 And year(issue_date) =2021

select SUM(total_payment) as PMTD_Total_Amount_Received from [Bank Loan Data] ---total amount given back to bank in previous month to last month of current year
where month (issue_date) =11 And year(issue_date) =2021

---Average Interest Rate

select AVG(int_rate)*100 as Average_Interest_Rate from [Bank Loan Data]


select ROUND(AVG(int_rate),4) * 100 as Average_Interest_Rate from [Bank Loan Data] ---to get round off the % to two decimal  eg 12.221 to 12.22

select AVG(int_rate)*100 as MTD_Average_Interest_Rate from [Bank Loan Data]
where month (issue_date) =12 And year(issue_date) =2021

select AVG(int_rate)*100 as PMTD_Average_Interest_Rate from [Bank Loan Data]
where month (issue_date) =11 And year(issue_date) =2021



---Average DTI

select AVG(dti)*100 as Average_Dti from [Bank Loan Data]


select ROUND(AVG(dti),4) * 100 as Average_Dti from [Bank Loan Data] ---to get round off the % to two decimal  eg 12.221 to 12.22

select AVG(dti)*100 as MTD_Average_Dti from [Bank Loan Data]
where month (issue_date) =12 And year(issue_date) =2021

select AVG(dti)*100 as PMTD_Average_Dti from [Bank Loan Data]
where month (issue_date) =11 And year(issue_date) =2021


----good Loan vs Bad Loan KPI's

select * from [Bank Loan Data]

select loan_status from [Bank Loan Data]

select 
(count(case when loan_status ='Fully Paid' or loan_status ='Current' then id end)*100) ---good loan percentage 
/ 
count(id) As Good_Loan_percentage 
from [Bank Loan Data]

select count(id) As Good_Loan_Application from [Bank Loan Data] ---toal goog laon applications 
where loan_status ='Fully Paid' or loan_status ='Current'

select Sum(loan_amount) As Good_Loan_Funded_Amount from [Bank Loan Data] ---total good laon amount given to customer
where loan_status ='Fully Paid'or loan_status ='Current'

select Sum(total_payment) As Good_Loan_Total_Received_Amount from [Bank Loan Data] ---total good laon amount repayed 
where loan_status ='Fully Paid'or loan_status ='Current'

---good loan funded amount > good loan recived amount : bank is making huge profit


---Bad Loan KPI's

select 
(count(case when loan_status ='Charged Off' then id end)*100) ---Bad loan percentage 
/ 
count(id) As Bad_Loan_percentage 
from [Bank Loan Data]

select count(id) As Bad_Loan_Application from [Bank Loan Data] ---toal Bad laon applications 
where loan_status ='Charged Off'

select Sum(loan_amount) As Bad_Loan_Funded_Amount from [Bank Loan Data] ---total Bad laon amount given to customer
where loan_status ='Charged Off'

select Sum(total_payment) As Bad_Loan_Total_Received_Amount from [Bank Loan Data] ---total bad laon amount repayed 
where loan_status ='Charged Off'

--bad loan amount received is half of bad loan amount funded --bank is making huge loss here, bank should investigate those customers who is not paying loan reguarly 


---Loan Status Grid View

select * from [Bank Loan Data]

select 
loan_status,
count(id) as Total_Applications,
sum(loan_amount) as Total_Amount_Funded,
sum(total_payment) as Total_Amount_Recieved,
AVG (int_rate*100) as Average_Interest_Rate,
AVG(dti *100) as Average_Dti 
from [Bank Loan Data]
group by loan_status 


SELECT                                                ---loan status for MTD 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM [Bank Loan Data]
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status


---Monthly Bank Loan Report 

SELECT 

	MONTH(issue_date) AS Month_Number, 
	DATENAME(MONTH, issue_date) AS Month_name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM [Bank Loan Data]
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)



SELECT 
    YEAR(issue_date) AS Year,
    MONTH(issue_date) AS Month_Number, 
    DATENAME(MONTH, issue_date) AS Month_Name, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM [Bank Loan Data]
GROUP BY 
    YEAR(issue_date),
    MONTH(issue_date), 
    DATENAME(MONTH, issue_date)
ORDER BY 
    YEAR(issue_date),
    MONTH(issue_date)


    --Regional Bank loan report 

    SELECT                                        -----order by loan amount funded , max laon given to CA 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM [Bank Loan Data]
GROUP BY address_state
ORDER BY SUM(loan_amount) desc


    SELECT                                        -----order by no of loan applications  , max laon given to CA 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM [Bank Loan Data]
GROUP BY address_state
ORDER BY COUNT(id) desc


---term analysis


    SELECT                                        -----order by term 
	term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM [Bank Loan Data]
GROUP BY term
ORDER BY term

------EMPLOYEE LENGTH
SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM [Bank Loan Data]
GROUP BY emp_length
ORDER BY emp_length


SELECT 
	emp_length AS Employee_Length,            ----order by no of application.10 plus year experience people taken max loans
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM [Bank Loan Data]
GROUP BY emp_length
ORDER BY COUNT(id) desc


---Loan Purpose analysis

SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM [Bank Loan Data]
GROUP BY purpose
ORDER BY purpose


SELECT                                        ---order by no of application based on purpose . mostly taken for debt consolidation
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM [Bank Loan Data]
GROUP BY purpose
ORDER BY count(id) desc


---- with respect to HOME OWNERSHIP            ---mostly people take laon live on rent
SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM [Bank Loan Data]
GROUP BY home_ownership
ORDER BY count(id) desc
