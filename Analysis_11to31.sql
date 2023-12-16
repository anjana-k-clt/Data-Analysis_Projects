Select Distinct PreferredWorkingEnvironment
from genzdataset.learning_aspirations;

-- Question 1
select 
sum(case when Gender like 'male%' then 1 else 0 end)/count(Gender)*100 as malepercent_everydayoffice,
sum(case when Gender like 'female%' then 1 else 0 end)/count(Gender)*100 as femalepercent_everydayoffice
from learning_aspirations la
inner join personalized_info pi on la.ResponseID = pi.ResponseID 
where PreferredWorkingEnvironment= 'Every Day Office Environment';

--
Select Distinct Gender
from genzdataset.personalized_info;

-- Question 2
select 
sum(case when CareerInfluenceFactor = 'My Parents' and 
    ClosestAspirationalCareer like 'Business Operations%' then 1 else 0 end) /count(Gender)*100
as percentgenz_business_parents
from learning_aspirations la
inner join personalized_info pi on la.ResponseID = pi.ResponseID;

--
Select Distinct HigherEducationAbroad
from genzdataset.learning_aspirations;

-- Question 3
select
sum(case when Gender like 'male%' then 1 else 0 end)/count(Gender)*100 as malepercent_higherstudies,
sum(case when Gender like 'female%' then 1 else 0 end)/count(Gender)*100 as femalepercent_higherstudies
from learning_aspirations la
inner join personalized_info pi on la.ResponseID = pi.ResponseID 
where HigherEducationAbroad = 'Yes, I wil';

--
Select Distinct NoSocialImpactLikelihood
from  genzdataset.mission_aspirations; 

-- Question 4
select 
sum(case when Gender like 'male%' and MisalignedMissionLikelihood like 'Will work for them%' then 1 else 0 end)/count(Gender)*100
as malepercent_willwork,
sum(case when Gender like 'male%' and MisalignedMissionLikelihood like 'Will NOT work for them%' then 1 else 0 end)/count(Gender)*100
as malepercent_willnotwork,
sum(case when Gender like 'female%' and MisalignedMissionLikelihood like 'Will work for them%' then 1 else 0 end)/count(Gender)*100
as femalepercent_willwork,
sum(case when Gender like 'female%' and MisalignedMissionLikelihood like 'Will NOT work for them%' then 1 else 0 end)/count(Gender)*100
as femalepercent_willnotwork
from mission_aspirations mia
inner join personalized_info pi on mia.ResponseID = pi.ResponseID;

-- Question 5
select w_e.PreferredWorkingEnvironment,
       w_e.most_preferred
from
(select PreferredWorkingEnvironment,
       count(*) as most_preferred
from learning_aspirations la
inner join personalized_info pi on la.ResponseID = pi.ResponseID 
where Gender like 'female%' and  PreferredWorkingEnvironment in
     ('Fully Remote with No option to visit offices',
	  'Hybrid Working Environment with less than 15 days a month at office',
	  'Fully Remote with Options to travel as and when needed',
      'Every Day Office Environment',
      'Hybrid Working Environment with less than 3 days a month at office',
      'Hybrid Working Environment with less than 10 days a month at office',
      'Hybrid Working Environment with more than 15 days a month at officein')
group by PreferredWorkingEnvironment
order by most_preferred desc
limit 1) as  w_e;

--
Select Distinct ExpectedSalary5Years
from mission_aspirations;
Select Distinct PreferredEmployer
from manager_aspirations;

-- Question 6
select
sum(case when Gender like 'male%' and PreferredEmployer = 'Employers who appreciates learning but
    doesn\'t enables an learning environment' and ExpectedSalary5Years >'50k'    
    then 1 else 0 end)/ count(Gender) *100 as maleprcnt_expctdslry5yrs_app_lrng_no_lrngenv
from manager_aspirations ma
inner join mission_aspirations mia on ma.ResponseID = mia.ResponseID
inner join personalized_info pi on ma.ResponseID = pi.ResponseID;

