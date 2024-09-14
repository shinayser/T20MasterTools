$includeGhanor = $true
$includeAmeacas = $true
$includeDeusesHerois = $true

function script:_LoadPath([string]$path, [string]$folder = 'json-t20') {
    $PSScriptRoot | Split-Path -Parent | Join-Path -ChildPath $folder | Join-Path -ChildPath $path 
}

function Acessorios(
    [string]$Nome,
    [Alias("t")]
    [ValidateSet("menor", "medio", "maior")]
    $Tipo,

    [Alias("p")]
    [switch]$Preco,

    
    [Alias("d")]
    [string]$Descricao
) {
    $path = _LoadPath 'Acessorios.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($includeAmeacas) {
        $path = _LoadPath 'Acessorios.json' 'json-ameacas-arton'
        $ameacas += Get-Content $path | ConvertFrom-Json
        $ameacas | ForEach-Object {
            Add-Member -InputObject $_ -MemberType NoteProperty -Name 'set' -Value 'ameacas'
        }

        $objects += $ameacas
    }

    if ($Nome) {
        $objects = $objects | Where-Object { $_.nome -like "*$Nome*" }
    }

    if ($Tipo) {
        $objects = $objects | Where-Object { $_.tipo -like "*$Tipo*" }
    }

    if ($Descricao) {
        $objects = $objects | Where-Object -Property descricao -Like "*$Descricao*"
    }

    if ($Preco) {
        $objects = $objects | Sort-Object preco
    }

    if ($objects.Length -le 3) {
        $objects | Format-List
    }
    else {
        $objects
    }
}

function Perigos-Complexos(
    [string]$Nome
) {
    $path = _LoadPath 'perigos-complexos.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($Nome) {
        $objects = $objects | Where-Object { $_.nome -like "*$Nome*" }
    }
    if ($objects.Length -eq 1) {
        $objects | ConvertTo-Json -Depth 10
    }
    else {
        $objects
    }
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

    if ($includeGhanor) {
        $path = _LoadPath 'armaduras.json' 'json-ghanor'
        $ghanor += Get-Content $path | ConvertFrom-Json
        $ghanor | ForEach-Object {
            Add-Member -InputObject $_ -MemberType NoteProperty -Name 'set' -Value 'ghanor'
        }
        $objects += $ghanor
    }

    
    if ($includeAmeacas) {
        $path = _LoadPath 'armaduras.json' 'json-ameacas-arton'
        $ameacas += Get-Content $path | ConvertFrom-Json
        $ameacas | ForEach-Object {
            Add-Member -InputObject $_ -MemberType NoteProperty -Name 'set' -Value 'ameacas'
        }
        $objects += $ameacas
    }

    $objects = $objects | Sort-Object nome

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

function Armas(
    [string]$Nome,
    [Alias("c")]
    [ValidateSet("simples", "marcial", "exotica")]
    $Classe,
    [Alias("t")]
    [ValidateSet("perfuracao", "corte", "impacto")]
    $Tipo,
    [Alias("e")]
    [ValidateSet("uma-mao", "duas-maos", "leve")]
    $Empunhadura
) {
    $path = _LoadPath 'armas.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($includeGhanor) {
        $path = _LoadPath 'armas.json' 'json-ghanor'
        $ghanor += Get-Content $path | ConvertFrom-Json
        $ghanor | ForEach-Object {
            Add-Member -InputObject $_ -MemberType NoteProperty -Name 'set' -Value 'ghanor'
        }
        $objects += $ghanor
    }

    if ($includeAmeacas) {
        $path = _LoadPath 'armas.json' 'json-ameacas-arton'
        $ameacas += Get-Content $path | ConvertFrom-Json
        $ameacas | ForEach-Object {
            Add-Member -InputObject $_ -MemberType NoteProperty -Name 'set' -Value 'ameacas'
        }
        $objects += $ameacas
    }

    $objects = $objects | Sort-Object nome

    if ($Nome) {
        $objects = $objects | Where-Object { $_.nome -like "*$Nome*" }
    }

    if ($Classe) {
        $objects = $objects | Where-Object { $_.classe -like "*$Classe*" }
    }

    if ($Tipo) {
        $objects = $objects | Where-Object { $_.tipo -like "*$Tipo*" }
    }

    if ($Empunhadura) {
        $objects = $objects | Where-Object { $_.empunhadura -like "*$Empunhadura*" }
    }


    $objects
}

