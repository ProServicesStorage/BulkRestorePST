# Restore Jobs in bulk to pst with name in format restore_JobID.pst
# Reads input file with one job ID per line.
# The job ID should correspond to an Exchange mailbox backup

# Modify this path and file to your file with job numbers
$InputFile = 'C:\cvscripts\jobinputfile.txt'



$JobIdArray = Get-Content -Path $InputFile

foreach ($jobID in $JobIdArray)

{

	$jobID
	$tmpXmlFile = [System.IO.Path]::GetTempFileName()
	$TmpXML = '<?xml version="1.0" encoding="UTF-8" standalone="no" ?>
	<TMMsg_CreateTaskReq>

	  <processinginstructioninfo/>

	  <taskInfo>
		<task>
		  <taskFlags>
			<disabled>false</disabled>
		  </taskFlags>
		  <policyType>DATA_PROTECTION</policyType>
		  <taskType>IMMEDIATE</taskType>
		  <initiatedFrom>COMMANDLINE</initiatedFrom>
		  <alert>
			<alertName></alertName>
		  </alert>
		</task>
		<associations>
		  <type>GALAXY</type>
		  <subclientName>Journal</subclientName>
		  <backupsetName>defaultArchiveSet</backupsetName>
		  <instanceName>defaultInstance</instanceName>
		  <appName>Exchange Compliance Archiver</appName>
		  <clientName>pa1exch01</clientName>
		  <consumeLicense>true</consumeLicense>
		  <clientSidePackage>true</clientSidePackage>
		</associations>
		<subTasks>
		  <subTask>
			<subTaskType>RESTORE</subTaskType>
			<operationType>RESTORE</operationType>
		  </subTask>
		  <options>
			<backupOpts>
			  <backupLevel>INCREMENTAL</backupLevel>
			  <vsaBackupOptions/>
			</backupOpts>
			<restoreOptions>
			  <browseOption>
				<commCellId>2</commCellId>
				<backupset>
				  <backupsetName>defaultArchiveSet</backupsetName>
				  <clientName>MyExchangeServer</clientName>
				</backupset>
				<timeRange>
				  <fromTimeValue>2008-09-01 09:32:43</fromTimeValue>
				  <toTimeValue>2018-10-23 09:39:24</toTimeValue>
				</timeRange>
				<noImage>false</noImage>
				<useExactIndex>false</useExactIndex>
				<mediaOption>
				  <library/>
				  <mediaAgent/>
				  <drivePool/>
				  <drive/>
				  <copyPrecedence>
					<copyPrecedenceApplicable>false</copyPrecedenceApplicable>
					<synchronousCopyPrecedence>0</synchronousCopyPrecedence>
					<copyPrecedence>0</copyPrecedence>
				  </copyPrecedence>
				</mediaOption>
				<timeZone>
				  <TimeZoneName>(UTC-05:00) Eastern Time (US &amp; Canada)</TimeZoneName>
				</timeZone>
				<listMedia>false</listMedia>
				<browseJobId>'+$jobID+'</browseJobId>
				<browseJobCommCellId>2</browseJobCommCellId>
			  </browseOption>
			  <destination>
				<destPath>PST:D:\restore\restore_'+$jobID+'.pst</destPath>
				<destClient>
				  <clientName>MyExchangeServer</clientName>
				</destClient>
				<inPlace>true</inPlace>
				<isLegalHold>false</isLegalHold>
				<noOfStreams>0</noOfStreams>
			  </destination>
			  <oracleOpt>
				<tableViewRestore>false</tableViewRestore>
			  </oracleOpt>
			  <exchangeOption>
				<exchangeRestoreChoice>TO_PST_FILE</exchangeRestoreChoice>
				<exchangeRestoreDrive>LOCAL_DRIVE</exchangeRestoreDrive>
				<pstFilePath>D:\restore\restore_jobid.pst</pstFilePath>
				<pstRestoreOption>TO_SINGLE_PST</pstRestoreOption>
				<pstSize>0</pstSize>
			  </exchangeOption>
			  <sharePointRstOption>
				<is90OrUpgradedClient>false</is90OrUpgradedClient>
			  </sharePointRstOption>
			  <volumeRstOption>
				<volumeLeveRestore>false</volumeLeveRestore>
			  </volumeRstOption>
			  <virtualServerRstOption>
				<isBlockLevelReplication>false</isBlockLevelReplication>
			  </virtualServerRstOption>
			  <fileOption>
				<sourceItem>\MB</sourceItem>
				<browseFilters>&lt;?xml version=''1.0'' encoding=''UTF-8''?&gt;&lt;databrowse_Query type="0" queryId="0"&gt;&lt;dataParam&gt;&lt;paging firstNode="0" pageSize="1000" skipNode="0" /&gt;&lt;/dataParam&gt;&lt;/databrowse_Query&gt;</browseFilters>
			  </fileOption>
			  <commonOptions>
				<detectRegularExpression>true</detectRegularExpression>
				<restoreDeviceFilesAsRegularFiles>false</restoreDeviceFilesAsRegularFiles>
				<restoreSpaceRestrictions>false</restoreSpaceRestrictions>
				<ignoreNamespaceRequirements>false</ignoreNamespaceRequirements>
				<skipErrorsAndContinue>false</skipErrorsAndContinue>
				<onePassRestore>false</onePassRestore>
				<revert>false</revert>
				<recoverAllProtectedMails>false</recoverAllProtectedMails>
				<offlineMiningRestore>false</offlineMiningRestore>
				<isFromBrowseBackup>false</isFromBrowseBackup>
				<clusterDBBackedup>false</clusterDBBackedup>
				<restoreToDisk>false</restoreToDisk>
				<syncRestore>false</syncRestore>
			  </commonOptions>
			  <hanaOpt>
				<cloneEnv>false</cloneEnv>
			  </hanaOpt>
			  <distributedAppsRestoreOptions>
				<distributedRestore>false</distributedRestore>
				<isMultiNodeRestore>false</isMultiNodeRestore>
			  </distributedAppsRestoreOptions>
			</restoreOptions>
			<adminOpts>
			  <contentIndexingOption>
				<subClientBasedAnalytics>false</subClientBasedAnalytics>
			  </contentIndexingOption>
			</adminOpts>
			<commonOpts>
			  <startUpOpts>
				<startInSuspendedState>false</startInSuspendedState>
				<priority>166</priority>
				<useDefaultPriority>true</useDefaultPriority>
			  </startUpOpts>
			  <jobDescription></jobDescription>
			</commonOpts>
		  </options>
		  <subTaskOperation>OVERWRITE</subTaskOperation>
		</subTasks>
	  </taskInfo>

	</TMMsg_CreateTaskReq>
	'

	$TmpXML | Set-Content $tmpXmlFile
	qoperation execute -af $tmpXmlFile
	Remove-Item $tmpXmlFile

}

# End Script
