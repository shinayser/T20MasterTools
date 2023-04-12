function _LoadPath([string]$path) {
    $PSScriptRoot | Split-Path -Parent | Join-Path -ChildPath 'json' | Join-Path -ChildPath $path 
}

function Climas([string]$Filter) {
    $path = _LoadPath 'climas.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($Filter) {
        $objects | Where-Object { $_.tipo -like "*$Filter*" }
    }
    else {
        $objects
    }
}

function Acessorios(
    [string]$Nome,
    [Alias("t")]
    [ValidateSet("menor", "medio", "maior")]
    $Tipo,

    [Alias("p")]
    [switch]$Preco
) {
    $path = _LoadPath 'Acessorios.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($Nome) {
        $objects = $objects | Where-Object { $_.nome -like "*$Nome*" }
    }

    if ($Tipo) {
        $objects = $objects | Where-Object { $_.tipo -like "*$Tipo*" }
    }

    if ($Preco) {
        $objects = $objects | Sort-Object preco
    }

    $objects
}
function Armaduras(
    [string]$Nome,
    [Alias("c")]
    [ValidateSet("leve", "pesada", "escudo")]
    $Classe,

    [Alias("p")]
    [switch]$Preco
) {
    $path = _LoadPath 'armaduras.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($Nome) {
        $objects = $objects | Where-Object { $_.nome -like "*$Nome*" }
    }

    if ($Classe) {
        $objects = $objects | Where-Object { $_.classe -like "*$Classe*" }
    }

    if ($Preco) {
        $objects = $objects | Sort-Object preco
    }

    $objects
}

function Armas([string]$Nome) {
    $path = _LoadPath 'armas.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($Nome) {
        $objects | Where-Object { $_.Nome -like "*$Nome*" }
    }
    else {
        $objects
    }
}

function Itens-Gerais(
    [string]$Nome,
    [string]$Descricao
) {
    $path = _LoadPath 'itens-gerais.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($Nome) {
        $objects = $objects | Where-Object { $_.Nome -like "*$Nome*" }
    }
    
    if ($Descricao) {
        $objects = $objects | Where-Object { $_.Descricao -like "*$Descricao*" }
    }
    
    if ($objects.Length -le 3) {
        $objects | Format-List
    }
    else {
        $objects
    }
}
function Vestuarios(
    [string]$Nome, 
    [string]$Descricao
) {
    $path = _LoadPath 'vestuarios.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($Nome) {
        $objects = $objects | Where-Object { $_.Nome -like "*$Nome*" }
    }

    if ($Descricao) {
        $objects = $objects | Where-Object { $_.Descricao -like "*$Descricao*" }
    }
    
    if ($objects.Length -le 3) {
        $objects | Format-List
    }
    else {
        $objects
    }
}

function Ferramentas(
    [string]$Nome,
    [string]$Descricao
) {
    $path = _LoadPath 'ferramentas.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($Nome) {
        $objects = $objects | Where-Object { $_.Nome -like "*$Nome*" }
    }
    
    if ($Descricao) {
        $objects = $objects | Where-Object { $_.Descricao -like "*$Descricao*" }
    }

    if ($objects.Length -le 3) {
        $objects | Format-List
    }
    else {
        $objects
    }
}

function Esotericos(
    [string]$Nome,
    [string]$Descricao
) {
    $path = _LoadPath 'esotericos.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($Nome) {
        $objects = $objects | Where-Object { $_.Nome -like "*$Nome*" }
    }
    
    if ($Descricao) {
        $objects = $objects | Where-Object { $_.Descricao -like "*$Descricao*" }
    }

    if ($objects.Length -le 3) {
        $objects | Format-List
    }
    else {
        $objects
    }
}

function Climas([string]$Tipo) {
    $path = _LoadPath 'climas.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($Tipo) {
        $objects | Where-Object { $_.tipo -like "*$Tipo*" }
    }
    else {
        $objects
    }
}

function Condicoes([string]$Nome) {
    $path = _LoadPath 'condicoes.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($Nome) {
        $objects | Where-Object { $_.nome -like "*$Nome*" } | ConvertTo-Json -Depth 10
    }
    else {
        $objects
    }
}

function Encantos-Armaduras([string]$Nome) {
    $path = _LoadPath 'encantos-armaduras.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($Nome) {
        $objects = $objects | Where-Object { $_.nome -like "*$Nome*" }
    }

    if ($objects.Length -le 3) {
        $objects | Format-List
    }
    else {
        $objects
    }
}

function Encantos-Armas([string]$Nome) {
    $path = _LoadPath 'encantos-armas.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($Nome) {
        $objects = $objects | Where-Object { $_.nome -like "*$Nome*" }
    }
    
    if ($objects.Length -le 3) {
        $objects | Format-List
    }
    else {
        $objects
    }
}

function Magias-Custos([string]$Filter) {
    $path = _LoadPath 'magias-custos.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($Filter) {
        $objects | Where-Object { $_.tipo -like "*$Filter*" }
    }
    else {
        $objects
    }
}

function Materiais-Especiais-Precos([string]$Filter) {
    $path = _LoadPath 'materiais-especiais-precos.json' 
    $objects = Get-Content $path | ConvertFrom-Json | Format-Table

    if ($Filter) {
        $objects | Where-Object { $_.tipo -like "*$Filter*" }
    }
    else {
        $objects
    }
}

function Materiais-Especiais([string]$Nome) {
    $path = _LoadPath 'materiais-especiais.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($Nome) {
        $objects = $objects | Where-Object { $_.nome -like "*$Nome*" }
    }

    if ($objects.Length -le 3) {
        $objects | ConvertTo-Json -Depth 10
    }
    else {
        $objects
    }

}

function Melhorias-Precos([string]$Filter) {
    $path = _LoadPath 'melhorias-precos.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($Filter) {
        $objects | Where-Object { $_.tipo -like "*$Filter*" }
    }
    else {
        $objects
    }
}

function Melhorias(
    [string]$Nome,
    [Alias("t")]
    [ValidateSet("armas", "armaduras", "escudos", "esotericos", "ferramentas", "vestuario")]
    $Tipo
) {

    $path = _LoadPath 'melhorias.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($Nome) {
        $objects = $objects | Where-Object { $_.nome -like "*$Nome*" }
    }
    
    if ($Tipo) {
        $objects = $objects | Where-Object { $_.tipo -like "*$Tipo*" -or $_.tipo -eq "qualquer" }
    }

    if ($objects.Length -le 3) {
        $objects | Format-List
    }
    else {
        $objects
    }

}

function Pericias([string]$Nome) {
    $path = _LoadPath 'pericias.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($Nome) {
        $objects = $objects | Where-Object { $_.nome -like "*$Nome*" }
    }    

    # None top level object has found
    if ($objects.Length -eq 0) { 
        $objects = Get-Content $path | ConvertFrom-Json | ForEach-Object { $_.lista } |  Where-Object { $_.nome -like "*$Nome*" }
    }
    elseif ($objects.Length -eq 1 -and $objects[0].lista.Length -gt 0) {
        $objects = $objects.lista
    }
        
    if ($objects.Length -le 3) {
        $objects | Format-List
    }
    else {
        $objects
    }
}