function Armas-Habilidades([string]$Nome) {
    $path = _LoadPath 'armas-habilidades.json' 
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

    if ($includeGhanor) {
        $path = _LoadPath 'itens-gerais.json' 'json-ghanor'
        $ghanor += Get-Content $path | ConvertFrom-Json
        $ghanor | ForEach-Object {
            Add-Member -InputObject $_ -MemberType NoteProperty -Name 'set' -Value 'ghanor'
        }
        $objects += $ghanor
    }

    if ($includeAmeacas) {
        $path = _LoadPath 'itens-gerais.json' 'json-ameacas-arton'
        $ameacas += Get-Content $path | ConvertFrom-Json
        $ameacas | ForEach-Object {
            Add-Member -InputObject $_ -MemberType NoteProperty -Name 'set' -Value 'ameacas'
        }
        $objects += $ameacas
    }

    $objects = $objects | Sort-Object nome

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

function Item-Random(
    [ValidateSet('arma', 'armadura', 'esoterico')]
    [string]$tipo,
    [ValidateSet(1, 2, 3, 4)]
    [string]$Superior
) {
    if (!$tipo) {
        # 1-3 arma, 4-5 armadura, 6 esoterico
        $tipo = 'arma', 'arma', 'arma', 'armadura', 'armadura', 'esoterico' | Get-Random  
    }
    

    function _Pega-Item( $arquivo) {
        $path = _LoadPath $arquivo
        $objects = Get-Content $path | ConvertFrom-Json            
        $objects | ForEach-Object { 

            for ($i = 0; $i -lt $_.Chances; $i++) {
                [PSCustomObject]@{                
                    Nome       = $_.Nome;
                    Quantidade = $_.Quantidade ?? 1;
                }
            }
                
        } | Get-Random
    }

    function _Pega-Melhoria($tipo, $quantidade) {
        $path = _LoadPath 'melhorias-random.json'
        $listaDeMelhorias = Get-Content $path | 
        ConvertFrom-Json | 
        Where-Object { $_.Tipo -eq $tipo } | 
        ForEach-Object { 

            for ($i = 0; $i -lt $_.Chances; $i++) {
                [PSCustomObject]@{                
                    Nome  = $_.Nome
                    Dupla = $_.Dupla ?? $false
                }
            }
            
        }

        $quantidadeSobrando = $quantidade

        $melhoriasRetornadas = @()

        do {
            $melhoriaAleatoria = $listaDeMelhorias | Get-Random

            if ($melhoriasRetornadas -contains $melhoriaAleatoria.Nome) {
                continue
            }             

            $melhoria = Melhorias -Nome $melhoriaAleatoria.Nome -NotFormatted

            if ($melhoriaAleatoria.dupla) {
                if ($quantidadeSobrando -ge 2) {
                    $melhoriasRetornadas += $melhoria.nome
                    $melhoria | format-list
                    $quantidadeSobrando -= 2
                }
            }
            else {
                $melhoriasRetornadas += $melhoria.nome
                $melhoria | format-list
                if ($melhoriaAleatoria.Nome -eq 'Material especial') {
                    Materiais-Especiais | Get-Random | Format-List
                }
                $quantidadeSobrando -= 1
            }


        } while ($quantidadeSobrando -gt 0);

    }


    switch ($tipo) {
        'arma' {
            Write-Host "# Arma" -ForegroundColor blue

            $itemAleatorio = _Pega-Item 'armas-random.json' 
            $arma = Armas -Nome $itemAleatorio.Nome 

            # Check if arma is a list
            if ($arma -is [System.Array]) {
                $arma = $arma | Select-Object -First 1
            }

            Add-Member -InputObject $arma -MemberType NoteProperty -Name 'quantidade' -Value $itemAleatorio.quantidade

            $arma 

            if ($Superior) {
                Write-Host "# Melhorias" -ForegroundColor blue
                _Pega-Melhoria $tipo $Superior
            }

                       
        }
        'armadura' {
            Write-Host "# Armadura/Escudo" -ForegroundColor blue

            $itemAleatorio = _Pega-Item 'armaduras-random.json' 
            Armaduras -Nome $itemAleatorio.Nome 

            if ($Superior) {
                Write-Host "# Melhorias" -ForegroundColor blue
                _Pega-Melhoria $tipo $Superior
            }

        }
        'esoterico' {
            Write-Host "# Esotérico" -ForegroundColor blue

            $itemAleatorio = _Pega-Item 'esotericos-random.json' 
            Esotericos -Nome $itemAleatorio.Nome

            if ($Superior) {
                Write-Host "# Melhorias" -ForegroundColor blue
                _Pega-Melhoria $tipo $Superior
            }
        }
    }
   

}

function Riquezas(
    [ValidateSet("menor", "media", "maior")]
    [string]$Nivel
) {
    $path = _LoadPath 'riquezas.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    switch ($Nivel) {
        'menor' {
            $objects | ForEach-Object { 
                if ($_.menor -eq '-') { return; }

                [PSCustomObject]@{                
                    menor    = $_.menor;
                    valor    = $_.valor;
                    exemplos = $_.exemplos;
                } } 
        }
        'media' {
            $objects | ForEach-Object { 
                if ($_.media -eq '-') { return; }

                [PSCustomObject]@{                
                    media    = $_.media;
                    valor    = $_.valor;
                    exemplos = $_.exemplos;
                } } 
        }
        'maior' {
            $objects | ForEach-Object { 
                if ($_.maior -eq '-') { return; }

                [PSCustomObject]@{                
                    maior    = $_.maior;
                    valor    = $_.valor;
                    exemplos = $_.exemplos;
                } } 
        }
        Default {
            $objects | Format-Table
        }
    }
    
}