-- Question 7

--
Select Distinct ClosestAspirationalCareer
from genzdataset.learning_aspirations;
Select Distinct NoSocialImpactLikelihood
from genzdataset.mission_aspirations;

-- Question 8
select count(*) as femalecount_Nosocialimpact_1to5
from mission_aspirations mia
inner join personalized_info pi on mia.ResponseID = pi.ResponseID
where Gender like 'female%' and NoSocialImpactLikelihood in ('1','2','3','4','5');

-- Question 9
select count(*) as malecount_hghereduabroad_careerinfluence_myparents
from learning_aspirations la
inner join personalized_info pi on la.ResponseID = pi.ResponseID
where Gender like 'male%' and CareerInfluenceFactor = 'My Parents' and
HigherEducationAbroad = 'Yes, I wil'; 

-- Question 10
select
sum(case when NoSocialImpactLikelihood in ('8','9','10') and HigherEducationAbroad = 'Yes, I wil'
     then 1 else 0 end)/count(Gender) * 100
as percent_nosocialimpact8to10_Higheduabroad
from learning_aspirations la
inner join mission_aspirations mia on la.ResponseID = mia.ResponseID
inner join personalized_info pi on la.ResponseID = pi.ResponseID;

--
Select Distinct PreferredWorkSetup
from genzdataset.manager_aspirations;

-- Question 11
select
sum(case when Gender like 'male%' and PreferredWorkSetup like '%people in my team' then 1 else 0 end)
as malecount_workwith_team,
sum(case when Gender like 'female%' and PreferredWorkSetup like '%people in my team' then 1 else 0 end)
as femalecount_workwith_team,
sum(case when PreferredWorkSetup like '%people in my team' then 1 else 0 end)
as overallcount_workwith_team,
sum(case when PreferredWorkSetup like '%people in my team' then 1 else 0 end)/ count(Gender) *100
as overallpercent_workwith_team
from manager_aspirations ma
inner join personalized_info pi on ma.ResponseID = pi.ResponseID;

-- Question 12
select Gender, WorkLikelihood3Years, count(*) as countof_eachcategory
from manager_aspirations ma 
inner join personalized_info pi on ma.ResponseID = pi.ResponseID
group by Gender, WorkLikelihood3Years
order by Gender, WorkLikelihood3Years;

-- Question 13
select CurrentCountry, WorkLikelihood3Years, count(*) as countof_eachcategory
from manager_aspirations ma 
inner join personalized_info pi on ma.ResponseID = pi.ResponseID
group by CurrentCountry, WorkLikelihood3Years
order by CurrentCountry, WorkLikelihood3Years;

--
Select Distinct ExpectedSalary3Years
from genzdataset.mission_aspirations;

-- Question 14
select Gender,
       avg(case when ExpectedSalary3Years='31k to 40k' then 31
				when ExpectedSalary3Years='21k to 25k' then 21
		        when ExpectedSalary3Years='>50k' then 50
				when ExpectedSalary3Years='26k to 30k' then 26
				when ExpectedSalary3Years='16k to 20k' then 16
				when ExpectedSalary3Years='41k to 50k' then 41
				when ExpectedSalary3Years='11k to 15k' then 11
				when ExpectedSalary3Years='5K to 10K' then 5
				else 0
				end) as average_startingsalary_3yrs         
from mission_aspirations mia
inner join personalized_info pi on mia.ResponseID = pi.ResponseID
group by Gender;

--
select distinct ExpectedSalary5Years
from genzdataset.mission_aspirations;

-- Question 15
select Gender,
       avg(case when ExpectedSalary5Years='91k to 110k' then 91
                when '50k to 70k' then 50
                when '>151k' then 151
                when '71k to 90k' then 71
                when '111k to 130k' then 111
                when '131k to 150k' then 131
				when '30k to 50k' then 30
                else 0 
                end
                ) as average_startingsalary_5yrs
