# BulkRestorePST
Restores multiple backup jobs to a corresponding PST file with matching job number

Usage: 

Modify $InputFile to reflect your directory and path

Modify the following XML sections:

        <destPath>PST:D:\restore\restore_'+$jobID+'.pst</destPath>
			  <clientName>MyExchangeServer</clientName>
				


