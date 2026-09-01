from app.database.fake_db import tarefas
from app.model.tarefa_model import Tarefa

def listar_tarefas():
    return tarefas

def criar_tarefa(tarefa: Tarefa):
    tarefas.append(tarefa.model_dump())
    return tarefa

def calcular_pontuacao_total():
    pontuacao_total = 0
    for t in tarefas:
        if t["tipo"] == "feita":
            pontuacao_total += t["pontuacao"]
    return {"pontuacao_total": pontuacao_total}