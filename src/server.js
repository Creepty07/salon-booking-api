import app from "./app.js";
import { config } from "./config.js";
import { checkConnection } from './database/database.js';

const PORT = config.port;

try {
    const { current_user, current_database } = await checkConnection();
    console.log(`Connected to ${current_database} as ${current_user}`);
} catch (error) {
    console.error("Database connection failed: ", error.message);
    process.exit(1);
}

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});

