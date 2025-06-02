# disks-spindown

Script to spin down HDDs after a period of inactivity. 

This can be useful if the drives are used quite rarely and APM via hdparm does not work. 
This script monitors disk activity and executes ```hdparm -yY $device``` to stop 
selected drives 

