# BulkRestorePST
Restores multiple backup jobs to a corresponding PST file with matching job number for Compliance Archiver Journal Data. However, it could be modified for any type of restore and the appropriate XML generated in Commvault. This was a use case that maybe helpful as a starting point.

Usage: 

Modify $InputFile to reflect your directory and path

Modify the following XML sections:

        <destPath>PST:D:\restore\restore_'+$jobID+'.pst</destPath>
	<clientName>MyExchangeServer</clientName>
	 <fromTimeValue>2008-09-01 09:32:43</fromTimeValue>
	 <toTimeValue>2018-10-23 09:39:24</toTimeValue>


