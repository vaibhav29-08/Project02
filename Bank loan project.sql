CREATE TABLE financial_loan (
    id BIGINT,
    address_state VARCHAR(10),
    application_type VARCHAR(30),
    emp_length VARCHAR(20),
    emp_title TEXT,
    grade CHAR(1),
    home_ownership VARCHAR(20),
    issue_date DATE,
    last_credit_pull_date DATE,
    last_payment_date DATE,
    loan_status VARCHAR(30),
    next_payment_date DATE,
    member_id BIGINT,
    purpose VARCHAR(50),
    sub_grade VARCHAR(5),
    term VARCHAR(20),
    verification_status VARCHAR(30),
    annual_income NUMERIC(12,2),
    dti NUMERIC(6,4),
    installment NUMERIC(10,2),
    int_rate NUMERIC(6,4),
    loan_amount BIGINT,
    total_acc INT,
    total_payment BIGINT
);


SELECT * FROM financial_loan;




UPDATE financial_loan
SET emp_title = 'Empty'
WHERE emp_title='';

SELECT *
FROM financial_loan
WHERE emp_title= 'Empty' ;

select count(id) as Total_Loan_Applications from financial_loan;

SELECT COUNT(id) AS mtd_total_loan_applications
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date) = 12
  AND EXTRACT(YEAR FROM issue_date) = 2021;


SELECT COUNT(id) AS pmtd_total_loan_applications
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date) = 11
  AND EXTRACT(YEAR FROM issue_date) = 2021;

select sum(loan_amount) as Total_Funded_Amount from financial_loan;

SELECT  sum(loan_amount) AS PMTD_Total_Funded_Amout
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date) = 11
  AND EXTRACT(YEAR FROM issue_date) = 2021;


select sum(total_payment) as Total_Amount_Received from financial_loan;

select round(Avg(int_rate)*100,2) as Average_interest_rate from financial_loan;

select round(avg(dti)*100,2) as Avg_DTI from financial_loan;


--good bad loan

select count(id) as good_Loan_Applications from financial_loan
where loan_status='Fully Paid' or  loan_status='Current';

select round(count(id) filter (where loan_status in ('Fully Paid','Current'))*100/count(id),2)
as Good_Loan_Applications_percentage from financial_loan;


select sum(loan_amount) as good_Loan_funded_amount from financial_loan
where loan_status='Fully Paid' or  loan_status='Current';


select sum(total_payment) as good_amount_received from financial_loan
where loan_status='Fully Paid' or  loan_status='Current';

select (count(case when loan_status='Charged Off' then id end)*100.0/ count(*)) 
as bad_loan_percentage from financial_loan;


select (count(case when loan_status='Charged Off' then id end)) 
as bad_loan_applications from financial_loan;




select sum(loan_amount) as bad_Loan_funded_amount from financial_loan
where loan_status='Charged Off';




select sum(total_payment) as bad_Loan_received_amount from financial_loan
where loan_status='Charged Off';



select loan_status,
count(id) as Total_loan_applications,
sum(total_payment) as Total_Loan_received_amount ,
avg(int_rate)*100.0 as Average_interest_rate,
avg(dti)*100.0 as Avg_DTI,
sum(loan_amount) as total_amount_funded
from financial_loan group by loan_status;



select loan_status,
sum(total_payment) as MTD_Total_Loan_received_amount ,
sum(loan_amount) as MTD_total_amount_funded
from financial_loan 
WHERE (EXTRACT(MONTH FROM issue_date) = 12
  AND EXTRACT(YEAR FROM issue_date) = 2021)
group by loan_status;


SELECT 
	address_state,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY address_state
ORDER BY address_state;

SELECT
    EXTRACT(MONTH FROM issue_date) AS month_number,
    TO_CHAR(issue_date, 'Month') AS month_name,
    COUNT(*) AS total_loan_applications,
    SUM(loan_amount) AS total_funded_amount,
    SUM(total_payment) AS total_amount_received
FROM financial_loan
GROUP BY
    EXTRACT(MONTH FROM issue_date),
    TO_CHAR(issue_date, 'Month')
ORDER BY
    EXTRACT(MONTH FROM issue_date);


SELECT 
	term,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY term
ORDER BY term;



SELECT 
	emp_length,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY emp_length
ORDER BY emp_length;





SELECT 
	purpose,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY purpose
ORDER BY purpose;



SELECT 
	home_ownership,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY home_ownership
ORDER BY home_ownership;
