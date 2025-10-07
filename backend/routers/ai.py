from fastapi import APIRouter
from pydantic import BaseModel

router = APIRouter()

class AITask(BaseModel):
    prompt: str

@router.post("/run")
def run_ai_task(task: AITask):
    result = f"AI processed your task: '{task.prompt[:40]}' ..."
    return {"output": result, "status": "completed"}
