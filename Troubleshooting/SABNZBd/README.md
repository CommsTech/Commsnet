Certificate issues
A fix has been posted here:

https://forums.sabnzbd.org/viewtopic.php?p=125877#p125877

It's an issue with an expired "R3" intermediate certificate.

Following these directions worked for me.

Open Run and type mmc.exe

Select <File>, <Add/Remove Snap-In..>

Choose <Certificates>

Select <My User Account>, and click<OK>

Expand <Certificates - Current User>

Expand <Intermediate Certificate Authorities>, and Click <Certificates>

Find the expired R3 and delete it.