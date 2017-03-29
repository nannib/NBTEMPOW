# NBTEMPOW V. 2.1
NBTempoW is a forensic tool for making timelines from block devices image files (raw, ewf or \\.\physicaldriveX). It uses TSK (The Sleuthkit https://www.sleuthkit.org/) and it has been developed with Lazarus V. 1.6.2 (Delphi compatible cross-platform IDE for Rapid Application Development). It runs only in Windows.
If the device image file is splitted, you can select just the first chunk.

For listing physicaldrive in Windows, open CMD and write:
wmic diskdrive list brief /format:list

then you can use the physical drive ad input for NBTempoW:
\\.\physicaldrive0

Author: Nanni Bassetti - http://www.nannibassetti.com
