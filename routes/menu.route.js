// ✅ routes/menuRoutes.js
import express from 'express';
import { fetchMenus } from '../controllers/menu.controller.js';
import { authenticateToken } from '../middlewares/authMiddleware.js';

const router = express.Router();

router.get('/', authenticateToken, fetchMenus);

export default router;