function Recompensas-ItensDiversos(
) {
    $path = _LoadPath 'recompensas-itens-diversos.json' 
    $objects = Get-Content $path | ConvertFrom-Json
    
    $objects | Format-Table

}

function Recompensas-Armas(
) {
    $path = _LoadPath 'recompensas-armas.json' 
    $objects = Get-Content $path | ConvertFrom-Json
    
    $objects | Format-Table

}

function Recompensas-Armaduras(
) {
    $path = _LoadPath 'recompensas-armaduras.json' 
    $objects = Get-Content $path | ConvertFrom-Json
    
    $objects | Format-Table

}

function Recompensas-ArmadurasSuperiores(
) {
    $path = _LoadPath 'recompensas-armaduras-superiores.json' 
    $objects = Get-Content $path | ConvertFrom-Json
    
    $objects | Format-Table

}
function Recompensas-ArmasSuperiores(
) {
    $path = _LoadPath 'recompensas-armas-superiores.json' 
    $objects = Get-Content $path | ConvertFrom-Json
    
    $objects | Format-Table

}

function Recompensas-Esotericos(
) {
    $path = _LoadPath 'recompensas-esotericos.json' 
    $objects = Get-Content $path | ConvertFrom-Json
    
    $objects | Format-Table

}

function Recompensas-EsotericosSuperiores(
) {
    $path = _LoadPath 'recompensas-esotericos-superiores.json' 
    $objects = Get-Content $path | ConvertFrom-Json
    
    $objects | Format-Table

}

