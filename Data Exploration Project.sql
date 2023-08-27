Select location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject.dbo.CovidDeaths$
Order by 1,2

-- Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid, based on location

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM PortfolioProject.dbo.CovidDeaths$
WHERE location like '%states'
Order by 1,2

-- Looking at Total Cases vs Population
-- Shows Infection Rate

Select location, date, total_cases, population, (total_cases/population)*100 as InfectionRate
FROM PortfolioProject.dbo.CovidDeaths$
WHERE location like '%states'
Order by 1,2

-- Looking at Countries with Highest Infection Rate compared to Population
-- Need GROUP by because you must show only one value for each location and population

Select location, population, MAX(total_cases) HighestInfectionCount, MAX((total_cases/population))*100 as MaxInfection
FROM PortfolioProject.dbo.CovidDeaths$
Group by Population, Location
Order by 4 DESC

--Showing Countries with Highest Death Count per Population
--Issues here are due to data type of the column Total_deaths being a nvarchar

Select location, MAX(cast(total_deaths as int)) as HighestDeathCount
FROM PortfolioProject.dbo.CovidDeaths$
WHERE continent is not null
Group by Location
Order by 2 DESC

--Showing Continents with the Highest Death Counts

SELECT location, MAX(cast(total_deaths as int)) as HighestDeathCount
FROM PortfolioProject.dbo.CovidDeaths$
WHERE continent is null
Group by location
Order by 2 DESC

--GLOBAL NUMBERS

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From PortfolioProject.dbo.CovidDeaths$
where continent is not null 
order by 1,2


--Total Population vs Vaccination
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(convert(int,vac.new_vaccinations)) over (partition by dea.location ORDER by dea.location, dea.date) as RollingPeopleVaccinated
From PortfolioProject.dbo.CovidDeaths$ dea
Join PortfolioProject.dbo.CovidVaccinations$ vac
	on dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
Order by 2,3

--USE CTE
With PopvsVac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(convert(int,vac.new_vaccinations)) over (partition by dea.location ORDER by dea.location, dea.date) as RollingPeopleVaccinated
From PortfolioProject.dbo.CovidDeaths$ dea
Join PortfolioProject.dbo.CovidVaccinations$ vac
	on dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
--Order by 2,3
)
Select * , (RollingPeopleVaccinated/population)*100
From PopvsVac

--Temp Table
Drop Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(Continent nvarchar (255),
Location nvarchar (255),
date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)
Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(convert(int,vac.new_vaccinations)) over (partition by dea.location ORDER by dea.location, dea.date) as RollingPeopleVaccinated
From PortfolioProject.dbo.CovidDeaths$ dea
Join PortfolioProject.dbo.CovidVaccinations$ vac
	on dea.location = vac.location
	and dea.date = vac.date

Select * , (RollingPeopleVaccinated/population)*100 as PercentVaccinated
From #PercentPopulationVaccinated

--Creating View to Store data for later visualizations (permanent)
Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(convert(int,vac.new_vaccinations)) over (partition by dea.location ORDER by dea.location, dea.date) as RollingPeopleVaccinated
From PortfolioProject.dbo.CovidDeaths$ dea
Join PortfolioProject.dbo.CovidVaccinations$ vac
	on dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
--Order by 2,3