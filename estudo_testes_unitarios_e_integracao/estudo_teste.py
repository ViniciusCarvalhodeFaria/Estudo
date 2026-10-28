class bancoMemoria:
    def __init__(self):
        self.usuarios = {}
        #dict: id-> dict com os campos do usuário
    def table(self, nome):
        if nome != "usuario":
            raise AssertionError(f"tabela inesperada: {nome}")
        return Consulta(self)

    # imita a chamada do supabase que chama um banco.table("usuario").select("*").eq("id",x).execute()

class Consulta:
    def __init__ (self, banco):
        self.banco = banco
        self.operacao = "select"
        self.filtros = []
        self.dados = None
        
    def select(self, _campos):
        self.operacao = "select"
        return self
    #guarda a operacao

    def eq(self, campo, valor):
        self.filtros.append((campo, valor))
        return self
    #salva tupla ex: eq("email","ana@example.com") virando [("email","ana@example.com")]

    def insert(self, dados):
        self.operacao = "insert"
        self.dados = dict(dados)
        return self
    # guarda a operação e faz uma copia dos dados

    def update(self, dados):
        self.operacao = "update"
        self.dados = dict(dados)
        return self
    # igual o insert mas guarda que foi um update

    def delete(self):
        self.operacao = "delete"
        return self  
    # só marca a operacao



def execute(self):
    from types import SimpleNamespace
    from uuid import uuid4

    encontrados = [
        u for u in self.banco.usuarios.values()
        if all(u.get(c) == v for c, v in self.filtros)
    ]