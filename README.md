# MiniStore ETL Project (SSIS + SQL Server)

A small data warehouse project. Data is moved from a source database (`MiniStoreSource`) into a star-schema warehouse (`MiniStoreDW`) using an SSIS package.

## Tools
- SQL Server / SSMS
- SSIS (Visual Studio, SQL Server Integration Services)

## Structure
```
sql/
  01_create_source_db.sql       -- source tables: Customers, Products, Orders, OrderItems
  02_create_data_warehouse.sql  -- DimCustomer, DimProduct, DimDate, FactSales
  03_validate_etl.sql           -- checks source vs warehouse (row counts, total sales)
  04_dw_reports.sql             -- reporting queries on the warehouse
MiniStoreETL/                   -- SSIS project (LoadMiniStoreDW.dtsx)
screenshots/                    -- package run results
```

## ETL package
`LoadMiniStoreDW.dtsx` does this in order:
1. `SQL_Clear_DWH` - clears the warehouse tables
2. `DFT_LoadDimCustomer`
3. `DFT_LoadDimProduct`
4. `DFT_LoadDimDate`
5. `DFT_LoadFactSales`

## How to run
1. Run `01_create_source_db.sql` (creates the source tables and inserts the sample data).
2. Run `02_create_data_warehouse.sql`.
3. Open `MiniStoreETL.slnx` in Visual Studio and change the connection managers (`MiniStoreSource`, `MiniStoreDW`) to your own server name.
4. Run the package.
5. Run `03_validate_etl.sql` to check the results, then `04_dw_reports.sql` for the reports.
