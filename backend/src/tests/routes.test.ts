import request from 'supertest';
import express from 'express';
import routes from '../routes';
import bodyParser from 'body-parser';
import cors from 'cors';
import pool from '../db';

const app = express();
app.use(cors());
app.use(bodyParser.json());
app.use('/api', routes);

beforeAll(async () => {
});

afterAll(async () => {
    await pool.end();
});

describe('POST /api/click', () => {
    it('should log a click and return the click data', async () => {
        const response = await request(app).post('/api/click').send({});
        expect(response.status).toBe(201);
        expect(response.body).toHaveProperty('id');
        expect(response.body).toHaveProperty('count', 1);
    });
});

describe('GET /api/total_clicks', () => {
    it('should return the total number of clicks', async () => {
        const response = await request(app).get('/api/total_clicks');
        expect(response.status).toBe(200);
        expect(response.body).toHaveProperty('total_clicks');
    });
});