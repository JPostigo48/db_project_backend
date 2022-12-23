import { Router } from "express"

import { getProductos, createProductosCelular, createProductosPlan } from "../controllers/productos.controllers.js"

const router = Router()

router.get("/productos/lista", getProductos)

router.post("/productos/nuevo/celular", createProductosCelular)
router.post("/productos/nuevo/plan", createProductosPlan)

export default router