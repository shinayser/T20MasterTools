#Todos os comandos listados aqui necessitam do módulo https://github.com/mkht/PSOpenAI
function Personalidade-AI {
    $comando = "Dê um nome e escreva um parágrafo contando sobre o seguinte npc, dado este json de sua personalidade: $(Personalidade | ConvertTo-Json)"
    $resposta = Request-ChatCompletion -Message $comando
    $resposta.Answer
}