function Vestuarios(
    [string]$Nome, 
    [string]$Descricao
) {
    $path = _LoadPath 'vestuarios.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($includeGhanor) {
        $path = _LoadPath 'vestuarios.json' 'json-ghanor'
        $ghanor += Get-Content $path | ConvertFrom-Json
        $ghanor | ForEach-Object {
            Add-Member -InputObject $_ -MemberType NoteProperty -Name 'set' -Value 'ghanor'
        }
        $objects += $ghanor
    }

    if ($includeAmeacas) {
        $path = _LoadPath 'vestuarios.json' 'json-ameacas-arton'
        $ameacas += Get-Content $path | ConvertFrom-Json
        $ameacas | ForEach-Object {
            Add-Member -InputObject $_ -MemberType NoteProperty -Name 'set' -Value 'ameacas'
        }
        $objects += $ameacas
    }


    $objects = $objects | Sort-Object nome
   
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
   
    if ($includeGhanor) {
        $path = _LoadPath 'ferramentas.json' 'json-ghanor'
        $ghanor += Get-Content $path | ConvertFrom-Json
        $ghanor | ForEach-Object {
            Add-Member -InputObject $_ -MemberType NoteProperty -Name 'set' -Value 'ghanor'
        }
        $objects += $ghanor
    }

    $objects = $objects | Sort-Object nome

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
    
    if ($includeGhanor) {
        $path = _LoadPath 'esotericos.json' 'json-ghanor'
        $ghanor += Get-Content $path | ConvertFrom-Json
        $ghanor | ForEach-Object {
            Add-Member -InputObject $_ -MemberType NoteProperty -Name 'set' -Value 'ghanor'
        }
        $objects += $ghanor
    }

    
    if ($includeAmeacas) {
        $path = _LoadPath 'esotericos.json' 'json-ameacas-arton'
        $ameacas += Get-Content $path | ConvertFrom-Json
        $ameacas | ForEach-Object {
            Add-Member -InputObject $_ -MemberType NoteProperty -Name 'set' -Value 'ameacas'
        }
        $objects += $ameacas
    }

    $objects = $objects | Sort-Object nome

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

function Alquimicos-Preparados(
    [string]$Nome,
    [string]$Descricao
) {
    $path = _LoadPath 'alquimicos-preparados.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($includeGhanor) {
        $path = _LoadPath 'alquimicos-preparados.json' 'json-ghanor'
        $ghanor += Get-Content $path | ConvertFrom-Json
        $ghanor | ForEach-Object {
            Add-Member -InputObject $_ -MemberType NoteProperty -Name 'set' -Value 'ghanor'
        }
        $objects += $ghanor
    }

    if ($includeAmeacas) {
        $path = _LoadPath 'alquimicos-preparados.json' 'json-ameacas-arton'
        $ameacas += Get-Content $path | ConvertFrom-Json
        $ameacas | ForEach-Object {
            Add-Member -InputObject $_ -MemberType NoteProperty -Name 'set' -Value 'ameacas'
        }
        $objects += $ameacas
    }

    $objects = $objects | Sort-Object nome

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

function Alquimicos-Catalisadores(
    [string]$Nome,
    [string]$Descricao
) {
    $path = _LoadPath 'alquimicos-catalisadores.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($includeGhanor) {
        $path = _LoadPath 'alquimicos-catalisadores.json' 'json-ghanor'
        $ghanor += Get-Content $path | ConvertFrom-Json
        $ghanor | ForEach-Object {
            Add-Member -InputObject $_ -MemberType NoteProperty -Name 'set' -Value 'ghanor'
        }
        $objects += $ghanor
    }

    if ($includeAmeacas) {
        $path = _LoadPath 'alquimicos-catalisadores.json' 'json-ameacas-arton'
        $ameacas += Get-Content $path | ConvertFrom-Json
        $ameacas | ForEach-Object {
            Add-Member -InputObject $_ -MemberType NoteProperty -Name 'set' -Value 'ameacas'
        }
        $objects += $ameacas
    }

    $objects = $objects | Sort-Object nome

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

function Alquimicos-Venenos(
    [string]$Nome,
    [string]$Descricao
) {
    $path = _LoadPath 'alquimicos-venenos.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($includeGhanor) {
        $path = _LoadPath 'alquimicos-venenos.json' 'json-ghanor'
        $ghanor += Get-Content $path | ConvertFrom-Json
        $ghanor | ForEach-Object {
            Add-Member -InputObject $_ -MemberType NoteProperty -Name 'set' -Value 'ghanor'
        }
        $objects += $ghanor
    }

    if ($includeAmeacas) {
        $path = _LoadPath 'alquimicos-venenos.json' 'json-ameacas-arton'
        $ameacas += Get-Content $path | ConvertFrom-Json
        $ameacas | ForEach-Object {
            Add-Member -InputObject $_ -MemberType NoteProperty -Name 'set' -Value 'ameacas'
        }
        $objects += $ameacas
    }

    $objects = $objects | Sort-Object nome

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

