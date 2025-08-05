import express from 'express';
import {
  listUsers,
  getUser,
  createNewUser,
  editUser,
  removeUser
} from '../controllers/user.controller.js';
import { authenticateToken } from '../middlewares/authMiddleware.js';
import { authorizeRoles } from '../middlewares/roleMiddleware.js';

const router = express.Router();

router.get('/', authenticateToken, authorizeRoles('admin'), listUsers);
router.get('/:id', authenticateToken, authorizeRoles('admin'), getUser);
router.post('/', authenticateToken, authorizeRoles('admin'), createNewUser);
router.put('/:id', authenticateToken, authorizeRoles('admin'), editUser);
router.delete('/:id', authenticateToken, authorizeRoles('admin'), removeUser);

export default router;