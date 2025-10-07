from fastapi import APIRouter, UploadFile, File
import pandas as pd
from io import BytesIO

router = APIRouter()

@router.post("/upload")
async def upload_data(file: UploadFile = File(...)):
    df = pd.read_csv(BytesIO(await file.read()))
    return {"rows": len(df), "columns": list(df.columns)}
