import jwt from 'jsonwebtoken';
import { JWT_SECRET, JWT_REFRESH_SECRET } from '../config/jwt.js';

export const generateAccessToken = (user) => {
  return jwt.sign({ id: user.id, role: user.role }, JWT_SECRET, { expiresIn: '15m' });
};

export const generateRefreshToken = (user) => {
  return jwt.sign({ id: user.id }, JWT_REFRESH_SECRET, { expiresIn: '7d' });
};

export const verifyToken = (token) => jwt.verify(token, JWT_SECRET);
export const verifyRefreshToken = (token) => jwt.verify(token, JWT_REFRESH_SECRET);
