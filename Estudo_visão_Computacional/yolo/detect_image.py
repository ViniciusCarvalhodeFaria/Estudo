from ultralytics import YOLO

model = YOLO("yolo11n.pt")
results = model("foto.jpg", save=True)

print("Concluido")