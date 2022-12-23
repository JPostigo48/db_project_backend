import { Router } from "express"

import { getUsuarios, createUsuarios } from "../controllers/usuarios.controllers.js"

const router = Router()

router.get("/usuarios/lista", getUsuarios)

router.post("/usuarios/nuevo", createUsuarios)

export default router