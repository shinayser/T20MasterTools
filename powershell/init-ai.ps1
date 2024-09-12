#Todos os comandos listados aqui necessitam do módulo https://github.com/mkht/PSOpenAI
function Personalidade-AI {
    $comando = "Dê um nome e escreva um parágrafo, separado por bullets com 3 tópicos: 'Nome', 'Aparência' e 'Trejeitos', contando sobre o seguinte npc, dado este json de sua personalidade: $(Personalidade | ConvertTo-Json)"
    $resposta = Request-ChatCompletion -Message $comando -Model 'gpt-4o'
    $resposta.Answer
}