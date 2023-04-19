$clip = (Get-Clipboard -Raw).Trim().Replace("`r", "")
$match = $clip -match "(?s)(?<nome>.*)\n(?<classe>(Arcana|Divina|Universal))\s(?<circulo>\d)\s\((?<escola>.*)\).*Execução:\s(?<execucao>.*?);\sAlcance:\s(?<alcance>.*?);(\sAlvo:\s(?<alvo>.*?);)?(\sÁrea:\s(?<area>.*?);)?(\sEfeito:\s(?<efeito>.*?);)?.Duração:\s(?<duracao>.*?)(;|\.)(\sResistência:\s(?<resistencia>.*?)\.)?\n(?<desc>.*?)(\n|\z)(?=(Truque)|(\+|\Z))"
if (!$Matches) {
    Write-Error "Not Matched."
    return
}
$magia = [pscustomobject]@{
    nome   = $matches.nome -replace "`n", " ";
    classe = $matches.classe -replace "`n", " ";
    ciclo  = $matches.circulo -replace "`n", " ";
    escola = $matches.escola -replace "`n", " ";    
    # execucao    = $matches.execucao;
    # alcance     = $matches.alcance;
    # alvo        = $matches.alvo;
    # area        = $matches.area;
    # duracao     = $matches.duracao;
    # resistencia = $matches.resistencia;
    # desc        = $matches.desc;
}

if ($Matches.execucao) {
    Add-Member -InputObject $magia -MemberType NoteProperty -Name execucao -Value ($Matches.execucao -replace "`n", " ")
}

if ($Matches.alcance) {
    Add-Member -InputObject $magia -MemberType NoteProperty -Name alcance -Value ($Matches.alcance -replace "`n", " ")
}

if ($Matches.alvo) {
    Add-Member -InputObject $magia -MemberType NoteProperty -Name alvo -Value ($Matches.alvo -replace "`n", " ")
}

if ($Matches.efeito) {
    Add-Member -InputObject $magia -MemberType NoteProperty -Name efeito -Value ($Matches.efeito -replace "`n", " ")
}

if ($Matches.area) {
    Add-Member -InputObject $magia -MemberType NoteProperty -Name area -Value ($Matches.area -replace "`n", " ")
}

if ($Matches.duracao) {
    Add-Member -InputObject $magia -MemberType NoteProperty -Name duracao -Value ($Matches.duracao -replace "`n", " ")
}

if ($Matches.resistencia) {
    Add-Member -InputObject $magia -MemberType NoteProperty -Name resistencia -Value ($Matches.resistencia -replace "`n", " ")
}


Add-Member -InputObject $magia -MemberType NoteProperty -Name desc -Value ($Matches.desc -replace "`n", " ")

$pattern = "(?s)(?<custo>((\+\d+.PM)|(Truque)).*?):\s(?<desc>.*?[.!?]((\n(?=\+))|\Z))"
if ($clip -match $pattern) {
    $magia | Add-member -MemberType NoteProperty -Name aprimoramentos -Value (@())

    $clip | Select-String -Pattern $pattern -AllMatches | 
    ForEach-Object { $_.Matches } | 
    ForEach-Object {
        $custo = $_.Groups.where({ $_.Name -eq "custo" }).Value -replace "`n", " "
        $desc = $_.Groups.where({ $_.Name -eq "desc" }).Value -replace "`n", " "  

        $magia.aprimoramentos += [pscustomobject]@{
            custo = $custo
            desc  = $desc
        }

    }
} 
  


Write-Output $magia

$magiaJson = $magia | ConvertTo-json
$magiaJson += ','
$magiaJson | Set-Clipboard
