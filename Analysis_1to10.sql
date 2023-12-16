Use genzdataset;
Show tables;
Select * from genzdataset.learning_aspirations;	
Select * from genzdataset.manager_aspirations;
Select * from genzdataset.mission_aspirations;
Select * from genzdataset.personalized_info;

-- create merged table
Create table merged_data (
    ResponseID int,
    CareerInfluenceFactor varchar(255),
    HigherEducationAbroad varchar(255),
    PreferredWorkingEnvironment varchar(255),
    ZipCode varchar(10),
    ClosestAspirationalCareer varchar(255),
    WorkLikelihood3Years varchar(255),
    PreferredEmployer varchar(255),
    PreferredManager varchar(255),
    PreferredWorkSetup varchar(255),
    WorkLikelihood7Years varchar(255),
    MissionUndefinedLikelihood varchar(255),
    MisalignedMissionLikelihood varchar(255),
    NoSocialImpactLikelihood varchar(255),
    LaidOffEmployees varchar(255),
    ExpectedSalary3Years varchar(255),
    ExpectedSalary5Years varchar(255),
    Timestamp varchar(25),
    CurrentCountry varchar(255),
    Gender varchar(10)
);

-- insert merged data
Insert into merged_data (
    ResponseID,
    CareerInfluenceFactor,
    HigherEducationAbroad,
    PreferredWorkingEnvironment,
    ZipCode,
    ClosestAspirationalCareer,
    WorkLikelihood3Years,
    PreferredEmployer,
    PreferredManager,
    PreferredWorkSetup,
    WorkLikelihood7Years,
    MissionUndefinedLikelihood,
    MisalignedMissionLikelihood,
    NoSocialImpactLikelihood,
    LaidOffEmployees,
    ExpectedSalary3Years,
    ExpectedSalary5Years,
    Timestamp,
    CurrentCountry,
    Gender
)
Select
    la.ResponseID,
    la.CareerInfluenceFactor,
    la.HigherEducationAbroad,
    la.PreferredWorkingEnvironment,
    la.ZipCode,
    la.ClosestAspirationalCareer,
    ma.WorkLikelihood3Years,
    ma.PreferredEmployer,
    ma.PreferredManager,
    ma.PreferredWorkSetup,
    ma.WorkLikelihood7Years,
    mia.MissionUndefinedLikelihood,
    mia.MisalignedMissionLikelihood,
    mia.NoSocialImpactLikelihood,
    mia.LaidOffEmployees,
    mia.ExpectedSalary3Years,
    mia.ExpectedSalary5Years,
    pi.Timestamp,
    pi.CurrentCountry,
    pi.Gender
From learning_aspirations la
Join manager_aspirations ma on la.ResponseID = ma.ResponseID
Join mission_aspirations mia on la.ResponseID = mia.ResponseID
Join personalized_info pi on la.ResponseID = pi.ResponseID;

Select * 
from merged_data;

-- Question 1
Select Count(*) as male_responses_from_india
from merged_data
where Gender like 'male%' and CurrentCountry = 'India';

-- Question 2
Select Count(*) as female_responses_from_india
from merged_data
where Gender like 'female%' and CurrentCountry = 'India';

-- Question 3
Select Count(*) as career_choice_influenzed_by_parents_india
from merged_data
where CareerInfluenceFactor ='My Parents' and CurrentCountry = 'India';

-- Question 4
Select Count(*) as female_career_choice_influenzed_by_parents_india
from merged_data
where Gender like 'female%' and CareerInfluenceFactor ='My Parents' and CurrentCountry = 'India';

-- Question 5
Select Count(*) as male_career_choice_influenzed_by_parents_india
from merged_data
where Gender like 'male%' and CareerInfluenceFactor ='My Parents' and CurrentCountry = 'India';

-- Question 6
Select
    Sum(case when Gender like 'male%' then 1 else 0 end) as male_careerinfluencemyparents_india,
    Sum(case when Gender like 'female%' then 1 else 0 end) as female_careerinfluencemyparents_india
from merged_data
where CareerInfluenceFactor = 'My Parents' and CurrentCountry = 'India';

-- Question 7
Select Count(*) as socialmediaLinkedIn_influencerssuccesfulcareers_india
from merged_data
where CareerInfluenceFactor = 'Social Media like LinkedIn' or 'Influencers who had successful careers'
and CurrentCountry = 'India'; 

-- Question 8
Select
	Sum(case when Gender like 'male%' then 1 else 0 end) as male_socialmediaLinkedIn_influencerssuccesfulcareers_india,
	Sum(case when Gender like 'female%' then 1 else 0 end) as female_socialmediaLinkedIn_influencerssuccesfulcareers_india 
from merged_data
where CareerInfluenceFactor = 'Social Media like LinkedIn' or 'Influencers who had successful careers'
and CurrentCountry = 'India';

-- Question 9
Select count(*) as socialmedia_influencers_going_abroad
from merged_data
where CareerInfluenceFactor = 'Social Media like LinkedIn' and HigherEducationAbroad = 'Yes, I wil';

-- Question 10
Select count(*) as people_from_mycircle_careerinfluencers_going_abroad
from merged_data
where CareerInfluenceFactor = 'People from my circle, but not family members' 
and HigherEducationAbroad = 'Yes, I wil';










