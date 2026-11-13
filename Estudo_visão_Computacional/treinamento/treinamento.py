from ultralytics import YOLO
import multiprocessing

if __name__ == "__main__":
    multiprocessing.freeze_support() #prevenção de erros

    model = YOLO("yolo11n.pt")

    results = model.train( data = "data.yaml", #arquivo de treino 
                        epochs = 100, # numero de epocas
                        imgsz = 640, # tamanho das imagens
                        batch=16,# tamanho do conjunto das imagens
                        workers =0, # forçar o carregamento
                        patience = 5, # para caso o modelo pare de evoluir
                        device = "cpu") # usar  a cpu


    print ( " treinamento concluido")
