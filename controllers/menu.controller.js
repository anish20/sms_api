import { getMenusByRole } from '../services/menu.service.js';

export const fetchMenus = async (req, res) => {
  const role = req.user.role;
  const menus = await getMenusByRole(role);
  res.json(menus);
};