function Animais(
    [string]$Nome,
    [string]$Descricao
) {
    $path = _LoadPath 'animais.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($includeAmeacas) {
        $path = _LoadPath 'animais.json' 'json-ameacas-arton'
        $ameacas += Get-Content $path | ConvertFrom-Json
        $ameacas | ForEach-Object {
            Add-Member -InputObject $_ -MemberType NoteProperty -Name 'set' -Value 'ameacas'
        }
        $objects += $ameacas
    }

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

function Veiculos(
    [string]$Nome,
    [string]$Descricao
) {
    $path = _LoadPath 'veiculos.json' 
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

function Servicos-Hospedagem(
    [string]$Nome,
    [string]$Descricao
) {
    $path = _LoadPath 'servicos-hospedagem.json' 
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

function Servicos-Outros(
    [string]$Nome,
    [string]$Descricao
) {
    $path = _LoadPath 'servicos-outros.json' 
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

function Alimentacao(
    [string]$Nome,
    [string]$Descricao
) {
    $path = _LoadPath 'alimentacao.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($includeAmeacas) {
        $path = _LoadPath 'alimentacao.json' 'json-ameacas-arton'
        $ameacas += Get-Content $path | ConvertFrom-Json
        $ameacas | ForEach-Object {
            Add-Member -InputObject $_ -MemberType NoteProperty -Name 'set' -Value 'ameacas'
        }
        $objects += $ameacas
    }

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

function Armadilhas(
    [string]$Nome,
    [string]$Efeito,
    [string]$Nivel,
    [switch]$Magica
) {
    $path = _LoadPath 'armadilhas.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($Nome) {
        $objects = $objects | Where-Object { $_.Nome -like "*$Nome*" }
    }
    
    if ($Efeito) {
        $objects = $objects | Where-Object { $_.efeito -like "*$efeito*" }
    }
    
    if ($nivel) {
        $objects = $objects | Where-Object { $_.nivel -eq $nivel }
    }
    
    if ($Magica) {
        $objects = $objects | Where-Object { $_.magica -eq 'sim' }
    }

    if ($objects.Length -le 3) {
        $objects | Format-List
    }
    else {
        $objects
    }
}

function Doencas(
    [string]$Nome,
    [string]$Efeito
) {
    $path = _LoadPath 'doencas.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($Nome) {
        $objects = $objects | Where-Object { $_.Nome -like "*$Nome*" }
    }
    
    if ($Efeito) {
        $objects = $objects | Where-Object { $_.efeito -like "*$efeito*" }
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

function Portas([string]$Tipo) {
    $path = _LoadPath 'portas.json' 
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

function Materiais-Especiais-Precos([string]$Nome) {
    $path = _LoadPath 'materiais-especiais-precos.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($includeAmeacas) {
        $path = _LoadPath 'materiais-especiais-precos.json' 'json-ameacas-arton'
        $ameacas += Get-Content $path | ConvertFrom-Json
        $ameacas | ForEach-Object {
            Add-Member -InputObject $_ -MemberType NoteProperty -Name 'set' -Value 'ameacas'
        }
        $objects += $ameacas
    }

    if ($Nome) {
        $objects | Where-Object { $_.nome -like "*$Nome*" }
    }
    else {
        $objects 
    }
}

function Materiais-Especiais([string]$Nome) {
    $path = _LoadPath 'materiais-especiais.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($includeAmeacas) {
        $path = _LoadPath 'materiais-especiais.json' 'json-ameacas-arton'
        $ameacas += Get-Content $path | ConvertFrom-Json
        $ameacas | ForEach-Object {
            Add-Member -InputObject $_ -MemberType NoteProperty -Name 'set' -Value 'ameacas'
        }
        $objects += $ameacas
    }


    if ($Nome) {
        $objects = $objects | Where-Object { $_.nome -like "*$Nome*" }
    }


    $objects | ForEach-Object {
        Add-Member -InputObject $_ -MemberType NoteProperty -Name 'precos' -Value (Materiais-Especiais-Precos -Nome $_.nome)
    }

    if ($objects.Length -le 3) {
        $objects | ConvertTo-Json -Depth 10
    }
    else {
        $objects
    }

}

function Melhorias-Precos() {
    $path = _LoadPath 'melhorias-precos.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    $objects
}

function Encantos-Precos() {
    $path = _LoadPath 'encantos-precos.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    $objects
}

function Melhorias(
    [string]$Nome,
    [Alias("t")]
    [ValidateSet("armas", "armaduras", "escudos", "esotericos", "ferramentas", "vestuario")]
    $Tipo,
    [switch]
    $NotFormatted
) {

    $path = _LoadPath 'melhorias.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($includeAmeacas) {
        $path = _LoadPath 'melhorias.json' 'json-ameacas-arton'
        $ameacas += Get-Content $path | ConvertFrom-Json
        $ameacas | ForEach-Object {
            Add-Member -InputObject $_ -MemberType NoteProperty -Name 'set' -Value 'ameacas'
        }
        $objects += $ameacas
    }


    if ($Nome) {
        $objects = $objects | Where-Object { $_.nome -like "*$Nome*" }
    }
    
    if ($Tipo) {
        $objects = $objects | Where-Object { $_.tipo -like "*$Tipo*" -or $_.tipo -eq "qualquer" }
    }

    if ($objects.Length -le 3) {
        if ($NotFormatted) {
            $objects
        }
        else {
            $objects | Format-List
        }
    }
    else {
        $objects
    }

}

function Poderes(
    [string]$Nome,
    [Alias("t")]
    [ValidateSet(
        "combate", 
        "destino", 
        "magia", 
        "aprimoramento", 
        "concedido", 
        "aharadak", 
        "allihanna", 
        "arsenal", 
        "azgher", 
        "hyninn", 
        "kally", 
        "khalmyr", 
        "lena", 
        "lin-Wu", 
        "marah", 
        "nimb", 
        "oceano", 
        "sszzaas", 
        "tanna-toh", 
        "tenebra", 
        "thwor", 
        "thyatis", 
        "valkaria", 
        "wynna"
    )]
    $Tipo,
    [string]$Desc

) {

    $path = _LoadPath 'poderes.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($Nome) {
        $objects = $objects | Where-Object { $_.nome -like "*$Nome*" }
    }
    
    if ($Tipo) {
        $objects = $objects | Where-Object { $_.tipo -like "*$Tipo*" }
    }
    
    if ($Desc) {
        $objects = $objects | Where-Object { $_.desc -like "*$Desc*" }
    }

    if ($objects.Length -le 3) {
        $objects | Format-List
    }
    else {
        $objects
    }

}

