import cv2 # biblioteca da camera
from ultralytics import YOLO

model = YOLO("best.pt") # puxar a biblioteca do YOLO

cap = cv2.VideoCapture(0) #chama a webcam

while True:
    ret, frame = cap.read() #ler os frames

    if not ret: 
        break

    results = model(frame) #joga os frames no model
    annoted_frames = results[0].plot() #plota os resultados

    cv2.imshow("CDRX - WebCam Example", annoted_frames) #frame tratado

    if cv2.waitKey(1) & 0xFF == 27: # espera ate a tecla 27 ser pressionada
        break

cap.release() # parar de liberar
cv2.destroyAllWindows() #destroi as janelas