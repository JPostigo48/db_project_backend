import { pool } from "../config/db.js"
import jwt from "jsonwebtoken"

export const validateUsuarios = async (req, res) => {
  const { usuario_empl, clave_empl } = req.body;
  
  const [result] = await pool.query(`CALL Validar_Empleado('${usuario_empl}','${clave_empl}');`)

  const token = jwt.sign("SecretJWT");
  res.cookie("t", token, { expire: new Date() + 9999 });
  return res.json({
    token,
    user: { dni_cliente, nombres, primer_apellido, segundo_apellido, direccion, fecha_nacimiento, email },
    domain: "EPCC",
    role: 3,
  });
};

export const getUsuarios = async (req, res) => {
  const [result] = await pool.query("SELECT * FROM cliente;")
  res.json(result)
}

export const createUsuarios = async (req, res) => {
  const { dni_cliente, nombres, primer_apellido, segundo_apellido, direccion, fecha_nacimiento, email, clave } = req.body;
  
  const [result] = await pool.query(`INSERT INTO 'Cliente' ('dni_cliente','nombres','primer_apellido','segundo_apellido','direccion','fecha_nacimiento','email','clave') VALUES ('${dni_cliente}','${nombres}','${primer_apellido}','${segundo_apellido}','${direccion}','${fecha_nacimiento}','${email}','${clave}');`)
  res.json(result)
}