function Magias(
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]$Nome,
    [Alias("t")]
    [ValidateSet(
        "arcana", 
        "divina", 
        "universal"
    )]
    $Classe,
    [ValidateSet(
        "abjuracao", 
        "adivinhacao", 
        "convocacao",
        "encantamento",
        "evocacao",
        "ilusao",
        "necromancia",
        "transmutacao"
    )]
    $Escola,
    [int]$Ciclo,
    [string]$Desc

) {
    
    if ($Nome) {
        $Nome = ($Nome -replace "\(.*\)", "").Trim()
    }

    $path = _LoadPath 'magias.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($includeAmeacas) {
        $path = _LoadPath 'magias.json' 'json-ameacas-arton'
        $ameacas += Get-Content $path | ConvertFrom-Json
        $ameacas | ForEach-Object {
            Add-Member -InputObject $_ -MemberType NoteProperty -Name 'set' -Value 'ameacas'
        }
        $objects += $ameacas
    }

    if ($Nome) {
        $objects = $objects | Where-Object { $_.nome -like "*$Nome*" }
    }
    
    if ($Classe) {
        $objects = $objects | Where-Object { $_.Classe -like "*$Classe*" -or $_.Classe -eq "universal" }
    }
    
    if ($Escola) {
        $objects = $objects | Where-Object { $_.Escola -like "*$Escola*" }
    }
    
    if ($Ciclo) {
        $objects = $objects | Where-Object { $_.Ciclo -like "*$Ciclo*" }
    }

    # if ($objects.Length -eq 1) {

    $objects | ForEach-Object {
        $aprimoramentos = $_.aprimoramentos
        $_.PsObject.Members.Remove("aprimoramentos")
        $_
        Write-Host "Aprimoramentos:`n" -ForegroundColor Green
        $aprimoramentos
    }

    # $aprimoramentos = $objects.aprimoramentos
    # $objects.PsObject.Members.Remove("aprimoramentos")
    # $objects
    # Write-Host "Aprimoramentos:`n" -ForegroundColor Green
    # $aprimoramentos
    # }
    # else {
    #     $objects
    # }

}

