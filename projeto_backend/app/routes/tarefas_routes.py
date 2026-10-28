from fastapi import APIRouter
from app.controllers.tarefas_controller import(
    listar_tarefas,
    criar_tarefa,
    calcular_pontuacao_total
)

from app.model.tarefa_model import Tarefa
router = APIRouter(prefix="/gerenciar", tags=["Gerenciador"])

@router.get("/tarefas")
def get_tarefas():
    return listar_tarefas()

@router.post("/tarefas")
def post_tarefas(tarefa: Tarefa):
    return criar_tarefa(tarefa)

@router.get("/pontuacao")
def get_pontos():
    return calcular_pontuacao_total()


