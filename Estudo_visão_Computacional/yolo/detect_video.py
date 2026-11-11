from ultralytics import YOLO

model = YOLO("yolo11n.pt")

results = model.predict (
    source = "video.mp4",
    save = True,
    device = "cpu"
    )
