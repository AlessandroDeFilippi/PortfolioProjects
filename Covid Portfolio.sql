-- Exploring data

Select *
From Portfolio..CovidDeaths
where continent is not null
order by 3,4

--Select *
--From Portfolio..CovidVaccinations
--order by 3,4

Select Location, date, total_cases, new_cases, total_deaths, population
From Portfolio..CovidDeaths
order by 1,2

-- Looking at total cases vs total deaths in italy

Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From Portfolio..CovidDeaths
where location like '%italy%'
order by 1,2

-- Looking at total cases vs pupulation
-- Shows what percentage of population got covid in italy


Select Location, date, total_cases, population, (total_cases/population)*100 as PercentPopulationInfected
From Portfolio..CovidDeaths
where location like '%italy%'
order by 1,2

-- Looking at countries with highest infection rate compared to population in world

Select Location, MAX(total_cases) as HighestInfectCount, population, MAX((total_cases/population))*100 as PercentPopulationInfected
From Portfolio..CovidDeaths
--where location like '%italy%'
group by Location, population
order by PercentPopulationInfected desc

-- Showing countries with highest death count per population, changed data type to int

Select Location, MAX(cast(total_deaths as int)) as Totaldeathcount
From Portfolio..CovidDeaths
where continent is not null
group by Location
order by Totaldeathcount desc

-- Explore by continent
-- Showing continents with highest death count per population

Select continent, MAX(cast(total_deaths as int)) as Totaldeathcount
From Portfolio..CovidDeaths
where continent is not null
group by continent
order by Totaldeathcount desc


-- global numbers
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as deathpercentage
From Portfolio..CovidDeaths
where continent is not null
--group by date
order by 1,2

-- Looking at total population vs vaccinations
-- USE CTE
with PopVsVac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as int)) OVER (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
--(people_vaccinated/population)*100 as PopVsVac
From Portfolio..CovidDeaths dea
Join Portfolio..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3
)
Select *, (RollingPeopleVaccinated/population)*100
From PopVsVac


-- Temp table
DROP table if exists #PercentPopulationVaccinated
Create table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)
Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as int)) OVER (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
--(people_vaccinated/population)*100 as PopVsVac
From Portfolio..CovidDeaths dea
Join Portfolio..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null
--order by 2,3
Select *, (RollingPeopleVaccinated/population)*100
From #PercentPopulationVaccinated


-- Creating view to store data for later viz

create view PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as int)) OVER (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
--(people_vaccinated/population)*100 as PopVsVac
From Portfolio..CovidDeaths dea
Join Portfolio..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3


Select*
From PercentPopulationVaccinated