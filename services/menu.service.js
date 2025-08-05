import pool from '../config/db.js';

export const getMenusByRole = async (role) => {
  const [rows] = await pool.query(
    `SELECT m.* FROM menus m
     JOIN role_menu_map rmm ON m.id = rmm.menu_id
     JOIN roles r ON rmm.role_id = r.id
     WHERE r.name = ? AND m.is_active = 1
     ORDER BY m.parent_id, m.id`,
    [role]
  );
  return rows;
};