#Todos os comandos listados aqui necessitam do módulo https://github.com/mkht/PSOpenAI
function Personalidade-AI {
    $comando = "Dê um nome e escreva um parágrafo, separado por bullets com 3 tópicos: 'Nome', 'Aparência' e 'Trejeitos', contando sobre o seguinte npc, dado este json de sua personalidade: $(Personalidade | ConvertTo-Json)"
    $resposta = Request-ChatCompletion -Message $comando -Model 'gpt-4o'
    $resposta.Answer
}

#You must grab the your assistant with the Get-Assistant function and set it to a global $assistant variable
function Oraculo-AI([string]$Pergunta) {
    if ($null -eq $assistant) {
        throw "Assistant não definido."
    } 

    $Result = Start-ThreadRun -Assistant $assistant -Message $Pergunta | Receive-ThreadRun -Wait
    $result.Messages | Where-Object role -eq 'assistant' | ForEach-Object simplecontent | ForEach-Object content | glow
}