function Pericias([string]$Nome) {
    $path = _LoadPath 'pericias.json' 
    $objects = Get-Content $path | ConvertFrom-Json

    if ($Nome) {
        $objects = $objects | Where-Object { $_.nome -like "*$Nome*" }
    }    

    # None top level object has found
    if ($objects.Length -eq 0) { 
        $objects = Get-Content $path | ConvertFrom-Json | ForEach-Object {
            $pericia = $_.nome 
            $_.lista | ForEach-Object {
                Add-Member -InputObject $_ -MemberType NoteProperty -Name 'pericia' -Value $pericia
                $_
            }
        } |  Where-Object { $_.nome -like "*$Nome*" }
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

function Pocoes(
    [Alias("r")]
    [switch]$Random
) {
    $path = _LoadPath 'pocoes.json' 
    $objects = Get-Content $path | ConvertFrom-Json
    $objects = $objects | Sort-Object rollMin

    if ($Random) {
        $roll = Get-random -Minimum 1 -Maximum 100
        $objects | Where-Object { $_.rollMin -le $roll -and $_.rollMax -ge $roll }
    }
    else {
        $objects
    }
    
}


function Estatisticas-Criaturas(
    [Parameter(Mandatory)]
    [ValidateSet(
        "solo", 
        "lacaio", 
        "especial"
    )]
    [string]$tipo, 
    [string[]]$nd ) {

    $objects
    switch ($tipo) {
        'solo' {
            $path = _LoadPath 'estatisticas_criaturas_solo.json' 'json-ameacas-arton'
            $objects = Get-Content $path | ConvertFrom-Json 
        }
        'lacaio' {
            $path = _LoadPath 'estatisticas_criaturas_lacaio.json' 'json-ameacas-arton'
            $objects = Get-Content $path | ConvertFrom-Json 
        }
        'especial' {
            $path = _LoadPath 'estatisticas_criaturas_especial.json' 'json-ameacas-arton'
            $objects = Get-Content $path | ConvertFrom-Json
        }
    }

    if ($nd) {
        $objects = $objects | Where-Object { $nd -contains $_.nd }
    }

    $objects | Format-Table
}

function Busca-Item(
    [Parameter(Mandatory)]
    [string]$Nome) {
    $busca = Itens-Gerais -Nome $Nome
    if ($busca.Length -gt 0) {
        Write-Host "# Itens Gerais" -ForegroundColor blue
        $busca
    }
    $busca = Ferramentas -Nome $Nome
    if ($busca.Length -gt 0) {
        Write-Host "# Ferramentas" -ForegroundColor blue
        $busca
    }
    $busca = Vestuarios -Nome $Nome
    if ($busca.Length -gt 0) {
        Write-Host "# Vestuarios" -ForegroundColor blue
        $busca
    }
    $busca = Esotericos -Nome $Nome
    if ($busca.Length -gt 0) {
        Write-Host "# Esotericos" -ForegroundColor blue
        $busca
    }
    $busca = Alquimicos-Preparados -Nome $Nome
    if ($busca.Length -gt 0) {
        Write-Host "# Alquimicos-Preparados" -ForegroundColor blue
        $busca
    }
    $busca = Alquimicos-Catalisadores -Nome $Nome
    if ($busca.Length -gt 0) {
        Write-Host "# Alquimicos-Catalisadores" -ForegroundColor blue
        $busca
    }
    $busca = Alquimicos-Venenos -Nome $Nome
    if ($busca.Length -gt 0) {
        Write-Host "# Alquimicos-Venenos" -ForegroundColor blue
        $busca
    }
    $busca = Alimentacao -Nome $Nome
    if ($busca.Length -gt 0) {
        Write-Host "# Alimentacao" -ForegroundColor blue
        $busca
    }
    $busca = Animais -Nome $Nome
    if ($busca.Length -gt 0) {
        Write-Host "# Animais" -ForegroundColor blue
        $busca
    }
    $busca = Veiculos -Nome $Nome
    if ($busca.Length -gt 0) {
        Write-Host "# Veiculos" -ForegroundColor blue
        $busca
    }
    $busca = Servicos-Outros -Nome $Nome
    if ($busca.Length -gt 0) {
        Write-Host "# Servicos-Outros" -ForegroundColor blue
        $busca
    }
    $busca = Servicos-Hospedagem -Nome $Nome
    if ($busca.Length -gt 0) {
        Write-Host "# Servicos-Hospedagem" -ForegroundColor blue
        $busca
    }
    $busca = Armas -Nome $Nome
    if ($busca.Length -gt 0) {
        Write-Host "# Armas" -ForegroundColor blue
        $busca
    }
    $busca = Armaduras -Nome $Nome
    if ($busca.Length -gt 0) {
        Write-Host "# Armaduras" -ForegroundColor blue
        $busca
    }
    $busca = Acessorios -Nome $Nome
    if ($busca.Length -gt 0) {
        Write-Host "# Acessorios" -ForegroundColor blue
        $busca
    }
}

function Aparencias(
    [Alias("r")]
    [switch]$random ) {
    $path = _LoadPath 'aparencias.json' 'json-deuses-e-herois'
    $objects = Get-Content $path | ConvertFrom-Json

    if ($random) {
        $objects | Get-Random
    }
    else {
        $objects
    }
}

function Trejeitos(
    [Alias("r")]
    [switch]$random ) {
    $path = _LoadPath 'trejeitos.json' 'json-deuses-e-herois'
    $objects = Get-Content $path | ConvertFrom-Json

    if ($random) {
        $objects | Get-Random
    }
    else {
        $objects
    }
}

function Personalidade(
    [Alias("r")]
    [switch]$random ) {
    
    $quantidadeAparencias = (Get-Random -Maximum 3 -Minimum 1) + 1 
    $quantidadeTrejeitos = (Get-Random -Maximum 2 -Minimum 0) + 1

    $aparencias = @()
    for ($i = 0; $i -lt $quantidadeAparencias; $i++) {
        $aparencias += (Aparencias -random)
    }

    $trejeitos = @()
    for ($i = 0; $i -lt $quantidadeTrejeitos; $i++) {
        $trejeitos += (Trejeitos -random)
    }

    return @{
        aparencias = $aparencias
        trejeitos  = $trejeitos
    }
        
}


Set-Alias Comidas Alimentacao
Set-Alias Hospedagem Servicos-Hospedagem
Set-Alias bi Busca-Item
Set-Alias magia Magias
Set-Alias pocao Pocoes
Set-Alias poder Poderes
Set-Alias riqueza Riquezas
Set-Alias tesouro Riquezas
Set-Alias stat Estatisticas-Criaturas


function Listar {
    $regex = "function\s+((?!Listar)[^_][\w|-]+)"
    $content = Get-Content -Path $PSCommandPath -Raw

    $funcoes = $content | Select-String -Pattern $regex -AllMatches | ForEach-Object { $_.Matches } | ForEach-Object { $_.Groups[1].Value } | Sort-Object


    $funcoes | ForEach-Object {
        Write-Host $_ -ForegroundColor Green 
    }

}