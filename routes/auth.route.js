import express from 'express';
import {
  register,
  login,
  refresh,
  logout,
  forgotPassword,
  resetUserPassword
} from '../controllers/auth.controller.js';

const router = express.Router();

router.post('/register', register);
router.post('/login', login);
router.post('/refresh', refresh);
router.post('/logout', logout);
router.post('/forgot-password', forgotPassword);
router.post('/reset-password', resetUserPassword);

export default router;
