import { pool } from "../config/db.js"
import jwt from "jsonwebtoken"

export const validateUsuarios = async (req, res) => {
  const { dni_cliente, clave } = req.body;
  
  const [result] = await pool.query(`SELECT Validar_Cliente_Funcion('${dni_cliente}','${clave}');`)

  const token = jwt.sign({id:result},"SecretJWT");
  res.cookie("t", token, { expire: new Date() + 9999 });
  return res.json({
    token,
    user: { dni_cliente, "CARGO":3 },
    domain: "EPCC",
  });
};

export const getUsuarios = async (req, res) => {
  const [result] = await pool.query("SELECT * FROM cliente;")
  res.json(result)
}

export const getUsuariosConsultas = async (req, res) => {
  const { dni_cliente } = req.body 
  const [result] = await pool.query(`CALL Historial_Consultas_Cliente("${dni_cliente}");`)
  res.json(result)
}

export const createUsuarios = async (req, res) => {
  const { dni_cliente, nombres, primer_apellido, segundo_apellido, direccion, fecha_nacimiento, email, clave, id_distrito } = req.body;
  
  const [result] = await pool.query(`CALL Agregar_Cliente('${dni_cliente}','${nombres}','${primer_apellido}','${segundo_apellido}','${direccion}','${fecha_nacimiento}','${email}','${clave}','${id_distrito}');`)
  res.json(result)
}