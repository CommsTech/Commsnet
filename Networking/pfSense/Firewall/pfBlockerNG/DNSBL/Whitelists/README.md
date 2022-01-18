Download the lists you want into a folder
Shift rightclick and open powershell 
type cmd then and run the following 
for %f in (*.txt) do type “%f” >> Compiled_Whitelist.log
Compiled_Whitelist.log > Compiled_Whitelist.txt