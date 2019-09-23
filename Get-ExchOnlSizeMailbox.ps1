#Script para ordenar los buzones que mayor consumo presentan.
Get-Mailbox -ResultSize Unlimited | Get-MailboxStatistics | Select DisplayName,StorageLimitStatus,@{name="TotalItemSize (MB)";expression={[math]::Round((($_.TotalItemSize.Value.ToString()).Split("(")[1].Split(" ")[0].Replace(",","")/1MB),2)}},@{name="TotalDeletedItemSize (MB)";expression={[math]::Round((($_.TotalDeletedItemSize.Value.ToString()).Split("(")[1].Split(" ")[0].Replace(",","")/1MB),2)}},ItemCount,DeletedItemCount | Sort "TotalItemSize (MB)" -Descending | Export-CSV "C:\My Documents\All Mailboxes.csv" -NoTypeInformation 

#Script para determinar los buzones que excedan su cuota. 
Get-Mailbox -ResultSize Unlimited | Get-MailboxStatistics | where {$_.StorageLimitStatus -notlike "BelowLimit*"} | Select DisplayName,StorageLimitStatus,@{name="TotalItemSize (MB)";expression={[math]::Round((($_.TotalItemSize.Value.ToString()).Split("(")[1].Split(" ")[0].Replace(",","")/1MB),2)}},@{name="TotalDeletedItemSize (MB)";expression={[math]::Round((($_.TotalDeletedItemSize.Value.ToString()).Split("(")[1].Split(" ")[0].Replace(",","")/1MB),2)}},ItemCount,DeletedItemCount | Sort "TotalItemSize (MB)" -Descending | Export-CSV "C:\My Documents\Exceeded Quotas.csv" -NoTypeInformation 