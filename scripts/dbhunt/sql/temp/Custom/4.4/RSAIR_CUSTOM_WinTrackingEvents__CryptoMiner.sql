--CryptoMiner.sql

SELECT  mn.MachineName, 
		se.EventUTCTime, 
		pa.Path as 'SourcePath', 
		fn.Filename as 'SourceFile', 
		se.Path_Target, 
		se.FileName_Target, 
		se.LaunchArguments_Target, 
		la.LaunchArguments as 'SourceArguments',
		se.Username
FROM
	--[dbo].[WinTrackingEventsCache] AS [se] WITH(NOLOCK)
	[dbo].[WinTrackingEvents_P0] AS [se] WITH(NOLOCK)
	--[dbo].[WinTrackingEvents_P1] AS [se] WITH(NOLOCK)
	INNER JOIN [dbo].[MachineModulePaths] AS [mp] WITH(NOLOCK) ON ([mp].[PK_MachineModulePaths] = [se].[FK_MachineModulePaths])
	--INNER JOIN [dbo].[Modules] AS [mo] WITH(NOLOCK) ON ([mo].[PK_Modules] = [mp].[FK_Modules])
	INNER JOIN [dbo].[FileNames] AS [fn] WITH(NOLOCK) ON ([fn].[PK_FileNames] = [mp].[FK_FileNames])
	INNER JOIN [dbo].[machines] AS [mn] WITH(NOLOCK) ON [mn].[PK_Machines] = [se].[FK_Machines]
	--INNER JOIN [dbo].[LinkedServers] AS [ls] WITH(NOLOCK) ON [ls].[PK_LinkedServers] = [mn].[FK_LinkedServers] 
	INNER JOIN [dbo].[LaunchArguments] AS [la] WITH(NOLOCK) ON [la].[PK_LaunchArguments] = [se].[FK_LaunchArguments__SourceCommandLine]
    INNER JOIN [dbo].[paths] as [pa] with(NOLOCK) on [mp].[FK_Paths] = [pa].[PK_Paths]
WHERE 
se.LaunchArguments_Target LIKE N'%stratum%'
OR se.LaunchArguments_Target LIKE N'%cryptonight%'
OR se.LaunchArguments_Target LIKE N'%--donate-level%'
OR se.LaunchArguments_Target LIKE N'%--max-cpu-usage%'

UNION 

SELECT  mn.MachineName, 
		se.EventUTCTime, 
		pa.Path as 'SourcePath', 
		fn.Filename as 'SourceFile', 
		se.Path_Target, 
		se.FileName_Target, 
		se.LaunchArguments_Target, 
		la.LaunchArguments as 'SourceArguments',
		se.Username
FROM
	--[dbo].[WinTrackingEventsCache] AS [se] WITH(NOLOCK)
	--[dbo].[WinTrackingEvents_P0] AS [se] WITH(NOLOCK)
	[dbo].[WinTrackingEvents_P1] AS [se] WITH(NOLOCK)
	INNER JOIN [dbo].[MachineModulePaths] AS [mp] WITH(NOLOCK) ON ([mp].[PK_MachineModulePaths] = [se].[FK_MachineModulePaths])
	--INNER JOIN [dbo].[Modules] AS [mo] WITH(NOLOCK) ON ([mo].[PK_Modules] = [mp].[FK_Modules])
	INNER JOIN [dbo].[FileNames] AS [fn] WITH(NOLOCK) ON ([fn].[PK_FileNames] = [mp].[FK_FileNames])
	INNER JOIN [dbo].[machines] AS [mn] WITH(NOLOCK) ON [mn].[PK_Machines] = [se].[FK_Machines]
	--INNER JOIN [dbo].[LinkedServers] AS [ls] WITH(NOLOCK) ON [ls].[PK_LinkedServers] = [mn].[FK_LinkedServers] 
	INNER JOIN [dbo].[LaunchArguments] AS [la] WITH(NOLOCK) ON [la].[PK_LaunchArguments] = [se].[FK_LaunchArguments__SourceCommandLine]
    INNER JOIN [dbo].[paths] as [pa] with(NOLOCK) on [mp].[FK_Paths] = [pa].[PK_Paths]
WHERE  
se.LaunchArguments_Target LIKE N'%stratum%'
OR se.LaunchArguments_Target LIKE N'%cryptonight%'
OR se.LaunchArguments_Target LIKE N'%--donate-level%'
OR se.LaunchArguments_Target LIKE N'%--max-cpu-usage%'


