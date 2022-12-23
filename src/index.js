import express from "express";

import usuariosRoutes from "./routes/usuarios.routes.js"
import productosRoutes from "./routes/productos.routes.js"

const app = express()

app.use(express.json())

app.use(usuariosRoutes)
app.use(productosRoutes)

// app.get('/inicio', (req, res) => res.send("Hola Mundo"))

app.listen(3000)
console.log("Server running in port 3000")