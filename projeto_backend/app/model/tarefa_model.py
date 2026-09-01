from pydantic import BaseModel
from typing import Literal

class Tarefa(BaseModel):
    id: int
    descricao: str
    pontuacao: float
    tipo: Literal["Atrasada", "finalizada", "Pendente"]
