import json
import csv

input_path = "data/raw/aeroplane_model.json"
output_path = "seeds/aeroplane_model.csv"

with open(input_path, "r") as f:
    data = json.load(f)

rows = []
for manufacturer, models in data.items():
    for model, attrs in models.items():
        rows.append({
            "manufacturer": manufacturer,
            "model": model,
            "max_seats": attrs.get("max_seats"),
            "max_weight": attrs.get("max_weight"),
            "max_distance": attrs.get("max_distance"),
            "engine_type": attrs.get("engine_type")
        })

with open(output_path, "w", newline="") as f:
    writer = csv.DictWriter(
        f,
        fieldnames=["manufacturer", "model", "max_seats", "max_weight", "max_distance", "engine_type"]
    )
    writer.writeheader()
    writer.writerows(rows)

print(f"✅ Wrote {len(rows)} rows to {output_path}")
