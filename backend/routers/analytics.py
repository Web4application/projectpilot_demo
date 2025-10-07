from .database import SessionLocal, Metric
from fastapi import Depends
import random, time, datetime

@router.get("/metrics/db")
def get_metrics_db():
    db = SessionLocal()
    m = Metric(
        accuracy=round(random.uniform(85, 99), 2),
        speed=random.randint(200, 600),
        users=random.randint(5, 120)
    )
    db.add(m)
    db.commit()
    return {"id": m.id, "accuracy": m.accuracy}
