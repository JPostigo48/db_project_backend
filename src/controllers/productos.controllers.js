import { pool } from "../config/db.js"

export const getProductosCelular = async (req, res) => {
  const [result] = await pool.query("SELECT c.id_producto, c.modelo, p.imagen FROM celular c INNER JOIN producto p WHERE c.id_producto=p.id_producto;")
  return res.json(result)
}

export const getProductosPlan = async (req, res) => {
  const [result] = await pool.query("SELECT * FROM plan;")
  return res.json(result)
}

export const getCelularPorId = async (req, res) => {
  console.log(req.body)
  const { id_producto_cel } = req.body
  const [result] = await pool.query(`CALL Info_Celular('${id_producto_cel}');`)
  return res.json(result[0][0])
}

export const createCompraCelular = async (req, res) => {
  const { new_hora, new_fecha, dnicliente, idproducto } = req.body
  const [result] = await pool.query(`CALL Hacer_Compra('${new_hora}','${new_fecha}','${dnicliente}','${idproducto}');`)
  return res.json(result)
}


export const createProductosCelular = async (req, res) => {
  const { precio, stock, modelo, imagen } = req.body
  const [result] = await pool.query(`CALL Nuevo_Producto_Celular('${precio}','${stock}','${modelo}','${imagen}');`)
  return res.json(result)
}

export const createProductosPlan = async (req, res) => {  
  const { precio, stock, nombre, descripcion, gigas, minutos, mensajes } = req.body
  const [result] = await pool.query(`CALL Nuevo_Producto_Plan('${precio}','${stock}','${nombre}','${descripcion}','${gigas}','${minutos}','${mensajes}');`)
  return res.json(result)
}