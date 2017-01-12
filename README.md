# CCDLanguageModifier

Edit the batch file to reflect your language and file location.
Then run DoPatch.bat

DoPatch.bat uses XVI32 to patch two files
 1. Copy bin\win32\ClassLib.dll to bin\win32\ClassLiX.dll
 2. Patch \bin\win32\Starter.exe to checksum ClassLiX.dll ;)
 3. Patch bin\win32\ClassLib.dll NOT to write to language.txt (Takes its input from Steam GUI)
 4. Write to language.txt our desired language
 
 