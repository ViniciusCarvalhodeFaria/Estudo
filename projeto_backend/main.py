from fastapi import FastAPI
from app.routes.tarefas_routes import router as tarefas_router

app = FastAPI(title="API controller gerenciador de tarefas")

app.include_router(tarefas_router)

@app.get("/")
def home():
    return {"mensagem": "backend de gerenciador de tarefas com FastAPI"}