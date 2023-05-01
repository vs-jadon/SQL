
/*
Covid 19 Data Exploration (Jan 2020 - April 2023)
Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types
*/
SELECT * 
FROM Covid_Death_Vaccination..coviddeaths;

-- Select Data that we are going to be starting with

SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM Covid_Death_Vaccination..coviddeaths
WHERE continent is not null
ORDER BY 1, 2;

-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country
-- Typecast was done as total_deaths is of VARCHAR type

SELECT Location, date, total_cases, total_deaths, (total_deaths/CAST(total_cases AS DECIMAL))*100 AS death_likelihood
FROM Covid_Death_Vaccination..coviddeaths
WHERE continent is not null AND location LIKE '%ndia'
ORDER BY 2 DESC;

-- Total Cases vs Population
-- Shows what percentage of population infected with Covid
SELECT Location, date, total_cases, population, (CAST(total_cases AS DECIMAL)/population)*100 AS percent_popu_infected
FROM Covid_Death_Vaccination..coviddeaths
WHERE continent is not null AND location LIKE '%ndia'
ORDER BY 2;

-- Countries with Highest Infection Rate compared to Population
SELECT Location, MAX(total_cases) AS total_case, population, (CAST( max(total_cases) AS DECIMAL)/population)*100 AS percent_popu_infected
FROM Covid_Death_Vaccination..coviddeaths
WHERE continent is not null  
GROUP BY Location, population
ORDER BY 3 DESC;

-- Countries with Highest Death Count per Population
SELECT Location, MAX(total_deaths) AS total_deaths, population, (CAST( max(total_deaths) AS DECIMAL)/population)*100 AS percent_popu_died
FROM Covid_Death_Vaccination..coviddeaths
WHERE continent is not null 
GROUP BY Location, population
ORDER BY 4 DESC;



-- BREAKING THINGS DOWN BY CONTINENT

-- Select Data that we are going to be starting with for continents

SELECT location, MAX(total_cases), population 
FROM Covid_Death_Vaccination..coviddeaths
WHERE continent is NULL
GROUP BY location, population;

-- Showing contintents with the highest death count per population
SELECT Location, MAX(total_deaths) AS total_deaths, (CAST( max(total_deaths) AS DECIMAL)/population)*100 AS percent_popu_died
FROM Covid_Death_Vaccination..coviddeaths
WHERE continent is NULL 
GROUP BY Location, population
ORDER BY 3 DESC;

-- Showing global data

SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
FROM Covid_Death_Vaccination..coviddeaths
--Where location like '%states%'
WHERE continent is not null 
ORDER BY 1,2


-- Total Population vs Vaccinations

-- Joing the death and vaccinations table
SELECT Death.continent, Death.location, Death.date, Death.population, Vaccine.new_vaccinations 
FROM Covid_Death_Vaccination..coviddeaths AS Death
JOIN Covid_Death_Vaccination..covidvaccinations AS Vaccine
ON Death.population = Vaccine.population 
AND Death.date = Death.date
WHERE Death.continent IS NOT NULL
ORDER BY 1,2,3
-- AND Death.date = Vaccine.date
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

Select dea.continent, dea.location, dea.date, dea.population, vac.population, vac.new_vaccinations
--, (RollingPeopleVaccinated/population)*100
From Covid_Death_Vaccination..CovidDeaths dea
Join Covid_Death_Vaccination..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3



SELECT Location, date, SUM(total_cases), SUM(new_cases), SUM(total_deaths), SUM(population)
FROM Covid_Death_Vaccination..coviddeaths
WHERE continent is not null
ORDER BY 1, 2;

Select Location, date, total_cases,total_deaths, (total_deaths/CASTtotal_cases)*100 as DeathPercentage
From Covid_Death_Vaccination..coviddeaths
Where location like '%states%'
and continent is not null 
order by 1,2

SELECT location, population, max(total_deaths) AS t_deaths, (max(total_deaths)/population) * 100 AS t_death_percent
FROM Covid_Death_Vaccination..coviddeaths
WHERE continent IS NOT NULL AND location like '%ndi%'
GROUP BY location, population
ORDER BY t_death_percent DESC

-- cast(max(total_deaths) as int)

Select Location, date, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
From Po