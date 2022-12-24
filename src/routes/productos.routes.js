import { Router } from "express"

import { getProductosCelular, getCelularPorId, createProductosCelular, createProductosPlan, getProductosPlan, createCompraCelular } from "../controllers/productos.controllers.js"

const router = Router()

router.get("/productos/lista", getProductosCelular)
router.get("/planes/lista", getProductosPlan)

router.post("/productos/celular", getCelularPorId)
router.post("/productos/celular/compra", createCompraCelular)
router.post("/productos/nuevo/celular", createProductosCelular)
router.post("/productos/nuevo/plan", createProductosPlan)

export default router