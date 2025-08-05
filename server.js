import express from 'express';
import dotenv from 'dotenv';
import cors from 'cors';
import routes from './routes/index.js';

dotenv.config();
const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// ✅ Home welcome route
app.get('/', (req, res) => {
  res.send('🚀 Welcome to the Dashboard API!');
});

// ✅ Main API routes
app.use('/api', routes);

// ❌ 404 Not Found middleware
app.use((req, res, next) => {
  res.status(404).json({
    success: false,
    message: 'Route not found',
  });
});

// ❌ Global error handler (optional, recommended)
app.use((err, req, res, next) => {
  console.error(err.stack); // log full error in terminal
  res.status(500).json({
    success: false,
    message: '🚨 Internal Server Error',
  });
});

// Start server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () =>
  console.log(`🚀 Server running on http://localhost:${PORT}`)
);
