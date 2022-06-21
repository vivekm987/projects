Select *
From PortfolioProject..CovidDeath
order by 3,4

Select Location, date, total_cases, new_cases, total_deaths,population
From PortfolioProject..CovidDeath
order by 1,2

--Looking at Total cases vs Total Deaths

Select Location, date, total_cases, total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeath
where location like '%India%'
order by 1,2

--Shows what percentage of population got covid

Select Location, date, population, total_cases,(total_cases/population)*100 as Covidpositive
From PortfolioProject..CovidDeath
where location like '%India%'
order by 1,2

--looking at countries with highest covid rate compared to population

Select Location, population, max(total_cases) as highestCovidCount,Max(total_cases/population)*100 as percentpopulationinfected
From PortfolioProject..CovidDeath
Group by location, population
order by percentpopulationinfected desc

--showing highest Death Count per population

Select Location, max(cast(total_cases as int)) as totalDeathCount
From PortfolioProject..CovidDeath
where continent is not null
Group by location
order by totalDeathCount desc

-- continent with highest death count per population

Select continent, max(cast(total_cases as int)) as totalDeathCount
From PortfolioProject..CovidDeath
where continent is not null
Group by continent
order by totalDeathCount desc

--Global Numbers


Select date, sum(new_cases)as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeath
--where location like '%India%'
where continent is not null
Group by date 
order by 1,2

Select *
From PortfolioProject..CovidDeath dea
join portfolioproject..CovidVaccination vac
on dea.location = vac.location
and dea.date = vac.date

-- Total population vs Total vaccination

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(cast(vac.new_vaccinations as Bigint)) over (partition by dea.location order by dea.location, dea.Date) as PeopleVaccinated
From PortfolioProject..CovidDeath dea
join portfolioproject..CovidVaccination vac
on dea.location = vac.location
and dea.date = vac.date
--where dea.continent is null
order by 2,3


