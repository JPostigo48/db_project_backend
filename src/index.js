import express from "express"
import morgan from "morgan"
import cors from "cors"

import usuariosRoutes from "./routes/usuarios.routes.js"
import productosRoutes from "./routes/productos.routes.js"
import empleadosRoutes from "./routes/empleados.routes.js"

const app = express()

app.use(express.json())

app.use(cors({
  origin: "http://localhost:3000"
}))

app.use(morgan('dev'))

app.use(usuariosRoutes)
app.use(productosRoutes)
app.use(empleadosRoutes)

app.listen(5000)
console.log("Server running in port 5000")