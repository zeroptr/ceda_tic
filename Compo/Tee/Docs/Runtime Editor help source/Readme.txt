TeeUser help source

-------------------------
Files:

Readme.txt  -	this file
teeuser8.rtf - 	user help file source
teeuser8.hpj - 	Microsoft Help compiler 
		project file
Context_ids.txt - Help ids to coincide with 
		  Chart Editor's item numbers
-------------------------

Instructions to use:

To modify the user helpfile, 

1. Open the teeuser8.rtf file and modify the text 
contents to your requirements.

2. Open the Microsoft Help compiler (included with Delphi) 
and open the teeuser8.hpj help project file.

3. Compile the new teeuser helpfile with the MS Help 
compiler.

4. When supplying the teeuser helpfile with your TeeChart 
project you will need to modify this registry path in the
client machine:


[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Help]

with the following entry, replacing your directory path:

"teeuser8.hlp"="yourdrive:\\your installation path"
