import pool from "../config/db.js";
export const verifyUserExistByEmail = async (email) => {
  const [rows] = await pool.query("SELECT email FROM t_user WHERE email = ?", [email]);
  return rows;
};
export const getUserPasswordByEmail = async (email) => {
  const [rows] = await pool.query("SELECT password FROM t_user WHERE email = ?", [email]);
  if (rows.length > 0) {
    return rows[0].password;
  } else {
    return null;
  }
};
export const getUserInfoByEmail = async (email) => {
  const [rows] = await pool.query("SELECT id, name, email, avatar, phone, nickname, tag, company, domain, birth, remark, gender, link, readme, country, fan_count, follow_count, like_count, book_count, note_count, cover FROM t_user WHERE email = ?", [email]);
  if (rows.length > 0) {
    return rows[0];
  } else {
    return null;
  }
};
export const initUserByEmail = async (email, password) => {
  const name = `maxpure_${email.split("@")[0]}`
  const [result] = await pool.query(
    "INSERT INTO t_user (email, name, password, online) VALUES (?, ?, ?, 0)",
    [email, name, password]
  );
  return result.insertId;
};
