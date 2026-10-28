#include <stdio.h>   // printf, fopen, fgetc
#include <string.h>  // strcat, strlen
#include <stdlib.h>  // realloc, free
#include <stdbool.h> // tipo bool, true e false

typedef enum {Q0, Q1, Q2, Q3, Q4, Q5, Q6, QLixo} Estado;

const char *nome_estado[] = {"Q0", "Q1", "Q2", "Q3", "Q4", "Q5", "Q6", "QLixo"};

bool eh_digito(char c){
    return (c >= '0') && (c <= '9');
}

bool eh_moeda(const char *s, int inicio, int *fim, bool verbose){
    Estado e = Q0;           // estado atual, começa no inicial
    int i = inicio;          // posição que estou lendo
    char traco[1000] = "Q0"; // caminho percorrido só para depuração

    while (e != QLixo && e != Q6 && s[i] != '\0'){ // continua enquanto nao cair no lixo, nem no estado final e o texto nao acabou
        char c = s[i];

        switch (e){
            case Q0: e = (c == 'R') ? Q1 : QLixo; break;
            case Q1: e = (c == '$') ? Q2 : QLixo; break;
            case Q2:
                if (c == ' ')            e = Q2;
                else if (eh_digito(c))   e = Q3;
                else                     e = QLixo;
                break;
            case Q3:
                if (eh_digito(c))        e = Q3;
                else if (c == ',')       e = Q4;
                else                     e = QLixo;
                break;
            case Q4: e = eh_digito(c) ? Q5 : QLixo; break;
            case Q5: e = eh_digito(c) ? Q6 : QLixo; break;
            default: break;
        }

        if (strlen(traco) + 8 < sizeof(traco)){
            strcat(traco, "->");
            strcat(traco, nome_estado[e]);
        }
        i++;
    }

    if (verbose) printf("Traco a partir da posicao %d: %s\n", inicio, traco);

    if (e == Q6) {
        *fim = i;
        return true;
    }
    return false;
}

int main(int argc, char **argv) {
    // Le o arquivo
    FILE *f = stdin;
    if (argc > 1){
        f = fopen(argv[1], "r");
        if (!f) { perror(argv[1]); return 1; }
    }

    char *texto = NULL;
    size_t tam = 0, cap = 0;
    int c, i, fim;

    /*
    a função fgetc le um caractere do arquivo e devolve o codigo,
    EOF é quando o arquivo acaba, que vale -1
    */
    while ((c = fgetc(f)) != EOF) {
        if (tam + 1 >= cap){ // tam é caracteres guardados e cap é tamanho alocado
            cap = (cap ? cap * 2 : 1024);
            texto = realloc(texto, cap); // muda o tamanho do bloco de memoria
            if (!texto) { perror("realloc"); return 1; }
        }
        texto[tam++] = (char)c;
    }
    if (!texto) return 0;

    texto[tam] = '\0';

    for (i = 0; texto[i]; ){
        if (eh_moeda(texto, i, &fim, false)) {
            printf("%.*s\n", fim - i, texto + i);
            i = fim;
        } else {
            i++;
        }
    }

    free(texto);
    if (f != stdin) fclose(f);
    return 0;
}
