Select *
From PortfolioProject.dbo.NashvillHousing

--Standardize Date Fromat

Select SaleDateConverted, CONVERT(Date,SaleDate)
From PortfolioProject.dbo.NashvillHousing

Update NashvillHousing
SET SaleDate = CONVERT(Date,SaleDate)

ALTER TABLE NashvillHousing
Add SaleDateConverted Date;

Update NashvillHousing
SET SaleDateConverted = CONVERT(Date,SaleDate)

--Populate Property Address data 
Select *
From PortfolioProject.dbo.NashvillHousing
--Where PropertyAddress is null
order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
From PortfolioProject.dbo.NashvillHousing a
JOIN PortfolioProject.dbo.NashvillHousing b 
    on a.ParcelID = b.ParcelID
    AND a.[UniqueID] <> b.[UniqueID]

Update a 
SET PropertyAddress =  ISNULL(a.PropertyAddress, b.PropertyAddress)
From PortfolioProject.dbo.NashvillHousing a
JOIN PortfolioProject.dbo.NashvillHousing b 
    on a.ParcelID = b.ParcelID
    AND  a.[UniqueID] <> b.[UniqueID]

--Breaking out address into individual columns( address, city, state)
Select PropertyAddress
From PortfolioProject.dbo.NashvillHousing

Select
SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1) as Address，
SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) +1， LEN(PropertyAddress)) as City
From PortfolioProject.dbo.NashvillHousing

ALTER TABLE NashvillHousing
Add PropertySplitAddress NVARCHAR(255);

Update NashvillHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1)

ALTER TABLE NashvillHousing
Add PropertySplitCity NVARCHAR(255);

Update NashvillHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) +1,LEN(PropertyAddress))

--Select *
--From PortfolioProject.dbo.NashvillHousing

Select OwnerAddress
From PortfolioProject.dbo.NashvillHousing

Select
PARSENAME(REPLACE(OwnerAddress,',',';'),3)
,PARSENAME(REPLACE(OwnerAddress,',',';'),2)
,PARSENAME(REPLACE(OwnerAddress,',',';'),1)
From PortfolioProject.dbo.NashvillHousing

ALTER TABLE NashvillHousing
Add OwnerSplitAddress NVARCHAR(255);

Update NashvillHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',',';'),3)

ALTER TABLE NashvillHousing
Add OwnerSplitCity NVARCHAR(255);

Update NashvillHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',',';'),2)

ALTER TABLE NashvillHousing
Add OwnerSplitState NVARCHAR(255);

Update NashvillHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',',';'),1);

--Select *
--From PortfolioProject.dbo.NashvillHousing


--Change Y and N to Yes and No in "Solad as vacant" field 
Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From PortfolioProject.dbo.NashvillHousing
group by SoldAsVacant
order by 2

Select SoldAsVacant,
CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
     WHEN SoldAsVacant = 'N' THEN 'No'
     ELSE SoldAsVacant
     END 
From PortfolioProject.dbo.NashvillHousing

Update NashvillHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
     WHEN SoldAsVacant = 'N' THEN 'No'
     ELSE SoldAsVacant
     END 

--Remove Duplicates
WITH RowNumCTE AS(
Select *,
ROW_NUMBER()OVER(
     PARTITION BY ParcelID,
                  PropertyAddress,
                  SalePrice,
                  SaleDate,
                  LegalReference
                  ORDER BY 
                      UniqueID
                      )row_number
From PortfolioProject.dbo.NashvillHousing
)

Select *
From RowNumCTE
Where row_number > 1
Orderby PropertyAddress


DELETE
From RowNumCTE
Where row_number > 1

-- Delete unused columns
Select *
From PortfolioProject.dbo.NashvillHousing

ALTER TABLE PortfolioProject.dbo.NashvillHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress