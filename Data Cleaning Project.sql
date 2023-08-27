/* 
Cleaning Data in SQL Queries

*/

Select * 
FROM Data_Cleaning.dbo.NashvilleHousing

-- Standardize Date Format

Select SaleDateConverted, CONVERT(date,SaleDate)
FROM Data_Cleaning.dbo.NashvilleHousing

Update Data_Cleaning.dbo.NashvilleHousing
SET SaleDate = CONVERT(date,SaleDate)

ALTER TABLE NashvilleHousing
Add SaleDateConverted Date;

Update Data_Cleaning.dbo.NashvilleHousing
SET SaleDateConverted = CONVERT(date,SaleDate)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Populate Property Address data

Select *
FROM Data_Cleaning.dbo.NashvilleHousing
--Where PropertyAddress is null
Order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM Data_Cleaning.dbo.NashvilleHousing a
JOIN Data_Cleaning.dbo.NashvilleHousing b
	ON  a.ParcelID = b.ParcelID
	AND a.[UniqueID] <> b.[UniqueID]
Where a.PropertyAddress is null

Update a
SET PropertyAddress= ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM Data_Cleaning.dbo.NashvilleHousing a
JOIN Data_Cleaning.dbo.NashvilleHousing b
	ON  a.ParcelID = b.ParcelID
	AND a.[UniqueID] <> b.[UniqueID]
Where a.PropertyAddress is null

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Breaking out Address into Individual Columns (Address, City, State)

Select PropertyAddress
FROM NashvilleHousing

Select SUBSTRING(PropertyAddress,1,CHARINDEX(',', PropertyAddress)-1) AS Address,
SUBSTRING(PropertyAddress,CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) AS CITY
FROM NashvilleHousing

ALTER TABLE NashvilleHousing
Add PropertySplitAddress nvarchar(255);

Update Data_Cleaning.dbo.NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress,1,CHARINDEX(',', PropertyAddress)-1)

ALTER TABLE NashvilleHousing
Add PropertySplitCity nvarchar(255);

Update Data_Cleaning.dbo.NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress,CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))

Select *
FROM NashvilleHousing


Select OwnerAddress
FROM NashvilleHousing


SELECT
PARSENAME(Replace(OwnerAddress,',','.'),3)
,PARSENAME(Replace(OwnerAddress,',','.'),2)
,PARSENAME(Replace(OwnerAddress,',','.'),1)
FROM NashvilleHousing

ALTER TABLE NashvilleHousing
Add OwnerSplitAddress nvarchar(255);

Update Data_Cleaning.dbo.NashvilleHousing
SET OwnerSplitAddress =PARSENAME(Replace(OwnerAddress,',','.'),3)

ALTER TABLE NashvilleHousing
Add OwnerSplitCity nvarchar(255);

Update Data_Cleaning.dbo.NashvilleHousing
SET OwnerSplitCity = PARSENAME(Replace(OwnerAddress,',','.'),2)

ALTER TABLE NashvilleHousing
Add OwnerSplitState nvarchar(255);

Update Data_Cleaning.dbo.NashvilleHousing
SET OwnerSplitState = PARSENAME(Replace(OwnerAddress,',','.'),1)

Select *
FROM NashvilleHousing

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Change Y and N to Yes and No in "Sold as Vacant" field

Select Distinct(SoldAsVacant), COUNT(SoldAsVacant)
From NashvilleHousing
GROUP BY SoldAsVacant
Order by 2

Select SoldAsVacant,
CASE When SoldAsVacant = 'Y' Then 'Yes'
	 When SoldAsVacant = 'N' Then 'No'
	 Else SoldAsVacant
	 End
From NashvilleHousing

Update NashvilleHousing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' Then 'Yes'
	 When SoldAsVacant = 'N' Then 'No'
	 Else SoldAsVacant
	 End

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Remove Duplicates

WITH RowNumCTE AS (
Select *,
	ROW_NUMBER () OVER (Partition By ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference
	ORDER BY UniqueID) row_num
From NashvilleHousing
)
Select *
From RowNumCTE
Where row_num > 1



------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Delete Unused Columns

Select *
FROM NashvilleHousing

Alter Table NashvilleHousing
DROP COLUMN SaleDate