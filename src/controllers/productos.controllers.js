import { pool } from "../config/db.js"

export const getProductosCelular = async (req, res) => {
  const [result] = await pool.query("SELECT * FROM celular;")
  return res.json(result)
}

export const createProductosCelular = async (req, res) => {
  const { precio, stock, modelo } = req.body
  const [result] = await pool.query(`CALL Nuevo_Producto_Celular('${precio}','${stock}','${modelo}');`)
  return res.json(result)
}

export const createProductosPlan = async (req, res) => {  
  const { precio, stock, nombre, descripcion, gigas, minutos, mensajes } = req.body
  const [result] = await pool.query(`CALL Nuevo_Producto_Plan('${precio}','${stock}','${nombre}','${descripcion}','${gigas}','${minutos}','${mensajes}');`)
  return res.json(result)
}