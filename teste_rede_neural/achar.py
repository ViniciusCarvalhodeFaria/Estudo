import os

caminho_relativo = r"saida\curriculo.txt"

if os.path.exists(caminho_relativo):
    print("O arquivo existe no caminho absoluto abaixo:")
    print(os.path.abspath(caminho_relativo))
else:
    print("O arquivo não foi encontrado na pasta de execução atual.")