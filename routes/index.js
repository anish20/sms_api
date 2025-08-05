import express from "express";
import authRoutes from "./auth.route.js";
import userRoutes from "./user.route.js";
import menuRoutes from "./menu.route.js";

const router = express.Router();

// Base route registration
router.use("/auth", authRoutes);
router.use("/users", userRoutes);
router.use("/menus", menuRoutes);

export default router;
