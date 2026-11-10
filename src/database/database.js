import pg from "pg";
import { config } from "../config.js";
const { Pool } = pg;

const pool = new Pool({
    host: config.db.host,
    port: config.db.port,
    database: config.db.name,
    user: config.db.user,
    password: config.db.password,
    max: config.db.poolMax
});

export const query = (q, params = []) => {
    return pool.query(q, params);
};

export const checkConnection = async () => {
    const result = await query(
        "SELECT current_user, current_database();"
    );

    return result.rows[0];
}

