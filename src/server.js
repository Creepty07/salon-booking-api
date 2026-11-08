import app from "./app.js";
import { config } from "./config.js";

const PORT = config.port;

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
    console.log(`If case you are in dev mode: http://localhost:${PORT}`);
});