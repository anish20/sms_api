import bcrypt from 'bcrypt';
import {
  findUserByEmail,
  createUser,
  updateResetToken,
  resetPassword
} from '../services/auth.service.js';
import {
  generateAccessToken,
  generateRefreshToken
} from '../utils/tokenUtils.js';
import { sendEmail } from '../utils/mailer.js';
import { updateRefreshToken } from '../services/user.service.js';

export const register = async (req, res) => {
  const { name, email, password, role } = req.body;
  const existing = await findUserByEmail(email);
  if (existing) return res.status(409).json({ message: 'Email already exists' });
  const user = await createUser(name, email, password, role);
  res.status(201).json({ user });
};

export const login = async (req, res) => {
  const { email, password } = req.body;
  const user = await findUserByEmail(email);
  if (!user || !(await bcrypt.compare(password, user.password)))
    return res.status(401).json({ message: 'Invalid credentials' });

  const accessToken = generateAccessToken(user);
  const refreshToken = generateRefreshToken(user);

  // 🔐 Store the refreshToken in DB
  await updateRefreshToken(user.id, refreshToken);

  res.json({
    accessToken,
    refreshToken,
    user: {
      id: user.id,
      name: user.name,
      email: user.email,
      role: user.role,
    },
  });
};

export const refresh = async (req, res) => {
  const { refreshToken } = req.body;
  try {
    const payload = verifyRefreshToken(refreshToken);
    const user = await findUserByEmail(payload.email);
    const newAccessToken = generateAccessToken(user);
    res.json({ accessToken: newAccessToken });
  } catch {
    res.status(403).json({ message: 'Invalid refresh token' });
  }
};

export const logout = async(req, res) => {
const userId = req.user.id; // Ensure you get this from decoded token
  await updateRefreshToken(userId, null); // Clear token
  res.json({ message: 'Logged out' });
};

export const forgotPassword = async (req, res) => {
  const { email } = req.body;
  const user = await findUserByEmail(email);
  if (!user) return res.status(404).json({ message: 'User not found' });

  const token = Math.random().toString(36).substr(2);
  const expiry = new Date(Date.now() + 15 * 60 * 1000); // 15 mins
  await updateResetToken(email, token, expiry);
  await sendEmail(email, 'Reset Password', `Reset Token: ${token}`);
  res.json({ message: 'Reset email sent' });
};

export const resetUserPassword = async (req, res) => {
  const { token, newPassword } = req.body;
  const user = await resetPassword(token, newPassword);
  if (!user) return res.status(400).json({ message: 'Invalid/expired token' });
  res.json({ message: 'Password reset successful' });
};
