const required = ['PORT', 'DB_HOST', 'DB_PORT', 'DB_NAME', 'DB_USER', 'DB_PASSWORD'];
const missing = required.filter((key) => !process.env[key]);

const PORT = Number(process.env.PORT);
const DB_PORT = Number(process.env.DB_PORT);

if (missing.length > 0) {
    throw new Error(`Missing environment variables ${missing.join(', ')}`);
}

if (!Number.isInteger(PORT) || !Number.isInteger(DB_PORT)) {
    throw new Error('PORT and DB_PORT must be integer values.')
}

export const config = {
    port: PORT,
    db: {
        host: process.env.DB_HOST,
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        port: DB_PORT,
        name: process.env.DB_NAME
    }
}

