import { Router } from "express"

import { getProductosCelular, createProductosCelular, createProductosPlan } from "../controllers/productos.controllers.js"

const router = Router()

router.get("/productos/lista", getProductosCelular)

router.post("/productos/nuevo/celular", createProductosCelular)
router.post("/productos/nuevo/plan", createProductosPlan)

export default router