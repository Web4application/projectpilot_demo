from fastapi import APIRouter

router = APIRouter()

@router.get("/projects")
def list_projects():
    return [
        {"id": 1, "title": "AI Simulation Engine", "author": "Web4 Labs"},
        {"id": 2, "title": "Quantum Pilot", "author": "Yakub Seriki"},
    ]
