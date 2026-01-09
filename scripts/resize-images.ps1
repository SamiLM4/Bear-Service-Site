<#
  resize-images.ps1
  Script simples para padronizar imagens em quadros (square) usando ImageMagick (magick).

  Uso:
    .\resize-images.ps1 -Source "assets/images" -Dest "assets/images/optimized" -Size 700

  O script procura por arquivos .jpg/.jpeg/.png no diretório Source e grava imagens quadradas redimensionadas no diretório Dest.
  Requer: ImageMagick instalado (com comando `magick` disponível no PATH).
#>
param(
  [string]$Source = "assets/images",
  [string]$Dest = "assets/images/optimized",
  [int]$Size = 700
)

if(!(Test-Path $Source)){
  Write-Host "Diretório de origem '$Source' não encontrado." -ForegroundColor Red
  exit 1
}

if(!(Test-Path $Dest)){
  New-Item -ItemType Directory -Path $Dest | Out-Null
}

Get-ChildItem -Path $Source -Include *.jpg,*.jpeg,*.png -File -Recurse | ForEach-Object {
  $in = $_.FullName
  $out = Join-Path -Path $Dest -ChildPath $_.Name

  if(Get-Command magick -ErrorAction SilentlyContinue){
    # resize: ^ força crop para preencher ambos os lados, gravity center para centralizar
    magick "${in}" -resize ${Size}x${Size}^ -gravity center -extent ${Size}x${Size} -quality 85 "${out}"
    Write-Host "Processado: $($_.Name) -> $out"
  } else {
    Write-Host "ImageMagick não encontrado. Instale-o (https://imagemagick.org) e rode o script novamente." -ForegroundColor Yellow
    exit 1
  }
}

Write-Host "Concluído. Arquivos padronizados em: $Dest" -ForegroundColor Green