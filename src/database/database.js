import pg from "pg";
import { config } from "../config.js";
const { Pool } = pg;

const pool = new Pool({
    host: config.db.host,
    port: config.db.port,
    database: config.db.name,
    user: config.db.user,
    password: config.db.password,
    max: 10
});

export const query = (q, params) => {
    return pool.query(q, params);
};

