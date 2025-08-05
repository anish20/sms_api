import pool from '../config/db.js';
import bcrypt from 'bcrypt';

export const findUserByEmail = async (email) => {
  const [rows] = await pool.query('SELECT * FROM users WHERE email = ?', [email]);
  return rows[0];
};

export const createUser = async (name, email, password, role) => {
  const hash = await bcrypt.hash(password, 10);
  const [result] = await pool.query('INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)', [name, email, hash, role]);
  return { id: result.insertId, name, email, role };
};

export const updateResetToken = async (email, token, expiry) => {
  await pool.query('UPDATE users SET reset_token = ?, reset_token_expiry = ? WHERE email = ?', [token, expiry, email]);
};

export const resetPassword = async (token, newPassword) => {
  const [rows] = await pool.query('SELECT * FROM users WHERE reset_token = ?', [token]);
  if (!rows.length) return null;
  const user = rows[0];
  const now = new Date();
  if (now > user.reset_token_expiry) return null;

  const hashed = await bcrypt.hash(newPassword, 10);
  await pool.query('UPDATE users SET password = ?, reset_token = NULL, reset_token_expiry = NULL WHERE id = ?', [hashed, user.id]);
  return user;
};
