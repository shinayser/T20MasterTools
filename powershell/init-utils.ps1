function _LoadPath([string]$path, [string]$folder = 'json') {
    $PSScriptRoot | Split-Path -Parent | Join-Path -ChildPath $folder | Join-Path -ChildPath $path 
}

function Tavernas(
    [string]$Nome,
    [Alias('r')]
    [switch]$Random
) {
    $path = _LoadPath 'tavernas.txt' 'utils'
    $objects = Get-Content $path

    if ($Nome) {
        $objects = $objects | Where-Object { $_ -like "*$Nome*" }
    }    

    if ($Random) {
        $objects | Get-Random
    }
    else {
        $objects

    }

}

function Artefatos-Engracados(
    [string]$Nome,
    [Alias('r')]
    [switch]$Random
) {
    $path = _LoadPath 'artefatos-engracados.json' 'utils'
    $objects = Get-Content $path | convertfrom-json

    if ($Nome) {
        $objects = $objects | Where-Object { $_ -like "*$Nome*" }
    }    

    if ($Random) {
        $objects | Get-Random | fl
    }
    else {
        $objects

    }

}
