import { Router } from 'express';
import pool from './db';

const router = Router();

router.post('/click', async (req, res) => {
    try {
        const result = await pool.query('INSERT INTO clicks (count) VALUES (1) RETURNING *',);
        res.status(201).json(result.rows[0]);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});

router.get('/total_clicks', async (req, res) => {
    try {
        const result = await pool.query('SELECT SUM(count) as total_clicks FROM clicks');
        res.status(200).json(result.rows[0]);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});

export default router;