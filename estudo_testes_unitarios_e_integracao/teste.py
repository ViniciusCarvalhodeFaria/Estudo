import unittest
import bcrypt

class teste_hash(unittest.TestCase):
    def teste_hash_e_diferente(self):
        senha = "123"

        hash_gerado = bcrypt.hashpw(senha.encode("utf-8"), bcrypt.gensalt(rounds=12)).decode("utf-8")

        self.assertNotEqual(senha, hash_gerado)