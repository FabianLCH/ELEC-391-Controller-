@echo off
::This file was created automatically by CrossIDE to compile with C51.
C:
cd "\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\"
"C:\CrossIDE\Call51\Bin\c51.exe" --use-stdout  "C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c"
if not exist hex2mif.exe goto done
if exist PCA.ihx hex2mif PCA.ihx
if exist PCA.hex hex2mif PCA.hex
:done
echo done
echo Crosside_Action Set_Hex_File C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.hex
