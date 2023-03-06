-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 

Select ca.cf_id, Sum (ca.backers_count) As total_backers_count
From campaign As ca
Where (ca.outcome = 'live')
Group By ca.cf_id
Order By Sum (ca.backers_count) Desc;

-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.

Select ba.cf_id, Count (backer_id) As total_backers_count
From backers As ba
Group By ba.cf_id
Order By Count (backer_id) Desc;

-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 

Select co.first_name,
		co.last_name,
		co.email,
		(ca.goal - ca.pledged) As "Remaining Goal Amount"
Into email_contacts_remaining_goal_amount
From campaign as ca
Left Join contacts as co
On (co.contact_id = ca.contact_id)
Where (ca.outcome = 'live')
Order By "Remaining Goal Amount" Desc;

-- Check the table

Select * From email_contacts_remaining_goal_amount;

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

Select ba.email,
		ba.first_name,
		ba.last_name,
		ca.cf_id,
		ca.company_name,
		ca.description,
		ca.end_date,
		(ca.goal - ca.pledged) As "Left of Goal"
Into email_backers_remaining_goal_amount
From campaign as ca
Left Join backers as ba
On (ba.cf_id = ca.cf_id)
Where (ca.outcome = 'live')
Order By ba.last_name Asc;

-- Check the table

Select * From email_backers_remaining_goal_amount;


