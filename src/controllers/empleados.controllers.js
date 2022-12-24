import { pool } from "../config/db.js"
import jwt from "jsonwebtoken"

export const validateEmpleados = async (req, res) => {
  const { usuario_empl, clave_empl } = req.body;
  
  const [result] = await pool.query(`CALL Validar_Empleado('${usuario_empl}','${clave_empl}');`)

  const token = jwt.sign({id:result[0][0].ID},"SecretJWT");
  res.cookie("t", token, { expire: new Date() + 9999 });
  return res.json({
    token,
    user: result[0][0],
    domain: "EPCC",
  });
};

export const getEmpleados = async (req, res) => {
  const [result] = await pool.query("SELECT * FROM empleado;")
  res.json(result)
}

export const createEmpleados = async (req, res) => {
  const { nombres, primer_apellido, segundo_apellido, fech_nac, celular, clave, ID_base } = req.body;
  
  const [result] = await pool.query(`CALL Agregar_Empleado ('${nombres}','${primer_apellido}','${segundo_apellido}','${fech_nac}','${celular}','${clave}','${ID_base}');`)
  res.json(result)
}