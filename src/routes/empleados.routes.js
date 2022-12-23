import { Router } from "express"

import { validateEmpleados, getEmpleados, createEmpleados } from "../controllers/empleados.controllers.js"

const router = Router()

router.get("/empleados/lista", getEmpleados)

router.post("/empleados/validar", validateEmpleados)
router.post("/empleados/nuevo", createEmpleados)

export default router