import { pool } from "../config/db.js"

export const getUsuarios = async (req, res) => {
  const [result] = await pool.query("SELECT * FROM cliente;")
  res.json(result)
}

export const createUsuarios = async (req, res) => {
  const [result] = await pool.query("CALL Nuevo_Producto_Celular(`750.00`,`15`,`Redmi Note 10 Pro`);")
  res.json(result)
}


// const [result] = await pool.query("CALL Nuevo_Producto_Celular(`750.00`,`15`,`Redmi Note 10 Pro`);")