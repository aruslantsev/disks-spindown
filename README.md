# disks-spindown

Tool for spinning down HDDs if power management via hdparm does not work. 
This tool checks if any amount of data have been read or written to disk 
and executes ```hdparm -yY $device``` for the selected devices after the 
timeout.
