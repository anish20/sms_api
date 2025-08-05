// ✅ controllers/userController.js
import {
  getAllUsers,
  getUserById,
  createUser,
  updateUser,
  deleteUser
} from '../services/user.service.js';
import bcrypt from 'bcrypt';

export const listUsers = async (req, res) => {
  const users = await getAllUsers();
  res.json(users);
};

export const getUser = async (req, res) => {
  const user = await getUserById(req.params.id);
  if (!user) return res.status(404).json({ message: 'User not found' });
  res.json(user);
};

export const createNewUser = async (req, res) => {
  const { name, email, password, role } = req.body;
  const hash = await bcrypt.hash(password, 10);
  const user = await createUser({ name, email, password: hash, role });
  res.status(201).json(user);
};

export const editUser = async (req, res) => {
  await updateUser(req.params.id, req.body);
  res.json({ message: 'User updated' });
};

export const removeUser = async (req, res) => {
  await deleteUser(req.params.id);
  res.json({ message: 'User deleted' });
};