from mission_aspirations mia
inner join personalized_info pi on mia.ResponseID = pi.ResponseID
group by Gender;

-- Question 16
select Gender,
       avg(case when ExpectedSalary3Years='31k to 40k' then 40
				when '21k to 25k' then 25
		        when '>50k' then 50
				when '26k to 30k' then 30
				when '16k to 20k' then 20
				when '41k to 50k' then 50
				when '11k to 15k' then 15
				when '5K to 10K' then 10
				else 0
				end) as average_highersalary_3yrs         
from mission_aspirations mia
inner join personalized_info pi on mia.ResponseID = pi.ResponseID
group by Gender;  

-- Question 17
select Gender,
       avg(case when ExpectedSalary5Years='91k to 110k' then 110
                when '50k to 70k' then 70
                when '>151k' then 151
                when '71k to 90k' then 90
                when '111k to 130k' then 130
                when '131k to 150k' then 150
				when '30k to 50k' then 50
                else 0 
                end
                ) as average_highersalary_5yrs
from mission_aspirations mia
inner join personalized_info pi on mia.ResponseID = pi.ResponseID
group by Gender;

-- Question 18
select CurrentCountry, Gender,
       avg(case when ExpectedSalary3Years='31k to 40k' then 31
				when '21k to 25k' then 21
		        when '>50k' then 50
				when '26k to 30k' then 26
				when '16k to 20k' then 16
				when '41k to 50k' then 41
				when '11k to 15k' then 11
				when '5K to 10K' then 5
				else 0
				end) as average_startingsalarycountry_3yrs         
from mission_aspirations mia
inner join personalized_info pi on mia.ResponseID = pi.ResponseID
group by CurrentCountry,Gender
order by CurrentCountry,Gender;

-- Question 19
select CurrentCountry, Gender,
       avg(case when ExpectedSalary5Years='91k to 110k' then 91
                when '50k to 70k' then 50
                when '>151k' then 151
                when '71k to 90k' then 71
                when '111k to 130k' then 111
                when '131k to 150k' then 131
				when '30k to 50k' then 30
                else 0 
                end
                ) as average_startingsalarycountry_5yrs
from mission_aspirations mia
inner join personalized_info pi on mia.ResponseID = pi.ResponseID
group by CurrentCountry, Gender
order by CurrentCountry, Gender; 

-- Question 20
select CurrentCountry, Gender,
       avg(case when ExpectedSalary3Years='31k to 40k' then 40
				when '21k to 25k' then 25
		        when '>50k' then 50
				when '26k to 30k' then 30
				when '16k to 20k' then 20
				when '41k to 50k' then 50
				when '11k to 15k' then 15
				when '5K to 10K' then 10
				else 0
				end) as average_highersalarycountry_3yrs         
from mission_aspirations mia
inner join personalized_info pi on mia.ResponseID = pi.ResponseID
group by CurrentCountry, Gender
order by CurrentCountry, Gender;

-- Question 21
select CurrentCountry, Gender,
       avg(case when ExpectedSalary5Years='91k to 110k' then 110
                when '50k to 70k' then 70
                when '>151k' then 151
                when '71k to 90k' then 90
                when '111k to 130k' then 130
                when '131k to 150k' then 150
				when '30k to 50k' then 50
                else 0 
                end
                ) as average_highersalarycountry_5yrs
from mission_aspirations mia
inner join personalized_info pi on mia.ResponseID = pi.ResponseID
group by CurrentCountry, Gender
order by CurrentCountry, Gender;

--
select distinct MisalignedMissionLikelihood
from mission_aspirations; 

-- Question 22
select CurrentCountry, Gender, MisalignedMissionLikelihood, count(*) as countof_eachcategory
from mission_aspirations mia
inner join personalized_info pi on mia.ResponseID = pi.ResponseID
group by CurrentCountry, Gender, MisalignedMissionLikelihood
order by CurrentCountry, Gender, MisalignedMissionLikelihood;

       
       
       
       
       
       
       
       




                            
                            