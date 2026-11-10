import express from 'express';
import { checkConnection } from '../database/database.js';

const health = express.Router();

health.get('/', (req, res) => {
    return res.send('placeholder')
})

health.get('/db', async (req, res) => {
    try {
        await checkConnection();
        return res.status(200).json({
            status_code: 200,
            db_connection: "up" 
        })
    } catch (error) {
        return res.status(503).json({
            status_code: 503,
            db_connection: "not established"
        })
    }
});

