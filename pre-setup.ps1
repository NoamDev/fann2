echo "Downloading FANN-2 sources."
wget https://sourceforge.net/projects/fann/files/fann/2.2.0/FANN-2.2.0-Source.zip/download -OutFile FANN-2.2.0-Source.zip -UserAgent [Microsoft.PowerShell.Commands.PSUserAgent]::FireFox
echo "Validating hash"
$expectde = Get-Content FANN-2.2.0-Source.zip.sha256
$downloaded = (Get-FileHash -Path FANN-2.2.0-Source.zip -Algorithm sha256).Hash
if($expectde -ne $downloaded) {
	Write-Error Downloaded file does not match FANN-2.2.0-Source.zip.sha256
	exit 1
}
echo "Extracting sources"
Expand-Archive FANN-2.2.0-Source.zip . -Force
echo "Runing SWIG"
swig.exe -c++ -python -I"FANN-2.2.0-Source\src\include"  fann2\fann2.i
echo "Done"