import { Router } from "express"

import { getUsuarios, validateUsuarios, createUsuarios, getUsuariosConsultas } from "../controllers/usuarios.controllers.js"

const router = Router()

router.get("/usuarios/lista", getUsuarios)

router.post("/usuarios/validar", validateUsuarios)
router.post("/usuarios/consultas", getUsuariosConsultas)
router.post("/usuarios/nuevo", createUsuarios)

export default router