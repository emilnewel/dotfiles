return {
	"kndndrj/nvim-dbee",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	build = function()
		-- Install tries to automatically detect the install method.
		-- if it fails, try calling it with one of these parameters:
		--    "curl", "wget", "bitsadmin", "go"
		require("dbee").install()
	end,
	config = function()
		require("dbee").setup({
			sources = {
				require("dbee.sources").MemorySource:new({
					{
						name = "SQLVAS Prod",
						type = "mssql",
						url = "sqlserver://SQL-SQLVAS-L.visa.is?trusted_connection=true&trustservercertificate=true",
					},
					{
						name = "ReferenceData Prod",
						type = "mssql",
						url = "sqlserver://SQL-COMDW-L.visa.is?trusted_connection=true&trustservercertificate=true",
					},
					{
						name = "DB2VAS",
						type = "mssql",
						url = "sqlserver://sql-sqldb2-l.visa.is?trusted_connection=true&trustservercertificate=true",
					},
					{
						name = "DataLake",
						type = "mssql",
						url = "sqlserver://S1-SQLDW19-P1?trusted_connection=true&trustservercertificate=true",
					},
					{
						name = "SQLVAS TEST",
						type = "mssql",
						url = "sqlserver://SQL-VASTEST-L.visa.is:1433",
					},
					{
						name = "ReferenceData TEST",
						type = "mssql",
						url = "sqlserver://SQL-SQLAG19-L.visa.is?trusted_connection=true&trustservercertificate=true",
					},
					{
						name = "Local Docker DB",
						type = "mssql",
						url = "sqlserver://sa:yourStrong(!)Password@localhost:1433/master",
					},
				}),
				require("dbee.sources").EnvSource:new("DBEE_CONNECTIONS"),
				require("dbee.sources").FileSource:new(vim.fn.stdpath("cache") .. "/dbee/persistence.json"),
			},
		})
	end,
}
