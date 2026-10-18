# Trabalho 1 - DCC148

## Bubble Bobble Remake

Protótipo desenvolvido para a disciplina DCC148 com inspiração no jogo **Bubble Bobble**. O jogador controla um personagem que se movimenta por uma arena com plataformas, sopra bolhas para prender os inimigos e estoura as bolhas para derrotá-los.

## Objetivo

Derrotar os inimigos usando bolhas, acumular pontos e sobreviver enquanto a vida do jogador não chegar a zero.

## Funcionalidades

- Movimentação lateral e pulo em uma arena 2D.
- Disparo de bolhas na direção em que o personagem está olhando.
- Inimigos com movimentação, pulo e mudança aleatória de aparência.
- Inimigos presos dentro de bolhas e derrotados quando a bolha é estourada.
- Pontuação por inimigo derrotado e indicador de vida.
- Plataformas geradas na arena durante o início da partida.
- Dois modos de jogo:
  - **START**: partida com uma quantidade limitada de inimigos.
  - **ENDLESS MODE**: partida com geração contínua de inimigos.
- Tela de vitória ao concluir a partida e tela de derrota quando o jogador perde toda a vida.

## Controles

| Ação | Tecla |
| --- | --- |
| Mover para a esquerda | `Seta esquerda` |
| Mover para a direita | `Seta direita` |
| Pular | `Seta para cima` |
| Soprar uma bolha | `Espaço` |

## Como executar

### Pelo editor da Godot

1. Instale a **Godot 4.7** ou uma versão compatível com o projeto.
2. Importe a pasta do repositório no Project Manager da Godot.
3. Abra o projeto e pressione `F6` ou `F5` para executar a cena principal.
4. Na tela inicial, escolha `START` ou `ENDLESS MODE`.

A cena principal está definida em `scenes/main.tscn` e o projeto utiliza resolução de viewport de 1280x720.

### Usando os arquivos exportados

Os executáveis exportados ficam na pasta `build/`. No Linux, execute:

```bash
./build/Trabalho1.x86_64
```

Também é possível gerar uma nova exportação pela Godot usando os presets `Windows Desktop` ou `Linux` definidos em `export_presets.cfg`.

## Tecnologias

- **Engine:** Godot 4.7
- **Linguagem:** GDScript

## Estrutura do projeto

```text
scenes/   Cenas do jogador, inimigos, bolhas, plataformas e arena
scripts/  Lógica de jogo, movimentação, inimigos e geração de objetos
sprites/  Sprites e recursos visuais
build/    Arquivos exportados do projeto
```

## Créditos

- **Discente:** Bruno dos Santos Silva
- **Matrícula:** 201935031
- **Recursos visuais:** pacote `Snoblin Pixel RPG Prototype Characters`, incluído em `sprites/`. Consulte o arquivo `README.pdf` do pacote para as informações originais de licença e autoria.
