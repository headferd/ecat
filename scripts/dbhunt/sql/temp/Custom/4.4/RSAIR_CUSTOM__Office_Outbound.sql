SELECT 
mn.MachineName, 
ad.Description as AdminStatus,
mn.Comment,
CONVERT(VARCHAR, na.FirstConnectionUTC,120) AS FirstConnectionUTC, 
CONVERT(VARCHAR, na.LastConnectionUTC,120) AS LastConnectionUTC, 
pn.Filename as ProcessFilename, 
sfn.Filename as SourceFilename, 
na.Port, 
dom.Domain, 
na.IP, 
na.UserAgent, 
LaunchArguments

FROM
    [dbo].[mocNetAddresses] AS [na] WITH(NOLOCK)
	LEFT JOIN [dbo].[MachineModulePaths] AS [mp] WITH(NOLOCK) ON ([mp].[PK_MachineModulePaths] = [na].[FK_MachineModulePaths])
	LEFT JOIN [dbo].[FileNames] AS [sfn] WITH(NOLOCK) ON ([sfn].[PK_FileNames] = [mp].[FK_FileNames])
	LEFT JOIN [dbo].[machines] AS [mn] WITH(NOLOCK) ON [mn].[PK_Machines] = [na].[FK_Machines]
	LEFT JOIN [dbo].[Filenames] AS [pn] WITH(NOLOCK) ON ([pn].[PK_FileNames] = [na].[FK_FileNames__Process])
	LEFT JOIN [dbo].[Domains] AS [dom]  WITH(NOLOCK) ON ([dom].[PK_Domains] = [na].[FK_Domains__DomainHost])
	LEFT JOIN [dbo].[LaunchArguments] as [sla] WITH(NOLOCK) ON ([sla].[PK_LaunchArguments] = [na].[FK_LaunchArguments])
	INNER JOIN [dbo].[AdminStatus] AS [ad] WITH(NOLOCK) ON [ad].[PK_Adminstatus] = [mn].[FK_AdminStatus]
WHERE


sfn.filename in ('excel.exe', 'word.exe', 'powerpnt.exe', 'eqnedt32.exe')
