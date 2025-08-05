import pool from '../config/db.js';

export const getAllUsers = async () => {
  const [rows] = await pool.query('SELECT id, name, email, role FROM users');
  return rows;
};

export const getUserById = async (id) => {
  const [rows] = await pool.query('SELECT id, name, email, role FROM users WHERE id = ?', [id]);
  return rows[0];
};

export const createUser = async ({ name, email, password, role }) => {
  const [result] = await pool.query(
    'INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)',
    [name, email, password, role]
  );
  return { id: result.insertId, name, email, role };
};

export const updateUser = async (id, { name, email, role }) => {
  await pool.query('UPDATE users SET name = ?, email = ?, role = ? WHERE id = ?', [name, email, role, id]);
};

export const deleteUser = async (id) => {
  await pool.query('DELETE FROM users WHERE id = ?', [id]);
};

export const updateRefreshToken = async (userId, token) => {
  const [result] = await pool.query(
    "UPDATE users SET refresh_token = ? WHERE id = ?",
    [token, userId]
  );
  return result;
};