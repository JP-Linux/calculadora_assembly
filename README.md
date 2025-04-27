# Calculadora em Assembly x86_64

Este é um programa simples de calculadora escrito em Assembly x86_64 (NASM) para sistemas Linux. Ele realiza operações básicas de adição, subtração, multiplicação e divisão com números inteiros.

## Funcionalidades
- Entrada de dois números inteiros (suporta negativos)
- Escolha de operador matemático (`+`, `-`, `*`, `/`)
- Tratamento de erros:
  - Divisão por zero
  - Operador inválido
- Exibição clara do resultado

## Pré-requisitos
- NASM (Netwide Assembler) instalado
- Sistema Linux x86_64
- Conhecimento básico de linha de comando

## Compilação e Execução

1. **Montar o código:**
```bash
nasm -f elf64 calculadora.asm -o calculadora.o
```

2. **Linkeditar:**
```bash
ld -s -o calculadora calculadora.o
```

3. **Executar:**
```bash
./calculadora
```

## Uso
1. Ao executar, digite:
   - Primeiro número
   - Segundo número
   - Operador matemático

2. Exemplo:
```
Digite o primeiro número: -15
Digite o segundo número: 5
Operação (+, -, *, /): /
Resultado: -3
```

## Estrutura do Código

### Seções Principais
- **.data:** Mensagens estáticas e constantes
- **.bss:** Buffers para armazenamento de entrada/saída
- **.text:** Lógica principal do programa

### Funções Relevantes
- `_start:` Ponto de entrada do programa
- `atoi:` Converte string para inteiro
- `itoa:` Converte inteiro para string
- `strlen:` Calcula tamanho da string

### Fluxo Principal
1. Captura e validação das entradas
2. Conversão para valores numéricos
3. Execução da operação matemática
4. Tratamento de erros
5. Exibição do resultado

## Limitações
- Trabalha apenas com números inteiros
- Divisão sempre retorna resultado inteiro
- Buffer limitado a 16 caracteres para entrada numérica

## Tratamento de Erros
- **Erro de divisão por zero:** Exibe mensagem específica
- **Operador inválido:** Informa sobre operação não suportada

## Observações
Desenvolvido como exercício de programação em baixo nível, demonstrando:
- Manipulação direta de registradores
- Chamadas de sistema Linux
- Conversão entre diferentes representações numéricas
- Gerenciamento de memória
