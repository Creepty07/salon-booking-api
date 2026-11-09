import app from "./app.js";
import { config } from "./config.js";
import { query } from './database/database.js';

const PORT = config.port;

const q = "SELECT current_user, current_database();";

const result = await query(
    q, []
);

console.log(result.rows)

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});