// server.js
import express from "express";
import mysql from "mysql2/promise";
import cors from "cors";
import dotenv from "dotenv";
import helmet from "helmet";
import rateLimit from "express-rate-limit";

dotenv.config();

const app = express();
app.use(helmet());
app.use(cors()); // in production restrict origin
app.use(express.json());

app.use(rateLimit({ windowMs: 60 * 1000, max: 60 })); // basic rate limit

// create pool using env vars
const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_NAME,
  waitForConnections: true,
  connectionLimit: 10,
});

app.post("/contact", async (req, res) => {
  try {
    const { name, email, message } = req.body;
    if (!name || !email || !message) {
      return res.status(400).json({ error: "Missing fields" });
    }
    const sql = "INSERT INTO messages (name, email, message) VALUES (?, ?, ?)";
    await pool.execute(sql, [name, email, message]);
    return res.json({ success: true });
  } catch (err) {
    console.error("DB error:", err);
    return res.status(500).json({ error: "Server error" });
  }
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));




